import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path/path.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:syntonic_components/configs/constants/syntonic_date_and_time.dart';
import 'package:syntonic_components/configs/constants/syntonic_language.dart';
import 'package:syntonic_components/configs/themes/syntonic_dark_theme.dart';
import 'package:syntonic_components/configs/themes/syntonic_light_theme.dart';
import 'package:syntonic_components/widgets/banners/syntonic_ad_banner.dart';
import 'package:syntonic_components/widgets/dividers/syntonic_divider.dart';
import 'package:syntonic_components/widgets/enhancers/syntonic_fade.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

import '../services/navigation_service.dart';
import 'base_view_state.dart';
import 'buttons/syntonic_floating_action_button.dart';
import 'app_bars/syntonic_sliver_app_bar.dart';

import 'package:flutter/scheduler.dart';

part '../extensions/syntonic_color_extension.dart';
part '../extensions/syntonic_date_time_extension.dart';
part '../extensions/syntonic_date_time_range_extension.dart';
part '../extensions/syntonic_int_extension.dart';
part '../extensions/syntonic_double_extension.dart';
part '../extensions/syntonic_string_extension.dart';
part '../extensions/syntonic_string_list_extension.dart';
// part '../extensions/time_of_day_extension.dart';

enum PlatformType {
  Android,
  Ios,
  Web,
}

abstract class ExtendedStatelessWidget extends StatelessWidget {
  const ExtendedStatelessWidget({Key? key}) : super(key: key);
}

abstract class ExtendedChangeNotifier extends ChangeNotifier {
  ExtendedChangeNotifier();
}

abstract class ExtendedModel {
  ExtendedModel();
}

Future<void> initializeee() async {
  await Future.delayed(const Duration(seconds: 2)); // 初期化処理
  print('Initialized! + super');
}

