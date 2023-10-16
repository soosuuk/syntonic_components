import 'package:syntonic_components/configs/themes/syntonic_elevated_button_theme.dart';
import 'package:syntonic_components/widgets/buttons/syntonic_button.dart';
import 'package:syntonic_components/widgets/enhancers/syntonic_animation_enhancer.dart';
import 'package:syntonic_components/widgets/text_fields/syntonic_search_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syntonic_components/widgets/texts/body_1_text.dart';

import '../../configs/constants/syntonic_color.dart';
import '../../services/navigation_service.dart';
import '../enhancers/syntonic_fade.dart';
import '../icons/syntonic_icon.dart';
import '../lists/syntonic_list_item.dart';
import '../syntonic_base_view.dart';

enum _AppBarState {
  flexible,
  fixed,
}

class SyntonicSliverAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final BuildContext? context;
  final List<Widget>? actions;
  final double? expandedHeight;
  final String? title;
  final Color? accentColor;
  final double? elevation;
  final Widget? flexibleSpace;
  final bool isBackButtonEnabled;
  final bool isFadedTitle;
  final bool isFullscreenDialog;
  final bool isStickying;
  final VoidCallback? onBackButtonPressed;
  final VoidCallback? onTap;
  final bool needsNavigationDrawer;
  final SyntonicSearchBox? searchBox;
  final String? subtitle;
  final ScrollController? scrollController;
  final bool hasTabBar;
  final PreferredSizeWidget? bottom;
  final String? manualUrl;
  final Widget? trailing;
  final _AppBarState state;

  const SyntonicSliverAppBar._({
    this.context,
    this.title,
    this.actions,
    this.accentColor,
    this.bottom,
    this.elevation,
    this.expandedHeight = kToolbarHeight,
    this.flexibleSpace,
    this.isBackButtonEnabled = true,
    this.isFadedTitle = false,
    this.isFullscreenDialog = false,
    this.isStickying = false,
    this.onBackButtonPressed,
    this.onTap,
    this.needsNavigationDrawer = false,
    this.searchBox,
    this.subtitle,
    this.scrollController,
    this.hasTabBar = false,
    this.manualUrl,
    this.trailing,
    required this.state,
  });

  /// App bar for normal state.
  const SyntonicSliverAppBar(
      {BuildContext? context,
      String? title,
      List<Widget>? actions,
      Color? accentColor,
      PreferredSizeWidget? bottom,
      double? elevation,
      double? expandedHeight = kToolbarHeight,
      Widget? flexibleSpace,
      bool isBackButtonEnabled = true,
      bool isFadedTitle = false,
      bool isFullscreenDialog = false,
      bool isStickying = false,
      VoidCallback? onBackButtonPressed,
      VoidCallback? onTap,
      bool needsNavigationDrawer = false,
      SyntonicSearchBox? searchBox,
        Widget? searchBox2,
      String? subtitle,
      ScrollController? scrollController,
      bool hasTabBar = false,
      String? manualUrl,
      Widget? trailing})
      : this._(
            state: _AppBarState.flexible,
            context: context,
            title: title,
            actions: actions,
            accentColor: accentColor,
            bottom: bottom,
            elevation: elevation,
            expandedHeight: expandedHeight,
            flexibleSpace: flexibleSpace,
            isBackButtonEnabled: isBackButtonEnabled,
            isFadedTitle: isFadedTitle,
            isFullscreenDialog: isFullscreenDialog,
            isStickying: isStickying,
            onBackButtonPressed: onBackButtonPressed,
            onTap: onTap,
            needsNavigationDrawer: needsNavigationDrawer,
            searchBox: searchBox,
            subtitle: subtitle,
            scrollController: scrollController,
            hasTabBar: hasTabBar,
            manualUrl: manualUrl,
            trailing: trailing);

  /// App bar for normal state.
  const SyntonicSliverAppBar.fixed(
      {BuildContext? context,
      String? title,
      List<Widget>? actions,
      Color? accentColor,
      PreferredSizeWidget? bottom,
      double? elevation,
      double? expandedHeight = kToolbarHeight,
      Widget? flexibleSpace,
      bool isBackButtonEnabled = true,
      bool isFadedTitle = false,
      bool isFullscreenDialog = false,
      bool isStickying = false,
      VoidCallback? onBackButtonPressed,
      VoidCallback? onTap,
      bool needsNavigationDrawer = false,
        SyntonicSearchBox? searchBox,
      String? subtitle,
      ScrollController? scrollController,
      bool hasTabBar = false,
      String? manualUrl,
      Widget? trailing})
      : this._(
            state: _AppBarState.fixed,
            context: context,
            title: title,
            actions: actions,
            accentColor: accentColor,
            bottom: bottom,
            elevation: elevation,
            expandedHeight: expandedHeight,
            flexibleSpace: flexibleSpace,
            isBackButtonEnabled: isBackButtonEnabled,
            isFadedTitle: isFadedTitle,
            isFullscreenDialog: isFullscreenDialog,
            isStickying: isStickying,
            onBackButtonPressed: onBackButtonPressed,
            onTap: onTap,
            needsNavigationDrawer: needsNavigationDrawer,
            searchBox: searchBox,
            subtitle: subtitle,
            scrollController: scrollController,
            hasTabBar: hasTabBar,
            manualUrl: manualUrl,
            trailing: trailing);

  /// App bar for fullscreen dialog.
  SyntonicSliverAppBar.fullscreenDialog({
    required BuildContext context,
    String? actionButtonText,
    double? expandedHeight = kToolbarHeight,
    String? title,
    List<Widget>? actionIcons,
    Color? accentColor,
    PreferredSize? bottom,
    double? elevation,
    Widget? flexibleSpace,
    bool isActionButtonEnabled = true,
    bool isBackButtonEnabled = true,
    bool needsNavigationDrawer = false,
    // bool needsNavigationDrawer = false,
    bool isFadedTitle = false,
    VoidCallback? onActionButtonPressed,
    VoidCallback? onBackButtonPressed,
    VoidCallback? onTap,
    SyntonicSearchBox? searchBox,
    String? subtitle,
    String? manualUrl,
    Widget? trailing,
  }) : this._(
            state: _AppBarState.flexible,
            context: context,
            title: title,
            trailing: trailing,
            manualUrl: manualUrl,
            actions: actionIcons != null
                ? actionIcons +
                    [
                      if (actionButtonText != null)
                        _getActionButton(
                            actionButtonText: actionButtonText,
                            context: context,
                            isActionButtonEnabled: isActionButtonEnabled,
                            onActionButtonPressed: onActionButtonPressed)
                    ]
                : [
                    if (actionButtonText != null)
                      _getActionButton(
                          actionButtonText: actionButtonText,
                          context: context,
                          isActionButtonEnabled: isActionButtonEnabled,
                          onActionButtonPressed: onActionButtonPressed)
                  ],
            accentColor: accentColor,
            isBackButtonEnabled: isBackButtonEnabled,
            needsNavigationDrawer: needsNavigationDrawer,
            bottom: bottom,
            elevation: elevation,
            expandedHeight: expandedHeight,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: flexibleSpace,
              ),
            ),
            isFadedTitle: isFadedTitle,
            isFullscreenDialog: true,
            onBackButtonPressed: onBackButtonPressed,
            onTap: onTap,
            searchBox: searchBox,
            subtitle: subtitle);

  @override
  Widget build(BuildContext context) {
    // Check whether should be close button.
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    // Widget _title = SyntonicSearchBox(
    //     value: "null",
    //     // value: context.read<SearchViewModel>().searchWord,
    //     onTap: () async {
    //       // context.read<SearchViewModel>().showSearchBoxView(
    //       //     context: context,
    //       //     baseSearchViewModel:
    //       //     Provider.of<SearchViewModel>(context, listen: false));
    //       // super.model.notifier();
    //       // final String? _searchWord = await NavigationService.pushScreen(
    //       //     screen: SearchBoxView(
    //       //       keyword: null,),
    //       //     context: context);
    //
    //       // // Receive a search keyword, and Notify change.
    //       // if (_searchWord != null) {
    //       //   this.searchWord = _searchWord;
    //       //   notifyListeners();
    //       //   this.baseViewModel.notifier();
    //       //   _changeShouldReFetchStatus();
    //       // }
    //     },
    //     onSearchButtonTap: (searchWord) {});
    Widget _title = searchBox ??
        SyntonicListItem(
          title: this.title ?? '',
          subtitle: this.subtitle,
          titleTextStyle: TitleTextStyle.Headline6,
          hasPadding: false,
          titleColor: accentColor,
          trailingWidget: this.trailing,
          needsTitleOverFlowStateVisible: false,
          needsSubtitleOverFlowStateVisible: false,
          optionalWidgetTitle: onTap != null ? const Icon(Icons.arrow_drop_down_outlined) : null,
        );

        return SliverAppBar(
          surfaceTintColor: isStickying ? Theme.of(context).colorScheme.surfaceTint : Colors.transparent,
            backgroundColor: isStickying ? Theme.of(context).colorScheme.surface : Colors.transparent,
      // backgroundColor: !isStickying ? ElevationOverlay.applyOverlay(context, Theme.of(context).colorScheme.surface, 4) : null,
      leading: needsNavigationDrawer
          ? null
          : useCloseButton
          ? SyntonicAnimationEnhancer(child: SyntonicIcon(icon: Icons.close, padding: 0, onPressed: () => onBackButtonPressed ?? Navigator.pop(context)))
          : BackButton(
          onPressed: this.onBackButtonPressed, color: this.accentColor),
      iconTheme: IconThemeData(
        color: this.accentColor, //change your color here
      ),
      stretch: true,
      snap: isFadedTitle ? false : true,
      floating: true,
      pinned: (this.isFullscreenDialog || this.hasTabBar || isFadedTitle) ? true : false,
      title: isFadedTitle
          ? SyntonicFade.on(
          zeroOpacityOffset: 0,
          fullOpacityOffset: expandedHeight!,
              // zeroOpacityOffset: expandedHeight! - kToolbarHeight,
              // fullOpacityOffset: expandedHeight!,
              child: _title,
              scrollController: scrollController!)
          : _title,
      actions: manualUrl != null && actions != null
          ?
      [ _getManualIcon(manualUrl: manualUrl, context: context),

      ]  + actions!
          :  manualUrl != null ?  [ _getManualIcon(manualUrl: manualUrl, context: context),

      ] : actions,
      elevation: elevation ?? (this.isStickying ? 0 : 4),
      // expandedHeight: this.expandedHeight,
      // flexibleSpace: flexibleSpace,
      bottom: bottom,
      // bottom: bottom != null ? PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight), child: Material(
      //     // elevation: overlapsContent ? 4.0 : 0,
      //     color: Colors.transparent,
      //     child: Stack(alignment: Alignment.bottomCenter,children: [Divider(
      //       height: 0,
      //       color: !isStickying ? null : isDarkTheme ? Colors.white54 : Colors.black12,
      //     ), Container(width: double.infinity, child: bottom,) as Widget],))) : null,

    );
  }

  static Widget _getActionButton({
    required String actionButtonText,
    required BuildContext context,
    required bool isActionButtonEnabled,
    VoidCallback? onActionButtonPressed,
  }) {
    return SyntonicButton.filled(
      onTap: isActionButtonEnabled
          ? onActionButtonPressed ?? () => Navigator.maybePop(context)
          : () => {},
      text: actionButtonText,
    );
  }

  static Widget _getManualIcon(
      {String? manualUrl, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: IconButton(
        icon: const Icon(
          Icons.help,
          color: SyntonicColor.primary_color,
        ),
        onPressed: () {
          NavigationService.launchUrlInBrowser(url: manualUrl ?? '');
        },
      ),
    );
  }

  @override
  Size get preferredSize {
    double _height = kToolbarHeight;
    if (bottom != null) {
      _height += bottom!.preferredSize.height;
    }
    return Size.fromHeight(_height);
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  const StickyTabBarDelegate(
      {required this.tabBar, required this.setStickyState,});
  final TabBar tabBar;
  final Function(bool) setStickyState;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      this.setStickyState(overlapsContent);
    });
    bool isDarkTheme =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    Color _color = Theme.of(context).colorScheme.surface;
    return Material(
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        elevation: overlapsContent ? 4.0 : 0,
        color: _color,
        child: Container(
          width: double.infinity,
          child: tabBar,
        ));
  }

  @override
  bool shouldRebuild(StickyTabBarDelegate oldDelegate) {
    return this.tabBar != oldDelegate.tabBar;
  }
}

class TabModel {
  String tabTitle;
  SyntonicBaseView tabView;

  TabModel({required this.tabTitle, required this.tabView});
}
