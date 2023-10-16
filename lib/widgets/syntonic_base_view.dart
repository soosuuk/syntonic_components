import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:sliver_tools/sliver_tools.dart';
import 'package:syntonic_components/configs/constants/syntonic_date_and_time.dart';
import 'package:syntonic_components/configs/constants/syntonic_language.dart';
import 'package:syntonic_components/gen/l10n/app_localizations.dart';
import 'package:syntonic_components/services/localization_service.dart';
import 'package:syntonic_components/services/navigation_service.dart';
import 'package:syntonic_components/widgets/enhancers/syntonic_fade.dart';
import 'package:syntonic_components/widgets/texts/body_2_text.dart';
import 'package:syntonic_components/widgets/texts/subtitle_2_text.dart';
import 'package:syntonic_components/services/localization_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:provider/single_child_widget.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';

import 'buttons/syntonic_floating_action_button.dart';
import 'app_bars/syntonic_app_bar.dart';
import 'app_bars/syntonic_sliver_app_bar.dart';
import 'lists/syntonic_list_item.dart';
import 'package:flutter_device_type/flutter_device_type.dart';


import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
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
abstract class SyntonicBaseView<T extends BaseViewModel> extends StatelessWidget {
  late var provider;
  final _globalKey = GlobalKey();

  // @protected
  // T viewModel(BuildContext context) => Provider.of<T>(context, listen: false);

  @protected
  T vmR(BuildContext context) => context.read<T>();

  @protected
  T vmW(BuildContext context) => context.watch<T>();

  final isInitializedProvider = riverpod.StateProvider<bool>((ref) => false);

  late riverpod.WidgetRef _ref;
  T get viewModel => _ref.read(provider);

  Function? willPopCallback;
  PlatformType? platformType;
  late BuildContext context;

  List<SyntonicBaseView> childViews = [];

  @protected
  T getViewModelBy(BuildContext context);

