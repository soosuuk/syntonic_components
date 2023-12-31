import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:syntonic_components/configs/constants/syntonic_date_and_time.dart';
import 'package:syntonic_components/configs/constants/syntonic_language.dart';
import 'package:syntonic_components/widgets/enhancers/syntonic_fade.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

import 'base_view_state.dart';
import 'buttons/syntonic_floating_action_button.dart';
import 'app_bars/syntonic_sliver_app_bar.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter/scheduler.dart';

part '../extensions/syntonic_color_extension.dart';
part '../extensions/syntonic_date_time_extension.dart';
// part '../extensions/syntonic_date_time_range_extension.dart';
// part '../extensions/syntonic_int_extension.dart';
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

// ignore: must_be_immutable
abstract class SyntonicBaseView<VM extends BaseViewModel<VS>, VS extends BaseViewState> extends StatelessWidget {

  const SyntonicBaseView({Key? key, required this.vm, this.childViews, this.globalKey, this.hasAppBar = true, this.hasHeader = false, this.hasTabBar = false, this.isChild = false}) : super(key: key);

  final VM vm;
  // final provider;
  final GlobalKey? globalKey;
  final bool hasAppBar;
  final bool hasHeader;
  final bool hasTabBar;
  final bool isChild;

  GlobalKey get _globalKey => globalKey ?? GlobalKey();

  // @protected
  // T viewModel(BuildContext context) => Provider.of<T>(context, listen: false);

  // @protected
  // T vmR(BuildContext context) => context.read<V>();
  //
  // @protected
  // VM vmW(BuildContext context) => context.watch<VM>();

  // late riverpod.WidgetRef _ref;
  VM viewModel(riverpod.WidgetRef ref) => ref.read(provider.notifier);
  // VM get vm => _ref.read(provider);
  get provider => riverpod.StateNotifierProvider<VM, VS>((ref) => vm);

  // Function? willPopCallback;
  // PlatformType? platformType;
  // late BuildContext context;

  final List<SyntonicBaseView>? childViews;

  // @protected
  // VM getViewModelBy(BuildContext context);

  // @protected
  // VS getVS(BuildContext context);