// ignore: must_be_immutable
abstract class SyntonicBaseView<VM extends BaseViewModel<VS>,
    VS extends BaseViewState> extends StatelessWidget {
  const SyntonicBaseView({
    Key? key,
    required this.vm,
    this.childViews,
    this.globalKey,
    this.hasAppBar = true,
    this.hasHeader = false,
    this.hasTabBar = false,
    this.isChild = false,
    this.hasFAB = false,
    this.hasFABSecondary = false,
    this.isPage = false,
    this.colorScheme,
    this.hasAds = true,
    this.useStreamBuilder = false,
  }) : super(key: key);

  final VM vm;
  final GlobalKey? globalKey;
  final bool hasAppBar;
  final bool hasHeader;
  final bool hasTabBar;
  final bool isChild;
  final bool hasFAB;
  final bool hasFABSecondary;
  final bool isPage;
  final ColorScheme? colorScheme;
  final bool hasAds;
  final bool useStreamBuilder;

  GlobalKey get _globalKey => globalKey ?? GlobalKey();

  // @protected
  // T vmR(BuildContext context) => context.read<V>();
  //
  // @protected
  // VM vmW(BuildContext context) => context.watch<VM>();

  VM viewModel(riverpod.WidgetRef ref) => ref.read(provider.notifier);
  riverpod.StateNotifierProvider<VM, VS> get provider =>
      riverpod.StateNotifierProvider<VM, VS>((ref) => vm);

  // Function? willPopCallback;
  // PlatformType? platformType;
  // late BuildContext context;

  final List<SyntonicBaseView>? childViews;

  @override
  Widget build(BuildContext context) {
    bool _isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    Widget child() {
      // if (isChild || !hasAds) {
      if (true) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          child: _screen(vm, context),
        );
      } else {
        return Column(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              child: _screen(vm, context),
            )),
            const SyntonicAdBanner()
          ],
        );
      }
    }

    Widget get() {
      return riverpod.Consumer(builder: (context, ref, _) {
        print('baseリビルド+ $runtimeType');
        // if (false) {
        if (colorScheme != null ||
            ref.watch(provider.select((viewState) => viewState.colorScheme)) !=
                null) {
          late ColorScheme _colorScheme;
          if (colorScheme != null) {
            _colorScheme = colorScheme!;
          }

          if (ref.watch(
                  provider.select((viewState) => viewState.colorScheme)) !=
              null) {
            _colorScheme = ref
                .watch(provider.select((viewState) => viewState.colorScheme!));
          }
          return Theme(
            data: _isDarkTheme
                ? darkTheme(colorScheme: _colorScheme)
                : lightTheme(colorScheme: _colorScheme),
            child: ColoredBox(
              color: Theme.of(context).colorScheme.surface,
              child: child(),
            ),
          );
        } else {
          return ColoredBox(
            color: Theme.of(context).colorScheme.surface,
            child: child(),
          );
        }
      });
    }

    return useStreamBuilder ? buildStreamBuilder(context, get())! : get();
  }

  Widget? buildStreamBuilder(
    BuildContext context,
    Widget content,
  ) =>
      null;

  /// Get a screen.
  ///
  /// A screen contains following contents:
  /// [appBar] (Required)
  /// [headerContents] (Optional)
  /// [tabs] (Optional)
  /// [mainContents] (Required)
  /// [floatingActionButton] (Optional)
  ///
  /// Change [appBar] and [floatingActionButton] state to invisible depends on
  /// view permission ([authority.canView]) in account's [model.authority].
  Widget _screen(VM viewModel, BuildContext context) {
    // skip initialization, depending on whether [isInitialized] is "true".
    // Because, A screen is Rebuilt if you focus to any text-field.
    return riverpod.Consumer(builder: (context, ref, child) {
      if (!isChild) {
        viewModel.scrollController = PrimaryScrollController.of(context)
          ..addListener(() {
            print(runtimeType);
            viewModel.offset = viewModel.scrollController!.offset;

            if (viewModel.scrollController!.position.userScrollDirection ==
                ScrollDirection.reverse) {
              if (viewModel.state.isFloatingActionButtonExtended == true) {
                print('ステート更新 + $runtimeType + extended true');
                viewModel.state = viewModel.state
                    .copyWith(isFloatingActionButtonExtended: false) as VS;
              }
            } else if (viewModel
                    .scrollController!.position.userScrollDirection ==
                ScrollDirection.forward) {
              if (viewModel.state.isFloatingActionButtonExtended == false) {
                print('ステート更新 + $runtimeType + extended false');
                viewModel.state = viewModel.state
                    .copyWith(isFloatingActionButtonExtended: true) as VS;
              }
            }
          });
      }
      bool _isInitialized =
          ref.watch(provider.select((viewState) => viewState.isInitialized));
      if (viewModel.state.needsInitialize &&
          !viewModel.state.isInitialized &&
          !viewModel._isInitializing) {
        return FutureBuilder(
          future: viewModel.onInit(context: context),
          builder: (context, projectSnap) {
            if (projectSnap.hasError) {
              return NestedScrollView(
                headerSliverBuilder: (_, __) {
                  return <Widget>[
                    SyntonicSliverAppBar(
                        isFullscreenDialog: hasAppBar
                            ? appBar(context: context, ref: ref)!
                                .isFullscreenDialog
                            : false,
                        title: hasAppBar
                            ? appBar(context: context, ref: ref)!.title
                            : null),
                  ];
                },
                body: _errorScreen,
              );
            } else if (projectSnap.connectionState == ConnectionState.done) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                this.viewModel(ref).initialize = true;
              });
              return _body(context: context, ref: ref);
            } else {
              if (viewModel.state.isSkeletonLoadingApplied) {
                return _body(context: context, ref: ref);
              } else {
                return Stack(children: [
                  Scaffold(
                    resizeToAvoidBottomInset: false,
                    drawer: hasAppBar
                        ? navigationDrawer(
                            context: context,
                          )
                        : null,
                    bottomNavigationBar: isChild || !hasAds
                        ? isChild || !hasAds
                            ? const SizedBox()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  bottomSheet(context: context, ref: ref) ??
                                      const SizedBox(),
                                  // SyntonicAdBanner()
                                ],
                              )
                        : const SizedBox(),
                  ),
                  const Center(child: CircularProgressIndicator())
                ]);
              }
            }
          },
        );
      } else {
        return _body(context: context, ref: ref);
      }
    });
  }

  /// Get body.
  Widget _body(
      {required BuildContext context, required riverpod.WidgetRef ref}) {
    Widget _child = DefaultTabController(
      length: hasTabBar ? 2 : 0,
      // length: hasTabBar ? tabs(context: context, ref: ref)!.length : 0,
      child: riverpod.Consumer(builder: (context, ref, child) {
        if (isPage) {
          return mainContents(context: context, ref: ref);
        } else {
          return NestedScrollView(
            headerSliverBuilder: (_, __) {
              return <Widget>[
                hasHeader
                    ? SliverStack(
                        children: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Material(
                                    type: MaterialType.button,
                                    animationDuration:
                                        viewModel(ref).state.isStickyingAppBar
                                            ? const Duration(milliseconds: 100)
                                            : const Duration(milliseconds: 150),
                                    surfaceTintColor: Theme.of(context)
                                        .colorScheme
                                        .surfaceTint,
                                    shadowColor: Colors.transparent,
                                    elevation: ref.watch(provider.select(
                                            (viewState) =>
                                                viewState.isStickyingAppBar))
                                        ? 3
                                        : 0,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    child: _headerContents(
                                        context: context, ref: ref))
                              ],
                            ),
                          ),
                          _appBar(context: context),
                        ],
                      )
                    : _appBar(context: context),
                hasTabBar
                    ? SliverPersistentHeader(
                        pinned: true,
                        delegate: StickyTabBarDelegate(
                            tabBar: _tabBar(context: context, ref: ref)!,
                            tabBarHeader:
                                _tabBarHeader(context: context, ref: ref),
                            setStickyState: (isSticking) {
                              if (viewModel(ref).state.isStickyingAppBar !=
                                  isSticking) {
                                print('ステート更新 + $runtimeType + stickying');
                                viewModel(ref).state = viewModel(ref)
                                        .state
                                        .copyWith(isStickyingAppBar: isSticking)
                                    as VS;
                              }
                            },
                            height: viewModel(ref).state.tabBarHeight ?? 0))
                    : _blank,
              ];
            },
            body: _notificationListener(context: context, ref: ref, child: _mainContents(context: context, ref: ref))
        ,
          );
        }
      }),
    );
    if (hasAppBar) {
      if (needsSliverAppBar) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: navigationDrawer(context: context),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: _floatingActionButtons(context: context),
          body: isChild
              ? _child
              : _notificationListener(
                  context: context, ref: ref, child: _child),
          // bottomSheet: bottomSheet,
          bottomNavigationBar: isChild || !hasAds
              ? const SizedBox()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    bottomSheet(context: context, ref: ref) ?? const SizedBox(),
                    SyntonicAdBanner()
                  ],
                ),
        );
      } else {
        return DefaultTabController(
            length: hasTabBar ? 2 : 0,
            // length: hasTabBar ? tabs(context: context, ref: ref)!.length : 0,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              drawer: navigationDrawer(context: context),
              body: riverpod.Consumer(
                builder: (context, ref, child) {
                  return NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[];
                    },
                    body: _notificationListener(context: context, ref: ref, child: _mainContents(context: context, ref: ref))
                  ,
                  );
                },
              ),
              // bottomSheet: bottomSheet(context: context, ref: ref),
              bottomNavigationBar: isChild || !hasAds
                  ? const SizedBox()
                  : Column(children: [
                      bottomSheet(context: context, ref: ref) ??
                          const SizedBox(),
                      // SyntonicAdBanner(),
                    ]),
            ));
      }
    } else {
      if (isChild) {
        print(runtimeType);
        print('こども');
        return riverpod.Consumer(
          builder: (context, ref, child) {
            return mainContents(context: context, ref: ref);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              primary: false,
              // // extendBody: true,
              //   extendBodyBehindAppBar: false,
              body: mainContents(context: context, ref: ref),
              floatingActionButton: _floatingActionButtons(context: context),
              // bottomSheet: bottomSheet(context: context, ref: ref),
              bottomNavigationBar:
                  bottomSheet(context: context, ref: ref) != null || !hasAds
                      ? bottomSheet(context: context, ref: ref)
                      : const SizedBox(),
            );
            return Column(
              children: [
                if (headerContents(context: context, ref: ref) != null)
                  headerContents(context: context, ref: ref)!,
                Expanded(
                  child: mainContents(context: context, ref: ref),
                ),
              ],
            );
          },
        );
      } else {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: riverpod.Consumer(
            builder: (context, ref, child) {
              // return mainContents(context: context, ref: ref);
              return _notificationListener(context: context, ref: ref, child: _mainContents(context: context, ref: ref));
            },
          ),
          // bottomSheet: bottomSheet(context: context, ref: ref),
          bottomNavigationBar:
              bottomSheet(context: context, ref: ref) != null || !hasAds
                  ? bottomSheet(context: context, ref: ref)
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  bottomSheet(context: context, ref: ref) ?? const SizedBox(),
                  SizedBox(height: 16,),
                  SyntonicAdBanner()
                ],
              ),
        );
      }
    }
    // });
  }

  /// Return blank.
  ///
  /// Must nest blank as sliver list item.
  /// Because parent widget is [headerSliverBuilder].
  Widget get _blank {
    return SliverList(
      delegate: SliverChildListDelegate(
        [const SizedBox()],
      ),
    );
  }

  /// Get main contents in a screen.
  ///
  /// Set background color of contents.
  ///
  /// Focus a screen when tap outside widgets.
  /// That way, a text field focus will be out.
  ///
  /// Validate this when the function ([model.validate()]) was called.
  Widget _mainContents(
      {required BuildContext context, required riverpod.WidgetRef ref}) {
    return Form(
        key: viewModel(ref).formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          padding:
              !isChild ? EdgeInsets.zero : const EdgeInsets.only(bottom: 100),
          child: mainContents(context: context, ref: ref),
        ));
    // child: Center(
    //     child: Container(
    //         alignment: Alignment.topLeft,
    //         constraints: const BoxConstraints(
    //             minWidth: double.infinity,
    //             maxWidth: double.infinity),
    //         child: mainContents(context: context, ref: ref)))),

    // 仮　footer navigation itemsがない場合はOK
    // floating action button有無によってメインコンテンツの最下部とfloating buttonがかぶらないようにスペースを配置
    // double sizedBoxHeight = 16.0;
    //
    // if (floatingActionButton != null) {
    //   sizedBoxHeight += 56.0;
    // }
    // if (floatingActionButtonSecondary != null) {
    //   sizedBoxHeight += 56.0;
    // }
    //
    // return GestureDetector(
    //   onTap: () {
    //     FocusManager.instance.primaryFocus!.unfocus();
    //   },
    //   child: ListView(
    //     children: [
    //       mainContents,
    //       SizedBox(height: sizedBoxHeight,)
    //     ],),
    // );
  }

  /// Get an app bar (Sliver, Nullable).
  ///
  /// Must be override this function in a child view.
  SyntonicSliverAppBar? appBar(
      {required BuildContext context, required riverpod.WidgetRef ref});

  /// Get main contents in screen.
  ///
  /// Must be override this function in a child view.
  Widget mainContents(
      {required BuildContext context, required riverpod.WidgetRef ref});

  /// Get navigation drawer.
  Widget? navigationDrawer({
    required BuildContext context,
  }) =>
      null;

  NotificationListener _notificationListener(
      {required BuildContext context,
      required riverpod.WidgetRef ref,
      required Widget child}) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        print('サイズ');
        print(viewModel(ref).state.height);
        print(viewModel(ref).state.tabBarHeight);

        if (!viewModel(ref).canScrollHeaderAutomatically) {
          return false;
        }

        if (scrollNotification is ScrollUpdateNotification &&
            scrollNotification.metrics.axis == Axis.vertical) {
          if (viewModel(ref).state.height == null ||
              scrollNotification.dragDetails != null) {
            print('とめた');
            return false;
          }
          if (scrollNotification.metrics.pixels > 0 &&
              viewModel(ref).scrollController!.position.userScrollDirection ==
                  ScrollDirection.forward) {
            print('りばーす');
            if (viewModel(ref).isScrollingAutomatically == false &&
                scrollNotification.metrics.pixels <
                    viewModel(ref).state.height! -
                        viewModel(ref).state.tabBarHeight!.toInt() -
                        72 +
                        2 &&
                scrollNotification.metrics.pixels > 0) {
              viewModel(ref).isScrollingAutomatically = true;
              Future.microtask(() => viewModel(ref)
                  .scrollController!
                  .animateTo(0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubicEmphasized)
                  .whenComplete(
                      () => viewModel(ref).isScrollingAutomatically = false));
            }
          } else {
            print('ふつう');
            if (viewModel(ref).isScrollingAutomatically == false &&
                !viewModel(ref).state.isStickyingAppBar &&
                scrollNotification.metrics.pixels > 0 &&
                scrollNotification.metrics.pixels <
                    viewModel(ref).state.height! -
                        viewModel(ref).state.tabBarHeight!.toInt() -
                        72 +
                        2) {
              viewModel(ref).isScrollingAutomatically = true;
              Future.microtask(() => viewModel(ref)
                  .scrollController!
                  .animateTo(
                      viewModel(ref).state.height! -
                          viewModel(ref).state.tabBarHeight!.toInt() -
                          72 +
                          2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubicEmphasized)
                  .whenComplete(
                      () => viewModel(ref).isScrollingAutomatically = false));
            }
          }
          if (scrollNotification.metrics.pixels ==
              scrollNotification.metrics.maxScrollExtent) {
            onReachBottom();
            // if (viewModel(ref).state.isFloatingActionButtonExtended == false) {
            //   viewModel(ref).state = viewModel(ref).state.copyWith(isFloatingActionButtonExtended: true) as VS;
            // }
          }

          if (scrollNotification.metrics.pixels ==
              scrollNotification.metrics.minScrollExtent) {
            onReachTop();
          }
        }

        if (scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.axis == Axis.vertical) {
          if (viewModel(ref).state.height == null) {
            print('とめた');
            return false;
          }

          if (scrollNotification.metrics.pixels > 0 &&
              viewModel(ref).scrollController!.position.userScrollDirection ==
                  ScrollDirection.forward) {
            print('りばーす');
            if (viewModel(ref).isScrollingAutomatically == false &&
                scrollNotification.metrics.pixels <
                    viewModel(ref).state.height! -
                        viewModel(ref).state.tabBarHeight!.toInt() -
                        72 +
                        2 &&
                scrollNotification.metrics.pixels > 0) {
              viewModel(ref).isScrollingAutomatically = true;
              Future.microtask(() => viewModel(ref)
                  .scrollController!
                  .animateTo(0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubicEmphasized)
                  .whenComplete(
                      () => viewModel(ref).isScrollingAutomatically = false));
            }
          } else {
            print('ふつう');
            if (viewModel(ref).isScrollingAutomatically == false &&
                !viewModel(ref).state.isStickyingAppBar &&
                scrollNotification.metrics.pixels > 0 &&
                scrollNotification.metrics.pixels <
                    viewModel(ref).state.height! -
                        viewModel(ref).state.tabBarHeight!.toInt() -
                        72 +
                        2) {
              viewModel(ref).isScrollingAutomatically = true;
              Future.microtask(() => viewModel(ref)
                  .scrollController!
                  .animateTo(
                      viewModel(ref).state.height! -
                          viewModel(ref).state.tabBarHeight!.toInt() -
                          72 +
                          2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubicEmphasized)
                  .whenComplete(
                      () => viewModel(ref).isScrollingAutomatically = false));
            }
          }
        }

        return false;
      },
      child: canSwipeToRefresh(context: context, ref: ref)
          ? RefreshIndicator(
              // key: GlobalKey<RefreshIndicatorState>(),
              //   color: SyntonicColor.primary_color,
              onRefresh: () async {
                await onSwipeToRefresh(context: context, ref: ref);
              },
              child: child)
          : child,
    );
  }

  /// Get the layout for when not found a contents.
  Widget notFoundContents({required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      // alignment: Alignment.topCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Subtitle2Text(text: title),
          Body2Text(text: subtitle),
        ],
      ),
    );
  }

  /// Bottom sheet.
  Widget? bottomSheet(
          {required BuildContext context, required riverpod.WidgetRef ref}) =>
      null;

  /// The function that is executed,
  /// when the content is scrolled down to the bottom of a screen.
  ///
  /// Default is none.
  Function() get onReachBottom => () {};

  /// The function that is executed,
  /// when the content is scrolled up to the top of a screen.
  ///
  /// Default is none.
  Function() get onReachTop => () {};

  /// Get header contents.
  ///
  /// When a screen is scrolled, header contents are hidden.
  ///
  /// Default is none.
  Widget? headerContents(
          {required BuildContext context, required riverpod.WidgetRef ref}) =>
      null;

  /// Get tabs of tab bar.
  ///
  /// Default is none.
  List<Widget>? tabs(
          {required BuildContext context, required riverpod.WidgetRef ref}) =>
      null;

  /// Get tab controller.
  ///
  /// Tab controller is optional controller for [TabBar].
  /// If control a tab bar manually, add here.
  ///
  /// Default is none.
  TabController? get tabController => null;

  /// Get a model for create floating action button.
  /// Because extend state is managed this class.
  ///
  /// Default is none.
  ///
  /// Occasionally two FABs can be used, if they perform distinct,
  /// yet equally important, actions.
  FloatingActionButtonModel? floatingActionButton(
          {required BuildContext context, required riverpod.WidgetRef ref}) =>
      null;
  FloatingActionButtonModel? floatingActionButtonSecondary(
          {required BuildContext context, required riverpod.WidgetRef ref}) =>
      null;

  /// Get an action of pull to refresh.
  ///
  /// Default is none.
  Future<dynamic>? onSwipeToRefresh(
          {required BuildContext context,
          required riverpod.WidgetRef ref}) async =>
      viewModel(ref).onInit(context: context);

  /// Get whether main content can swipe to refresh.
  ///
  /// Default is false.
  bool canSwipeToRefresh(
          {required BuildContext context, required riverpod.WidgetRef ref}) =>
      viewModel(ref).state.needsInitialize;

  /// Whether needs [SliverAppBar].
  ///
  /// Default is "true".
  ///
  /// If you set "false", use [AppBar].
  /// "false" is typically use to a screen with backdrop,
  /// Because [SliverAppBar] can slip in to underground of an [AppBar].
  /// If use [AppBar], contents is show in [AppBar] bellow.
  bool get needsSliverAppBar => true;

  /// Get app bar.
  ///
  /// Type of an app bar ([AppBar], [SliverAppBar]) depends on
  /// [needsSliverAppBar], and also If an app bar is [AppBar] and has [_tabBar],
  /// set [_tabBar] to bottom of [Appbar].
  Widget _appBar({required BuildContext context}) {
    return riverpod.Consumer(builder: (context, ref, child) {
      if (needsSliverAppBar) {
        SyntonicSliverAppBar _appBar = appBar(context: context, ref: ref)!;

        return SyntonicSliverAppBar(
            context: _appBar.context,
            title: _appBar.title,
            actions: _appBar.actions,
            accentColor: _appBar.accentColor,
            isBackButtonEnabled: _appBar.isBackButtonEnabled,
            elevation: _appBar.elevation,
            expandedHeight: ref.read(provider).height,
            // expandedHeight: _appBar.expandedHeight,
            flexibleSpace: _appBar.flexibleSpace,
            isFadedTitle: _appBar.isFadedTitle,
            isFullscreenDialog: _appBar.isFullscreenDialog,
            isStickying: ref.read(provider).isStickyingAppBar,
            onBackButtonPressed: _appBar.onBackButtonPressed,
            onTap: _appBar.onTap,
            needsNavigationDrawer: _appBar.needsNavigationDrawer,
            searchBox: _appBar.searchBox,
            scrollController: viewModel(ref).scrollController,
            subtitle: _appBar.subtitle,
            hasTabBar: hasTabBar,
            manualUrl: _appBar.manualUrl,
            bottom: _appBar.bottom,
            leading: _appBar.leading,
            logo: _appBar.logo,
            trailing: _appBar.trailing);
      } else {
        double _height = kToolbarHeight;
        SyntonicSliverAppBar _appBar = appBar(context: context, ref: ref)!;
        _height += _tabBar(context: context, ref: ref) != null
            ? _tabBar(context: context, ref: ref)!.preferredSize.height
            : 0;
        _height += _tabBar(context: context, ref: ref) == null &&
                _appBar.searchBox != null
            ? 12
            : 0;
        _height +=
            _appBar.bottom != null ? _appBar.bottom!.preferredSize.height : 0;

        return PreferredSize(
            preferredSize: Size.fromHeight(_height),
            child: SyntonicSliverAppBar.fixed(
              context: _appBar.context,
              title: _appBar.title,
              actions: _appBar.actions,
              accentColor: _appBar.accentColor,
              // isBackButtonEnabled: _appBar.isBackButtonEnabled,
              elevation: _appBar.elevation,
              expandedHeight: _appBar.expandedHeight,
              flexibleSpace: _appBar.flexibleSpace,
              isFadedTitle: _appBar.isFadedTitle,
              isFullscreenDialog: _appBar.isFullscreenDialog,
              isStickying: viewModel(ref).state.isStickyingAppBar,
              onBackButtonPressed: _appBar.onBackButtonPressed,
              needsNavigationDrawer: _appBar.needsNavigationDrawer,
              searchBox: _appBar.searchBox,
              scrollController: viewModel(ref).scrollController,
              subtitle: _appBar.subtitle,
              hasTabBar: hasTabBar,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(_height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tabBar(context: context, ref: ref) ?? const SizedBox(),
                    _appBar.bottom ?? const SizedBox()
                  ],
                ),
              ),
              trailing: _appBar.trailing,
            ));
      }
    });
  }

  /// Get floating action buttons.
  ///
  /// Apply different color to Secondary FAB than to primary FAB.
  Widget? _floatingActionButtons({required BuildContext context}) {
    if (hasFAB) {
      if (hasFABSecondary) {
        return Padding(
          padding: EdgeInsets.only(bottom: hasAds ? 0 : 0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _floatingActionButton(isSecondary: true),
                const SizedBox(height: 8),
                _floatingActionButton(),
              ]),
        );
      } else {
        return Padding(
          padding: EdgeInsets.only(bottom: hasAds ? 0 : 0),
          child: _floatingActionButton(),
        );
      }
    } else {
      return null;
    }
  }

  /// Get floating action button.
  /// Extending state of fFAB depends on Scroll direction in a screen ([model.isFloatingActionButtonExtended]).
  /// And also, can hide FAB with fading animation.
  Widget _floatingActionButton({
    bool isSecondary = false,
  }) {
    return riverpod.Consumer(builder: (context, ref, child) {
      return SyntonicFloatingActionButton(
          floatingActionButtonModel: isSecondary
              ? floatingActionButtonSecondary(context: context, ref: ref)!
              : floatingActionButton(context: context, ref: ref)!,
          isExtended: ref.watch(provider
              .select((viewState) => viewState.isFloatingActionButtonExtended)),
          isSecondary: isSecondary);
    });
  }

  /// Get Error screen.
  ///
  /// If a screen failed initialize, display this screen,
  /// And also, hide action item in [appbar], [floatingActionButton] too.
  Widget get _errorScreen {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.error, size: 124),
            Subtitle2Text(text: 'エラー'),
            SizedBox(
              height: 4,
            ),
            SizedBox(height: 124)
          ]),
        ),
      ),
    );
  }

  /// Get header contents.
  /// For listen focus event by tap, and focus out from some widgets.
  Widget _headerContents(
      {required BuildContext context, required riverpod.WidgetRef ref}) {
    if (!hasHeader) {
      return const SizedBox();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          viewModel(ref)._b.currentContext?.findRenderObject() as RenderBox?;
      if (viewModel(ref).state.height != renderBox!.size.height) {
        print('ステート更新 + $runtimeType + height');
        viewModel(ref).state =
            viewModel(ref).state.copyWith(height: renderBox.size.height) as VS;
      }
    });

    double? _ofset =
        ref.watch(provider.select((viewState) => viewState.height)) != null
            ? (viewModel(ref).state.height ?? 0) -
                (viewModel(ref).state.tabBarHeight ?? 0) -
                72 +
                2
            : 0;
    return SyntonicFade.off(
        key: viewModel(ref)._b,
        zeroOpacityOffset: _ofset / 2,
        //   zeroOpacityOffset: viewModel(ref).state.height - kToolbarHeight < 0 ? 0 : viewModel(ref).state.height - (kToolbarHeight * 3),
        fullOpacityOffset: _ofset,
        scrollController: viewModel(ref).scrollController ?? ScrollController(),
        child: headerContents(context: context, ref: ref)!);
    return Container(
      key: viewModel(ref)._b,
      child: headerContents(context: context, ref: ref)!,
    );
  }

  /// Get header contents.
  /// For listen focus event by tap, and focus out from some widgets.
  Widget _tabBarHeader(
      {required BuildContext context, required riverpod.WidgetRef ref}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          viewModel(ref)._c.currentContext?.findRenderObject() as RenderBox?;
      if (viewModel(ref).state.tabBarHeight != renderBox!.size.height) {
        print('ステート更新 + $runtimeType + tab height');
        viewModel(ref).state = viewModel(ref)
            .state
            .copyWith(tabBarHeight: renderBox.size.height) as VS;
      }
    });

    return Container(
      key: viewModel(ref)._c,
      child: tabBarHeader(context: context, ref: ref),
    );

    // return _SizeListenableContainer(
    //   key: _globalKey,
    //   onSizeChanged: (Size size) {
    //     if (viewModel(ref).state.tabBarHeight == null ||
    //         viewModel(ref).state.tabBarHeight != size.height) {
    //       viewModel(ref).state =
    //           viewModel(ref).state.copyWith(tabBarHeight: size.height) as VS;
    //     }
    //   },
    //   child: tabBarHeader(context: context, ref: ref),
    // );
  }

  Widget? tabBarHeader(
          {required BuildContext context, required riverpod.WidgetRef ref}) =>
      null;

  ///TODO: InfiniteLoadingListViewなどで、scrollControllerをセットしていないと、エラーになるので、必ずセットするようにするなどチェックを検討する。
  /// Get tab bar.
  /// If Tapped same tab, scroll position of screen to top with animation.
  TabBar? _tabBar(
      {required BuildContext context, required riverpod.WidgetRef ref}) {
    int _currentIndex = 0;
    if (hasTabBar) {
      return TabBar(
        dividerColor: ref.watch(
                provider.select((viewState) => viewState.isStickyingAppBar))
            ? Colors.transparent
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
        controller: tabController,
        isScrollable:
            tabs(context: context, ref: ref)!.length > 2 ? true : false,
        onTap: (_index) {
          if (tabController != null
              ? !tabController!.indexIsChanging
              : _currentIndex == _index) {
            print(viewModel(ref).state.height!);
            print(viewModel(ref).state.tabBarHeight!.toInt());
            // print((tabs(context: context, ref: ref)![0] as Tab).height!.toInt());
            viewModel(ref).isScrollingAutomatically = true;
            Future.microtask(() => viewModel(ref).scrollController!.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutCubicEmphasized))
                .whenComplete(
                    () => viewModel(ref).isScrollingAutomatically = false);

            // ref.read(provider).changeFloatingActionButtonState(true);

            // IF [headerContents] is exist.
            // ref.read(provider).scrollController.animateTo(
            //   0.0,
            //   curve: Curves.easeOut,
            //   duration: const Duration(milliseconds: 300),
            // );
            //
            // childViews![_index].provider.scrollController.animateTo(
            //       0.0,
            //       curve: Curves.easeOut,
            //       duration: const Duration(milliseconds: 300),
            //     );

            // For screens build by stack widget.
            // for (SyntonicBaseView _childView in childViews![_index].childViews!) {
            //   _childView.provider.scrollController.animateTo(
            //     0.0,
            //     curve: Curves.easeOut,
            //     duration: const Duration(milliseconds: 300),
            //   );
            // }
          }

          // ref.read(provider).setCurrentTabIndex(_index);
          _currentIndex = _index;
        },
        tabs: tabs(context: context, ref: ref)!,
      );
    } else {
      return null;
    }
  }
}