  @override
  Widget build(BuildContext context) {

    if (kIsWeb) {
      this.platformType = PlatformType.Web;
    } else if (Platform.isIOS) {
      this.platformType = PlatformType.Ios;
    } else if (Platform.isAndroid) {
      this.platformType = PlatformType.Android;
    }
    var viewModel = getViewModelBy(context);
    provider = riverpod.ChangeNotifierProvider<T>((ref) => viewModel);
    this.context = context;

    return _screen(viewModel);
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
  Widget _screen(T viewModel) {
    // skip initialization, depending on whether [isInitialized] is "true".
    // Because, A screen is Rebuilt if you focus to any text-field.
      if ((viewModel as T).needsInitialize && !(viewModel as T).isInitialized) {
        return FutureBuilder(
          future: (viewModel as T).onInit(),
          builder: (context, projectSnap) {
            if (projectSnap.hasError) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SyntonicSliverAppBar(
                        isFullscreenDialog:
                            appBar != null ? appBar!.isFullscreenDialog : false,
                        title: appBar != null ? appBar!.title : null),
                  ];
                },
                body: _errorScreen,
              );
            } else if (projectSnap.connectionState == ConnectionState.done) {
              (viewModel as T).isInitialized = true;
              return _body();
            } else {
              if ((viewModel as T).isSkeletonLoadingApplied) {
                return _body();
              } else {
                return Stack(children: [
                  Scaffold(
                    drawer: appBar != null ? navigationDrawer : null,
                    appBar: appBar != null
                        ? SyntonicSliverAppBar.fixed(
                            title: appBar!.title ?? '',
                            context: context,
                            needsNavigationDrawer:
                                appBar!.needsNavigationDrawer,
                            trailing: appBar!.trailing)
                        : null,
                    bottomSheet: bottomSheet,
                  ),
                  Container(child: Center(child: CircularProgressIndicator()))
                ]);
              }
            }
          },
        );
      } else {
        return _body();
      }
  }

  /// Get body.
  Widget _body() {
    return riverpod.Consumer(builder: (context, ref, child) {
      _ref = ref;
      if (appBar != null) {
        if (needsSliverAppBar) {
          return Scaffold(
            drawer: navigationDrawer,
            floatingActionButton: _floatingActionButtons(ref: ref),
            body: DefaultTabController(
                length: tabs != null ? tabs!.length : 0,
                child: NestedScrollView(
                  controller: ref
                      .read(provider)
                      .scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverStack(
                        children: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [_headerContents],
                            ),
                          ),
                          _appBar(ref: ref),
                        ],
                      ),
                      // _appBar(ref: ref),
                      tabs != null
                          ? SliverPersistentHeader(
                          pinned: true,
                          delegate: StickyTabBarDelegate(
                              tabBar: _tabBar(ref: ref)!,
                              setStickyState: (isSticking) {
                                print('スティッキー通知');
                                viewModel
                                    .isStickyingAppBar = isSticking;
                              }))
                          : _blank,
                    ];
                  },
                  body: _notificationListener(ref: ref),
                )),
            bottomSheet: bottomSheet,
          );
        } else {
          return DefaultTabController(
              length: tabs != null ? tabs!.length : 0,
              child: Scaffold(
                drawer: navigationDrawer,
                appBar: AppBar(title: Body2Text(text: 'title',), flexibleSpace: headerContents, toolbarHeight: MediaQuery.of(context).size.height * 0.7,),
                // appBar: _appBar as PreferredSizeWidget,
                body: NestedScrollView(
                  controller: ref
                      .read(provider)
                      .scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[];
                  },
                  body: _notificationListener(ref: ref),
                ),
                bottomSheet: bottomSheet,
              ));
        }
      } else {
        return Scaffold(
          floatingActionButton: _floatingActionButtons(ref: ref),
          body: _notificationListener(ref: ref),
          bottomSheet: bottomSheet,
        );
      }
    });
  }

  /// Return blank.
  ///
  /// Must nest blank as sliver list item.
  /// Because parent widget is [headerSliverBuilder].
  Widget get _blank {
    return SliverList(
      delegate: SliverChildListDelegate(
        [SizedBox()],
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
  Widget _mainContents({required riverpod.WidgetRef ref}) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Form(
          key: ref.read(provider)._formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Center(
              child: Container(
                  alignment: Alignment.topLeft,
                  constraints: const BoxConstraints(
                      minWidth: double.infinity,
                      maxWidth: double.infinity),
                  child: mainContents(ref: ref)))),
    );

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
  SyntonicSliverAppBar? get appBar;

  /// Get main contents in screen.
  ///
  /// Must be override this function in a child view.
  Widget mainContents({required riverpod.WidgetRef ref});

  /// Get navigation drawer.
  Widget? get navigationDrawer => null;

  NotificationListener _notificationListener({required riverpod.WidgetRef ref}) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (floatingActionButton != null &&
            scrollNotification is UserScrollNotification) {
          if (scrollNotification.direction == ScrollDirection.reverse) {
            viewModel.isFloatingActionButtonExtended = true;
            print(viewModel.isFloatingActionButtonExtended);
          } else if (scrollNotification.direction == ScrollDirection.forward) {
            viewModel.isFloatingActionButtonExtended = false;
            print(viewModel.isFloatingActionButtonExtended);
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
      child: canSwipeToRefresh
          ? RefreshIndicator(
              // key: GlobalKey<RefreshIndicatorState>(),
              //   color: SyntonicColor.primary_color,
              onRefresh: () async {
                await onSwipeToRefresh;
              },
              child: _mainContents(ref: ref))
          : _mainContents(ref: ref),
    );
  }

  /// Get the layout for when not found a contents.
  Widget notFoundContents({required String title}) {
    return Container(
      padding: EdgeInsets.only(top: 16),
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
  Widget get headerContents => SizedBox();

  /// Get tabs of tab bar.
  ///
  /// Default is none.
  List<Widget>? get tabs => null;

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
  FloatingActionButtonModel? get floatingActionButton => null;
  FloatingActionButtonModel? get floatingActionButtonSecondary => null;

  /// Get an action of pull to refresh.
  ///
  /// Default is none.
  Future<dynamic>? get onSwipeToRefresh async =>
      (viewModel as T).onInit() ?? null;

  /// Get whether main content can swipe to refresh.
  ///
  /// Default is false.
  bool get canSwipeToRefresh => viewModel.needsInitialize;

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
  Widget _appBar({required riverpod.WidgetRef ref}) {
    if (needsSliverAppBar) {
      SyntonicSliverAppBar _appBar = appBar!;

      return SyntonicSliverAppBar(
          context: _appBar.context,
          title: _appBar.title,
          actions: _appBar.actions,
          accentColor: _appBar.accentColor,
          isBackButtonEnabled: _appBar.isBackButtonEnabled,
          elevation: _appBar.elevation,
          expandedHeight: viewModel.height,
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
          hasTabBar: tabs != null,
          manualUrl: _appBar.manualUrl,
          bottom: _appBar.bottom,
          trailing: _appBar.trailing);
    } else {
      double _height = kToolbarHeight;
      SyntonicSliverAppBar _appBar = appBar!;
      _height += _tabBar != null ? _tabBar(ref: ref)!.preferredSize.height : 0;
      _height += _tabBar == null && _appBar.searchBox != null ? 12 : 0;
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
            isStickying: viewModel.isStickyingAppBar,
            onBackButtonPressed: _appBar.onBackButtonPressed,
            needsNavigationDrawer: _appBar.needsNavigationDrawer,
            searchBox: _appBar.searchBox,
            scrollController: viewModel.scrollController,
            subtitle: _appBar.subtitle,
            hasTabBar: tabs != null,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(_height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _tabBar(ref: ref) ?? const SizedBox(),
                  _appBar.bottom ?? const SizedBox()
                ],
              ),
            ),
            trailing: _appBar.trailing,
          ));
    }
  }

  /// Get floating action buttons.
  ///
  /// Apply different color to Secondary FAB than to primary FAB.
  Widget? _floatingActionButtons({required riverpod.WidgetRef ref}) {
    if (floatingActionButton != null) {
      if (floatingActionButtonSecondary != null) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _floatingActionButton(ref: ref, isSecondary: true),
              SizedBox(height: 16),
              _floatingActionButton(ref: ref)
            ]);
      } else {
        return _floatingActionButton(ref: ref);
      }
    } else {
      return null;
    }
  }

  /// Get floating action button.
  /// Extending state of fFAB depends on Scroll direction in a screen ([model.isFloatingActionButtonExtended]).
  /// And also, can hide FAB with fading animation.
  Widget _floatingActionButton({required riverpod.WidgetRef ref, bool isSecondary = false,}) {
    return AnimatedOpacity(
      opacity: ref.watch(provider).isFloatingActionButtonVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 300),
      child: SyntonicFloatingActionButton(
          floatingActionButtonModel: isSecondary
              ? floatingActionButtonSecondary!
              : floatingActionButton!,
          isExtended: ref.watch(provider).isFloatingActionButtonExtended,
          isSecondary: isSecondary),
    );
  }

  /// Get Error screen.
  ///
  /// If a screen failed initialize, display this screen,
  /// And also, hide action item in [appbar], [floatingActionButton] too.
  Widget get _errorScreen {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.error, size: 124),
            Subtitle2Text(text: 'エラー'),
            const SizedBox(
              height: 4,
            ),
            const SizedBox(height: 124)
          ]),
        ),
      ),
    );
  }

  /// Get header contents.
  /// For listen focus event by tap, and focus out from some widgets.
  Widget get _headerContents {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: SizeListenableContainer(key: _globalKey, onSizeChanged: (Size size) {
        viewModel.height = size.height;
        // print('高さ');
        // print(viewModel.height - kToolbarHeight);
        // print(viewModel.height);
        viewModel.notifier();
        },
      child: SyntonicFade.off(zeroOpacityOffset: viewModel.height - kToolbarHeight < 0 ? 0 : viewModel.height - (kToolbarHeight * 3),
          fullOpacityOffset: viewModel.height, scrollController: viewModel.scrollController, child: headerContents),),
    );
  }

  ///TODO: InfiniteLoadingListViewなどで、scrollControllerをセットしていないと、エラーになるので、必ずセットするようにするなどチェックを検討する。
  /// Get tab bar.
  /// If Tapped same tab, scroll position of screen to top with animation.
  TabBar? _tabBar({required riverpod.WidgetRef ref}) {
    int _currentIndex = 0;
    if (tabs != null) {
      return TabBar(
        controller: tabController,
        isScrollable: tabs!.length > 2 ? true : false,
        onTap: (_index) {
          if (tabController != null
              ? !tabController!.indexIsChanging
              : _currentIndex == _index) {
            ref.read(provider).changeFloatingActionButtonState(true);

            // IF [headerContents] is exist.
            ref.read(provider).scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );

            childViews[_index].provider.scrollController.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );

            // For screens build by stack widget.
            for (SyntonicBaseView _childView in childViews[_index].childViews) {
              _childView.provider.scrollController.animateTo(
                0.0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
            }
          }

          ref.read(provider).setCurrentTabIndex(_index);
          _currentIndex = _index;
        },
        tabs: tabs!,
      );
    } else {
      return null;
    }
  }
}

