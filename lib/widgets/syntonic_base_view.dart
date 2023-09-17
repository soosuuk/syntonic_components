import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:syntonic_components/configs/constants/syntonic_date_and_time.dart';
import 'package:syntonic_components/configs/constants/syntonic_language.dart';
import 'package:syntonic_components/gen/l10n/app_localizations.dart';
import 'package:syntonic_components/services/localization_service.dart';
import 'package:syntonic_components/services/navigation_service.dart';
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
import 'package:provider/single_child_widget.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';

import 'buttons/syntonic_floating_action_button.dart';
import 'app_bars/syntonic_app_bar.dart';
import 'app_bars/syntonic_sliver_app_bar.dart';
import 'lists/syntonic_list_item.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

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

enum Microservice {
  account,
  accounting,
  appointment,
  customer,
  contract,
  ec,
  integrator,
  information,
  message,
  product,
  sales,
  service,
  settlement,
  staff,
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
abstract class SyntonicBaseView extends StatelessWidget {
  Function? willPopCallback;
  PlatformType? platformType;
  late BuildContext context;
  late BaseViewModel model;

  /// Use this variable as check whether number of build is one (initialize)
  /// or two and more(rebuild), when execute [initialize] function.
  bool _isInitialized = false;

  @Deprecated('Should use "onReachBottom" function instead of this variable.')
  final _streamController = StreamController<bool>();