abstract class BaseViewModel<VS extends BaseViewState>
    extends riverpod.StateNotifier<VS> with WidgetsBindingObserver, RouteAware {
  BaseViewModel({required VS viewState}) : super(viewState) {
    // scrollController.addListener(() {
    //   // if (floatingActionButton(context: context, ref: ref) != null &&
    //   //     scrollNotification is UserScrollNotification) {
    //   if (scrollController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //     if (state.isFloatingActionButtonExtended == true) {
    //       print('リバース');
    //       state = state.copyWith(isFloatingActionButtonExtended: false) as VS;
    //     }
    //   } else if (scrollController.position.userScrollDirection ==
    //       ScrollDirection.forward) {
    //     print('リバース');
    //     if (state.isFloatingActionButtonExtended == false) {
    //       state = state.copyWith(isFloatingActionButtonExtended: true) as VS;
    //     }
    //   }
    //   // }
    // });

    WidgetsBinding.instance.addObserver(this);
    print('リビルド + $runtimeType');

    initialization ??= initializeee();
  }

  // bool isInitialized = false;
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  late ScrollController? scrollController;
  // ..addListener(scrollListener);
  late BannerAd ad;
  late AdSize? adSize;
  late bool isAdLoaded = false;
  final GlobalKey _b = GlobalKey();
  final GlobalKey _c = GlobalKey();
  double offset = 0;
  bool isScrollingAutomatically = false;
  bool canScrollHeaderAutomatically = true;
  final bool _isInitializing = false; // Add this flag

  Future<void>? initialization;

  void subscribeToRouteObserver(BuildContext context) {
    if (ModalRoute.of(context) == null) {
      return;
    }

    NavigationService.routeObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  void unsubscribeFromRouteObserver() {
    NavigationService.routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didPopNext() {
    // LogService.print(value: "Returned to this screen: $runtimeType");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.resumed) {
    //   LogService.print(value: "App has resumed: $runtimeType");
    // }
  }

  @override
  void dispose() {
    unsubscribeFromRouteObserver();
    onDispose();
    super.dispose();
  }

  Future<void> initializeee() async {
    await Future.delayed(const Duration(seconds: 2)); // 初期化処理
    print('Initialized! + $runtimeType');
  }

  @override
  set state(VS value) {
    print('ステート更新 + $runtimeType + 何か');
    super.state = value;
  }

  @override
  VS get state => super.state;

  set initialize(bool isInitialized) {
    VS b = state.copyWith(isInitialized: isInitialized) as VS;
    print('ステート更新 + $runtimeType + initialize');
    state = b;
  }

  get isInitialized => state.isInitialized;


  Future<dynamic>? onInit({required BuildContext context}) => null;

  @protected
  void onDispose() {}

  void setCurrentTabIndex(int? index) {
    // state = state.copyWith(currentTabIndex: index) as VS;
  }

  /// Validate a [Form] in [view._mainContents].
  ///
  /// Execute [onSucceeded] when on the validation pass.
  /// In the case validation failed, execute [onFailed].
  validate({Function()? onSucceeded, Function()? onFailed}) async {
    if (formKey!.currentState!.validate()) {
      if (onSucceeded != null) {
        onSucceeded();
      }
    } else {
      if (onFailed != null) {
        onFailed();
      }
    }
  }
}

typedef SizeChangedCallback = void Function(Size size);

class _SizeListenableContainer extends SingleChildRenderObjectWidget {
  const _SizeListenableContainer({
    required Key key,
    Widget? child,
    required this.onSizeChanged,
  }) : super(key: key, child: child);

  final SizeChangedCallback onSizeChanged;

  @override
  _SizeListenableRenderObject createRenderObject(BuildContext context) {
    return _SizeListenableRenderObject(onSizeChanged: onSizeChanged);
  }
}

class _SizeListenableRenderObject extends RenderProxyBox {
  _SizeListenableRenderObject({
    RenderBox? child,
    required this.onSizeChanged,
  }) : super(child);

  final SizeChangedCallback onSizeChanged;

  Size? _oldSize;

  @override
  void performLayout() {
    super.performLayout();

    final Size size = this.size;
    if (size != _oldSize) {
      _oldSize = size;
      _callback(size);
    }
  }

  void _callback(Size size) {
    SchedulerBinding.instance.addPostFrameCallback((Duration _) {
      onSizeChanged(size);
    });
  }
}