class BaseViewModel extends ChangeNotifier {
  bool isChangedAppBar = false;
  bool _isFloatingActionButtonExtended = false;
  bool get isFloatingActionButtonExtended => _isFloatingActionButtonExtended;
  set isFloatingActionButtonExtended(bool value) {
    if (_isFloatingActionButtonExtended == value) {
      return;
    }
    _isFloatingActionButtonExtended = value;
    notifyListeners();
  }
  double height = 0;

  bool isFloatingActionButtonVisible = true;
  ScrollController scrollController = ScrollController();
  // ..addListener(scrollListener);
  bool _isStickyingAppBar = false;
  bool get isStickyingAppBar => _isStickyingAppBar;
  set isStickyingAppBar(bool value) {
    if (_isStickyingAppBar == value) {
      return;
    }
    _isStickyingAppBar = value;
    notifyListeners();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? currentTabIndex = 0;

  /// Use this variable as check whether number of build is one (initialize)
  /// or two and more(rebuild), when execute [initialize] function.
  bool isInitialized = false;

  BaseViewModel();

  bool get needsInitialize => false;
  bool isSkeletonLoadingApplied = false;

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  Future<dynamic>? onInit() => null;

  @protected
  void onDispose() {}

  /// Update the screen.
  void notifier() {
    notifyListeners();
  }

  void setCurrentTabIndex(int? index) {
    currentTabIndex = index;
    notifyListeners();
  }

  /// Validate a [Form] in [view._mainContents].
  ///
  /// Execute [onSucceeded] when on the validation pass.
  /// In the case validation failed, execute [onFailed].
  validate({Function()? onSucceeded, Function()? onFailed}) async {
    if (_formKey.currentState!.validate()) {
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
  })  : assert(onSizeChanged != null),
        super(key: key, child: child);

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
  })  : assert(onSizeChanged != null),
        super(child);

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