  List<SyntonicBaseView> childViews = [];

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      this.platformType = PlatformType.Web;
    } else if (Platform.isIOS) {
      this.platformType = PlatformType.Ios;
    } else if (Platform.isAndroid) {
      this.platformType = PlatformType.Android;
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<BaseViewModel>(
              create: (context) => BaseViewModel()),
        ],
        builder: (context, model) {
          this.context = context;
          this.model = Provider.of<BaseViewModel>(context, listen: false);

          return _providers != null
              ? MultiProvider(
                  providers: _providers!,
                  builder: (context, model) {
                    this.context = context;
                    return _screen;
                  })
              : _screen;
        });
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
  Widget get _screen {
    // skip initialization, depending on whether [_isInitialized] is "true".
    // Because, A screen is Rebuilt if you focus to any text-field.
    if (needsInitialize && !_isInitialized) {
      return FutureBuilder(
        future: initialize(),
        builder: (context, projectSnap) {
          if (projectSnap.hasError) {
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  Consumer<BaseViewModel>(builder: (context, model, child) {
                    return SyntonicSliverAppBar(
                        isFullscreenDialog: appBar != null
                            ? appBar!.isFullscreenDialog
                            : false,
                        title: appBar != null ? appBar!.title : null);
                  }),
                ];
              },
              body: _errorScreen,
            );
          } else if (projectSnap.connectionState == ConnectionState.done) {
            _isInitialized = true;
            return _body;
          } else {
            return Stack(children: [
              Scaffold(
                drawer: appBar != null ? navigationDrawer : null,
                appBar: appBar != null
                    ? SyntonicSliverAppBar.fixed(
                    title: appBar!.title ?? '',
                    context: context,
                    needsNavigationDrawer: appBar!.needsNavigationDrawer,
                    trailing: appBar!.trailing)
                    : null,
                bottomSheet: bottomSheet,
              ),
              Container(child: Center(child: CircularProgressIndicator()))
            ]);
          }
        },
      );
    } else {
      return _body;
    }
  }

  /// Initialize the screen.
  ///
  /// Typically call initialization API in the screen.
  Future<dynamic>? initialize({bool isRefreshed = false}) => null;
  bool get needsInitialize => false;

  /// Get body.
  Widget get _body {
    if (appBar != null) {
      if (needsSliverAppBar) {
        return Scaffold(
          drawer: navigationDrawer,
          floatingActionButton: _floatingActionButtons,
          body: SafeArea(
              top: false,
              bottom: false,
              child: DefaultTabController(
                  length: tabs != null ? tabs!.length : 0,
                  child: NestedScrollView(
                    controller: model.scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        Consumer<BaseViewModel>(
                            builder: (context, model, child) {
                          return _appBar;
                        }),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [_headerContents],
                          ),
                        ),
                        tabs != null
                            ? SliverPersistentHeader(
                                pinned: true,
                                delegate: StickyTabBarDelegate(
                                    tabBar: _tabBar!,
                                    setStickyState: (isSticking) {
                                      model.isStickyingAppBar = isSticking;
                                      model.notifier();
                                    }))
                            : _blank,
                      ];
                    },
                    body: _notificationListener,
                  ))),
          bottomSheet: bottomSheet,
        );
      } else {
        return DefaultTabController(
            length: tabs != null ? tabs!.length : 0,
            child: Scaffold(
              drawer: navigationDrawer,
              appBar: _appBar as PreferredSizeWidget,
              body: SafeArea(
                  top: false,
                  bottom: false,
                  child: NestedScrollView(
                    controller: model.scrollController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[];
                    },
                    body: _notificationListener,
                  )),
              bottomSheet: bottomSheet,
            ));
      }
    } else {
      return Scaffold(
        floatingActionButton: _floatingActionButtons,
        body: _notificationListener,
        bottomSheet: bottomSheet,
      );
    }
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
  Widget get _mainContents {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Form(
          key: model._formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Center(
              child: Container(
                  alignment: Alignment.topLeft,
                  constraints: const BoxConstraints(
                      minWidth: double.infinity,
                      maxWidth: double.infinity),
                  child: mainContents))),
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
  Widget get mainContents;

  /// Get navigation drawer.
  Widget? get navigationDrawer => null;

  NotificationListener get _notificationListener {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (floatingActionButton != null &&
            scrollNotification is UserScrollNotification) {
          if (scrollNotification.direction == ScrollDirection.reverse) {
            this.model.changeFloatingActionButtonState(false);
          } else if (scrollNotification.direction == ScrollDirection.forward) {
            this.model.changeFloatingActionButtonState(true);
          }
        }

        // FIXME: [_streamController]を削除したら削除する。
        // Reset reloadable state.
        if (scrollNotification is ScrollStartNotification) {
          _streamController.sink.add(false);
        }

        if (scrollNotification is ScrollEndNotification) {
          if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.maxScrollExtent &&
              scrollNotification is ScrollEndNotification) {
            onReachBottom();

            // FIXME: [_streamController]を削除したら削除する。
            _streamController.sink.add(true);
          } else {
            // FIXME: [_streamController]を削除したら削除する。
            _streamController.sink.add(false);
          }

          if (scrollNotification.metrics.pixels ==
                  scrollNotification.metrics.minScrollExtent &&
              scrollNotification is ScrollEndNotification) {
            onReachTop();
          }
        }

        if (!needsSliverAppBar) {
          if (scrollNotification.metrics.pixels <=
              scrollNotification.metrics.minScrollExtent) {
            if (!model.isStickyingAppBar) {
              model.isStickyingAppBar = true;
              model.notifier();
            }
          } else {
            if (model.isStickyingAppBar) {
              model.isStickyingAppBar = false;
              model.notifier();
            }
          }
        }

        return false;
      },
      child: canSwipeToRefresh
          ? RefreshIndicator(
              // key: GlobalKey<RefreshIndicatorState>(),
              //   color: SyntonicColor.primary_color,
              onRefresh: () async {
                await onSwipeToRefresh;
              },
              child: _mainContents)
          : _mainContents,
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
      initialize(isRefreshed: true) ?? null;

  /// Get whether main content can swipe to refresh.
  ///
  /// Default is false.
  bool get canSwipeToRefresh => needsInitialize;

  /// Whether needs [SliverAppBar].
  ///
  /// Default is "true".
  ///
  /// If you set "false", use [AppBar].
  /// "false" is typically use to a screen with backdrop,
  /// Because [SliverAppBar] can slip in to underground of an [AppBar].
  /// If use [AppBar], contents is show in [AppBar] bellow.
  bool get needsSliverAppBar => true;

  /// Get providers.
  ///
  /// Default is none.
  ///
  /// Recommend to set view models that use on a screen at this function.
  /// Because view can reference view model in both [appBar] and [mainContents].
  List<SingleChildWidget>? get providers {
    return null;
  }

  /// Whether this view is root view.
  ///
  /// If this view is a root view, apply [StreamProvider] to notify that the
  /// scroll position is bottom.
  bool get isRootView => false;

  /// Get app bar.
  ///
  /// Type of an app bar ([AppBar], [SliverAppBar]) depends on
  /// [needsSliverAppBar], and also If an app bar is [AppBar] and has [_tabBar],
  /// set [_tabBar] to bottom of [Appbar].
  Widget get _appBar {
    if (needsSliverAppBar) {
      SyntonicSliverAppBar _appBar = appBar!;

      return SyntonicSliverAppBar(
          context: _appBar.context,
          title: _appBar.title,
          actions: _appBar.actions,
          accentColor: _appBar.accentColor,
          isBackButtonEnabled: _appBar.isBackButtonEnabled,
          elevation: _appBar.elevation,
          expandedHeight: _appBar.expandedHeight,
          flexibleSpace: _appBar.flexibleSpace,
          isFadedTitle: _appBar.isFadedTitle,
          isFullscreenDialog: _appBar.isFullscreenDialog,
          isStickying: model.isStickyingAppBar,
          onBackButtonPressed: _appBar.onBackButtonPressed,
          onTap: _appBar.onTap,
          needsNavigationDrawer: _appBar.needsNavigationDrawer,
          searchBox: _appBar.searchBox,
          scrollController: model.scrollController,
          subtitle: _appBar.subtitle,
          hasTabBar: tabs != null,
          manualUrl: _appBar.manualUrl,
          bottom: _appBar.bottom,
          trailing: _appBar.trailing);
    } else {
      double _height = kToolbarHeight;
      SyntonicSliverAppBar _appBar = appBar!;
      _height += _tabBar != null ? _tabBar!.preferredSize.height : 0;
      _height += _tabBar == null && _appBar.searchBox != null ? 12 : 0;
      _height +=
          _appBar.bottom != null ? _appBar.bottom!.preferredSize.height : 0;

      return PreferredSize(
          preferredSize: Size.fromHeight(_height),
          child: Consumer<BaseViewModel>(builder: (context, model, child) {
            SyntonicSliverAppBar _appBar = appBar!;

            return SyntonicSliverAppBar.fixed(
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
              isStickying: model.isStickyingAppBar,
              onBackButtonPressed: _appBar.onBackButtonPressed,
              needsNavigationDrawer: _appBar.needsNavigationDrawer,
              searchBox: _appBar.searchBox,
              scrollController: model.scrollController,
              subtitle: _appBar.subtitle,
              hasTabBar: tabs != null,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(_height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tabBar ?? const SizedBox(),
                    _appBar.bottom ?? const SizedBox()
                  ],
                ),
              ),
              trailing: _appBar.trailing,
            );
          }));
    }
  }

  /// Get floating action buttons.
  ///
  /// Apply different color to Secondary FAB than to primary FAB.
  Widget? get _floatingActionButtons {
    if (floatingActionButton != null) {
      if (floatingActionButtonSecondary != null) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _floatingActionButton(isSecondary: true),
              SizedBox(height: 16),
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
  Widget _floatingActionButton({bool isSecondary = false}) {
    return Selector2<BaseViewModel, BaseViewModel, Tuple2<bool, bool>>(
        selector: (_, baseViewModel1, baseViewModel2) => Tuple2(
            baseViewModel1.isFloatingActionButtonExtended,
            baseViewModel1.isFloatingActionButtonVisible),
        builder: (context, count, child) {
          return AnimatedOpacity(
            opacity: model.isFloatingActionButtonVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: SyntonicFloatingActionButton(
                floatingActionButtonModel: isSecondary
                    ? floatingActionButtonSecondary!
                    : floatingActionButton!,
                isExtended: this.model.isFloatingActionButtonExtended,
                isSecondary: isSecondary),
          );
        });
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

  /// Get providers.
  ///
  /// Combine provider lists in extended view (by [providers]) and this provider.
  /// If extended view is root view and including view permission in account
  /// authority, add [StreamProvider] that listen scroll event.
  List<SingleChildWidget>? get _providers {
    List<SingleChildWidget>? _providers;
    if (providers != null) {
      if (isRootView) {
        _providers = [];
        _providers = _providers + providers!;

        // FIXME: [_streamController]を削除したら削除する。
        _providers.add(StreamProvider<bool>(
            create: (_) => _streamController.stream, initialData: false));
      } else {
        _providers = providers;
      }
    } else {
      if (isRootView) {
        _providers = [];

        // FIXME: [_streamController]を削除したら削除する。
        _providers.add(StreamProvider<bool>(
            create: (_) => _streamController.stream, initialData: false));
      }
    }
    return _providers;
  }

  /// Get header contents.
  /// For listen focus event by tap, and focus out from some widgets.
  Widget get _headerContents {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: headerContents,
    );
  }

  ///TODO: InfiniteLoadingListViewなどで、scrollControllerをセットしていないと、エラーになるので、必ずセットするようにするなどチェックを検討する。
  /// Get tab bar.
  /// If Tapped same tab, scroll position of screen to top with animation.
  TabBar? get _tabBar {
    int _currentIndex = 0;
    if (tabs != null) {
      return TabBar(
        controller: tabController,
        isScrollable: tabs!.length > 2 ? true : false,
        onTap: (_index) {
          if (tabController != null
              ? !tabController!.indexIsChanging
              : _currentIndex == _index) {
            model.changeFloatingActionButtonState(true);

            // IF [headerContents] is exist.
            model.scrollController.animateTo(
              0.0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );

            childViews[_index].model.scrollController.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );

            // For screens build by stack widget.
            for (SyntonicBaseView _childView in childViews[_index].childViews) {
              _childView.model.scrollController.animateTo(
                0.0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
            }
          }

          model.setCurrentTabIndex(_index);
          _currentIndex = _index;
        },
        tabs: tabs!,
      );
    } else {
      return null;
    }
  }
}

class BaseViewModel with ChangeNotifier {
  bool isChangedAppBar = false;
  bool isFloatingActionButtonExtended = false;
  bool isFloatingActionButtonVisible = true;
  ScrollController scrollController = ScrollController();
  // ..addListener(scrollListener);
  bool isStickyingAppBar = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int? currentTabIndex = 0;

  BaseViewModel();

  /// Update the screen.
  void notifier() {
    notifyListeners();
  }

  void setCurrentTabIndex(int? index) {
    currentTabIndex = index;
    notifyListeners();
  }

  /// Change floating action button state (Extend or not).
  void changeFloatingActionButtonState(bool needsExtended) {
    if (isFloatingActionButtonExtended == needsExtended) {
      this.isFloatingActionButtonExtended = !needsExtended;
      notifyListeners();
    }
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