  @override
  Widget build(BuildContext context) {

    // if (kIsWeb) {
    //   this.platformType = PlatformType.Web;
    // } else if (Platform.isIOS) {
    //   this.platformType = PlatformType.Ios;
    // } else if (Platform.isAndroid) {
    //   this.platformType = PlatformType.Android;
    // }
    // final viewModel = getViewModelBy(context);

    // var viewState = getVS(context);
    // provider = riverpod.StateNotifierProvider<VM, VS>((ref) => viewModel);
    // final userDetailViewModelProvider = riverpod.StateNotifierProvider<VM, VS>((ref) {
    //   return viewModel;
    // });
    // this.context = context;

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
      child: _screen(vm),
    );
    return _screen(vm);
  }

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
  Widget _screen(VM viewModel) {
    // skip initialization, depending on whether [isInitialized] is "true".
    // Because, A screen is Rebuilt if you focus to any text-field.
    return riverpod.Consumer(builder: (context, ref, _) {
      print('ビルド');
      if ((viewModel as VM).state.needsInitialize && !(viewModel as VM).state.isInitialized) {
        return FutureBuilder(
          future: (viewModel as VM).onInit(context: context),
          builder: (context, projectSnap) {
            if (projectSnap.hasError) {
              return NestedScrollView(
                headerSliverBuilder:
                    (_, __) {
                  return <Widget>[
                    SyntonicSliverAppBar(
                        isFullscreenDialog:
                        hasAppBar ? appBar(context: context, ref: ref)!.isFullscreenDialog : false,
                        title: hasAppBar ? appBar(context: context, ref: ref)!.title : null),
                  ];
                },
                body: _errorScreen,
              );
            } else if (projectSnap.connectionState == ConnectionState.done) {
              (viewModel as VM).state.isInitialized = true;
              // (viewModel as VM).state = (viewModel as VM).state.copyWith(isInitialized: true) as VS;
              return _body(context: context, ref: ref);
            } else {
              if ((viewModel as VM).state.isSkeletonLoadingApplied) {
                return _body(context: context, ref: ref);
              } else {
                return Stack(children: [
                  Scaffold(
                    drawer: hasAppBar ? navigationDrawer : null,
                    appBar: hasAppBar
                        ? SyntonicSliverAppBar.fixed(
                        title: appBar(context: context, ref: ref)!.title ?? '',
                        context: context,
                        needsNavigationDrawer:
                        appBar(context: context, ref: ref)!.needsNavigationDrawer,
                        trailing: appBar(context: context, ref: ref)!.trailing)
                        : null,
                    bottomSheet: bottomSheet,
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
    },);
  }

  /// Get body.
  Widget _body({required BuildContext context, required riverpod.WidgetRef ref}) {
    print('ボディー');
    // return riverpod.Consumer(builder: (context, ref, child) {
      // _ref = ref;
      if (hasAppBar) {
        if (needsSliverAppBar) {
          return Scaffold(
            drawer: navigationDrawer,
            floatingActionButton: _floatingActionButtons(context: context, ref: ref),
            body: DefaultTabController(
                length: hasTabBar ? tabs(context: context, ref: ref)!.length : 0,
                child: NestedScrollView(
                  controller: viewModel(ref).state
                      .scrollController,
                  headerSliverBuilder:
                      (_, __) {
                    return <Widget>[
                      hasHeader ?
                      SliverStack(
                        children: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [_headerContents(context: context, ref: ref)],
                            ),
                          ),
                          _appBar(context: context, ref: ref),
                        ],
                      ) : _appBar(context: context, ref: ref),
                      hasTabBar
                          ? SliverPersistentHeader(
                          pinned: true,
                          delegate: StickyTabBarDelegate(
                              tabBar: _tabBar(context: context, ref: ref)!,
                              setStickyState: (isSticking) {
                                print('スティッキー');
                                if (viewModel(ref)
                                    .state.isStickyingAppBar != isSticking) {
                                  viewModel(ref)
                                      .state = viewModel(ref)
                                      .state.copyWith(isStickyingAppBar: isSticking) as VS;
                                }
                                print(viewModel(ref)
                                    .state.isStickyingAppBar);
                              }))
                          : _blank,
                    ];
                  },
                  body: _notificationListener(context: context, ref: ref),
                )),
            bottomSheet: bottomSheet,
          );
        } else {
          return DefaultTabController(
              length: hasTabBar ? tabs(context: context, ref: ref)!.length : 0,
              child: Scaffold(
                drawer: navigationDrawer,
                appBar: AppBar(title: const Body2Text(text: 'title',), flexibleSpace: headerContents(context: context, ref: ref), toolbarHeight: MediaQuery.of(context).size.height * 0.7,),
                // appBar: _appBar as PreferredSizeWidget,
                body: riverpod.Consumer(builder: (context, ref, child) {
                  // _ref = ref;
                  return NestedScrollView(
                    controller: ref
                        .read(provider)
                        .scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[];
                    },
                    body: _notificationListener(context: context, ref: ref),
                  );
                },),
                bottomSheet: bottomSheet,
              ));
        }
      } else {
        if (isChild) {
          return riverpod.Consumer(builder: (context, ref, child) {
            // _ref = ref;
            return mainContents(context: context, ref: ref);
            // return _notificationListener(context: context, ref: ref);
          },);
        } else {
          return Scaffold(
            floatingActionButton: _floatingActionButtons(context: context, ref: ref),
            body: riverpod.Consumer(builder: (context, ref, child) {
              // _ref = ref;
              return mainContents(context: context, ref: ref);
              // return _notificationListener(context: context, ref: ref);
            },),
            bottomSheet: bottomSheet,
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
  Widget _mainContents({required BuildContext context, required riverpod.WidgetRef ref}) {
    print('メイン');
    return Form(
          // key: viewModel(ref).state._formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: mainContents(context: context, ref: ref));
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
  SyntonicSliverAppBar? appBar({required BuildContext context, required riverpod.WidgetRef ref});

  /// Get main contents in screen.
  ///
  /// Must be override this function in a child view.
  Widget mainContents({required BuildContext context, required riverpod.WidgetRef ref});

  /// Get navigation drawer.
  Widget? get navigationDrawer => null;

  NotificationListener _notificationListener({required BuildContext context, required riverpod.WidgetRef ref}) {
    print('ノーティ');
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (floatingActionButton(context: context, ref: ref) != null &&
            scrollNotification is UserScrollNotification) {
          if (scrollNotification.direction == ScrollDirection.reverse) {
            // viewModel.state.isFloatingActionButtonExtended = true;
            // VS vs = (BaseViewState()..isFloatingActionButtonExtended = true) as VS;
            if (viewModel(ref).state.isFloatingActionButtonExtended != true) {
              viewModel(ref).state = viewModel(ref).state.copyWith(isFloatingActionButtonExtended: true) as VS;
            }
          } else if (scrollNotification.direction == ScrollDirection.forward) {
            // viewModel.state.isFloatingActionButtonExtended = false;
            // VS vs = (BaseViewState()..isFloatingActionButtonExtended = false) as VS;
            if (viewModel(ref).state.isFloatingActionButtonExtended != false) {
              viewModel(ref).state = viewModel(ref).state.copyWith(isFloatingActionButtonExtended: false) as VS;
            }
          }
        }


        if (scrollNotification is ScrollEndNotification) {
          if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent &&
              scrollNotification is ScrollEndNotification) {
            onReachBottom();
          } else {
          }

          if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.minScrollExtent &&
              scrollNotification is ScrollEndNotification) {
            onReachTop();
          }
        }

        // if (!needsSliverAppBar) {
        //   if (scrollNotification.metrics.pixels <=
        //       scrollNotification.metrics.minScrollExtent) {
        //     if (!ref.read(provider).isStickyingAppBar) {
        //       ref.read(provider).isStickyingAppBar = true;
        //       ref.read(provider).notifier();
        //     }
        //   } else {
        //     if (ref.read(provider).isStickyingAppBar) {
        //       ref.read(provider).isStickyingAppBar = false;
        //       ref.read(provider).notifier();
        //     }
        //   }
        // }

        return false;
      },
      child: canSwipeToRefresh(context: context, ref: ref)
          ? RefreshIndicator(
              // key: GlobalKey<RefreshIndicatorState>(),
              //   color: SyntonicColor.primary_color,
              onRefresh: () async {
                await onSwipeToRefresh(context: context, ref: ref);
              },
              child: _mainContents(context: context, ref: ref))
          : _mainContents(context: context, ref: ref),
    );
  }

  /// Get the layout for when not found a contents.
  Widget notFoundContents({required String title}) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      alignment: Alignment.topCenter,
      child: Body2Text(
          text: [title, 'がありません。']
              .combineWithSpace()),
    );
  }

  /// Bottom sheet.
  Widget? get bottomSheet => null;

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
  Widget? headerContents({required BuildContext context, required riverpod.WidgetRef ref}) => null;

  /// Get tabs of tab bar.
  ///
  /// Default is none.
  List<Widget>? tabs({required BuildContext context, required riverpod.WidgetRef ref}) => null;

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
  FloatingActionButtonModel? floatingActionButton({required BuildContext context, required riverpod.WidgetRef ref}) => null;
  FloatingActionButtonModel? floatingActionButtonSecondary({required BuildContext context, required riverpod.WidgetRef ref}) => null;

  /// Get an action of pull to refresh.
  ///
  /// Default is none.
  Future<dynamic>? onSwipeToRefresh({required BuildContext context, required riverpod.WidgetRef ref}) async =>
      viewModel(ref).onInit(context: context);

  /// Get whether main content can swipe to refresh.
  ///
  /// Default is false.
  bool canSwipeToRefresh({required BuildContext context, required riverpod.WidgetRef ref}) => viewModel(ref).state.needsInitialize;

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
  Widget _appBar({required BuildContext context, required riverpod.WidgetRef ref}) {
    // return riverpod.Consumer(builder: (context, ref, child) {
      if (needsSliverAppBar) {
        SyntonicSliverAppBar _appBar = appBar(context: context, ref: ref)!;

        return SyntonicSliverAppBar(
            context: _appBar.context,
            title: _appBar.title,
            actions: _appBar.actions,
            accentColor: _appBar.accentColor,
            isBackButtonEnabled: _appBar.isBackButtonEnabled,
            elevation: _appBar.elevation,
            expandedHeight: viewModel(ref).state.height,
            // expandedHeight: _appBar.expandedHeight,
            flexibleSpace: _appBar.flexibleSpace,
            isFadedTitle: _appBar.isFadedTitle,
            isFullscreenDialog: _appBar.isFullscreenDialog,
            isStickying: ref.watch(provider).isStickyingAppBar,
            onBackButtonPressed: _appBar.onBackButtonPressed,
            onTap: _appBar.onTap,
            needsNavigationDrawer: _appBar.needsNavigationDrawer,
            searchBox: _appBar.searchBox,
            scrollController: ref.read(provider).scrollController,
            subtitle: _appBar.subtitle,
            hasTabBar: hasTabBar,
            manualUrl: _appBar.manualUrl,
            bottom: _appBar.bottom,
            trailing: _appBar.trailing);
      } else {
        double _height = kToolbarHeight;
        SyntonicSliverAppBar _appBar = appBar(context: context, ref: ref)!;
        _height += _tabBar(context: context, ref: ref) != null ? _tabBar(context: context, ref: ref)!.preferredSize.height : 0;
        _height += _tabBar(context: context, ref: ref) == null && _appBar.searchBox != null ? 12 : 0;
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
              scrollController: viewModel(ref).state.scrollController,
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
    // });
  }

  /// Get floating action buttons.
  ///
  /// Apply different color to Secondary FAB than to primary FAB.
  Widget? _floatingActionButtons({required BuildContext context, required riverpod.WidgetRef ref}) {
    if (floatingActionButton(context: context, ref: ref) != null) {
      if (floatingActionButtonSecondary(context: context, ref: ref) != null) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _floatingActionButton(isSecondary: true),
              const SizedBox(height: 16),
              _floatingActionButton()
            ]);
      } else {
        return _floatingActionButton();
      }
    } else {
      return null;
    }
  }

  /// Get floating action button.
  /// Extending state of fFAB depends on Scroll direction in a screen ([model.isFloatingActionButtonExtended]).
  /// And also, can hide FAB with fading animation.
  Widget _floatingActionButton({bool isSecondary = false,}) {
    return riverpod.Consumer(builder: (context, ref, child) {
      return SyntonicFloatingActionButton(
          floatingActionButtonModel: isSecondary
              ? floatingActionButtonSecondary(context: context, ref: ref)!
              : floatingActionButton(context: context, ref: ref)!,
          isExtended: ref.watch(provider).isFloatingActionButtonExtended,
          // isExtended: ref.watch(riverpod.StateNotifierProvider<VM, VS>((ref) => viewModel).select((value) => value.isFloatingActionButtonExtended)),
          isSecondary: isSecondary);
      // return AnimatedOpacity(
      //   opacity: ref.watch(provider).isFloatingActionButtonVisible ? 1.0 : 0.0,
      //   duration: const Duration(milliseconds: 300),
      //   child: SyntonicFloatingActionButton(
      //       floatingActionButtonModel: isSecondary
      //           ? floatingActionButtonSecondary(context: context, ref: ref)!
      //           : floatingActionButton(context: context, ref: ref)!,
      //       isExtended: ref.watch(provider).isFloatingActionButtonExtended,
      //       // isExtended: ref.watch(riverpod.StateNotifierProvider<VM, VS>((ref) => viewModel).select((value) => value.isFloatingActionButtonExtended)),
      //       isSecondary: isSecondary),
      // );
    });
  }

  /// Get Error screen.
  ///
  /// If a screen failed initialize, display this screen,
  /// And also, hide action item in [appbar], [floatingActionButton] too.
  Widget get _errorScreen {
    return const Scaffold(
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
  Widget _headerContents({required BuildContext context, required riverpod.WidgetRef ref}) {
    if (!hasHeader) {
      return const SizedBox();
    }

    return SizeListenableContainer(key: _globalKey, onSizeChanged: (Size size) {
        // viewModel(ref).state = viewModel(ref).state.copyWith(height: size.height) as VS;
        // print('高さ');
        // print(viewModel.height - kToolbarHeight);
        // print(viewModel.height);
        // viewModel.notifier();
        },
      child: SyntonicFade.off(
        zeroOpacityOffset: 0,
          // zeroOpacityOffset: viewModel(ref).state.height - kToolbarHeight < 0 ? 0 : viewModel(ref).state.height - (kToolbarHeight * 3),
          fullOpacityOffset: viewModel(ref).state.height, scrollController: viewModel(ref).state.scrollController, child: headerContents(context: context, ref: ref)!),);
  }

  ///TODO: InfiniteLoadingListViewなどで、scrollControllerをセットしていないと、エラーになるので、必ずセットするようにするなどチェックを検討する。
  /// Get tab bar.
  /// If Tapped same tab, scroll position of screen to top with animation.
  TabBar? _tabBar({required BuildContext context, required riverpod.WidgetRef ref}) {
    int _currentIndex = 0;
    if (hasTabBar) {
      return TabBar(
        controller: tabController,
        isScrollable: tabs(context: context, ref: ref)!.length > 2 ? true : false,
        onTap: (_index) {
          if (tabController != null
              ? !tabController!.indexIsChanging
              : _currentIndex == _index) {
            ref.read(provider).changeFloatingActionButtonState(true);

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
          ref.read(provider).setCurrentTabIndex(_index);
          _currentIndex = _index;
        },
        tabs: tabs(context: context, ref: ref)!,
      );
    } else {
      return null;
    }
  }
}

class BaseViewModel<VS extends BaseViewState> extends riverpod.StateNotifier<VS> {
  BaseViewModel({required VS viewState}) : super(viewState);

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

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
    if (state.formKey.currentState!.validate()) {
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

class SizeListenableContainer extends SingleChildRenderObjectWidget {
  const SizeListenableContainer({
    required Key key,
    Widget? child,
    required this.onSizeChanged,
  })  : super(key: key, child: child);

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
  })  : super(child);

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
