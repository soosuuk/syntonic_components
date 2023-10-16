// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intrinsic_dimension/intrinsic_dimension.dart';
//
// import '../../configs/constants/syntonic_color.dart';
// import '../../services/navigation_service.dart';
// import '../buttons/syntonic_button.dart';
// import '../enhancers/syntonic_fade.dart';
// import '../icons/syntonic_icon.dart';
// import '../lists/syntonic_list_item.dart';
// import '../text_fields/syntonic_search_box.dart';
// // import 'package:weighlos/ui/shared/app_bar/invisible_expanded_header.dart';
//
// class SyntonicSliverAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const SyntonicSliverAppBar({
//     this.flexibleSpace,
//     this.flexibleSpacetmp,
//     super.key,
//     this.leading,
//     this.automaticallyImplyLeading = true,
//     // this.title,
//     this.actions,
//     this.bottom,
//     this.elevation,
//     this.scrolledUnderElevation,
//     this.shadowColor,
//     this.surfaceTintColor,
//     this.forceElevated = false,
//     this.backgroundColor,
//     this.backgroundGradient,
//     this.foregroundColor,
//     this.iconTheme,
//     this.actionsIconTheme,
//     this.primary = true,
//     this.centerTitle,
//     this.excludeHeaderSemantics = false,
//     this.titleSpacing,
//     this.collapsedHeight,
//     this.expandedHeight,
//     this.floating = false,
//     this.pinned = false,
//     this.snap = false,
//     this.stretch = false,
//     this.stretchTriggerOffset = 100.0,
//     this.onStretchTrigger,
//     this.shape,
//     this.toolbarHeight = kToolbarHeight + 20,
//     this.leadingWidth,
//     this.toolbarTextStyle,
//     this.titleTextStyle,
//     this.systemOverlayStyle,
//     this.forceMaterialTransparency = false,
//     this.clipBehavior,
//     this.appBarClipper,
//     this.isFullscreenDialog = false,
//     this.hasFadedTitle = false,
//     this.isStickying = false,
//     this.trailing,
//     this.onBackButtonPressed,
//     this.onTap,
//     this.hasNavigationDrawer = false,
//     this.searchBox,
//     this.subtitle,
//     this.title,
//     this.scrollController,
//     this.hasTabBar = false,
//   });
//   //
//   // const SyntonicSliverAppBar({
//   //   Widget? flexibleSpace,
//   //   Widget? leading,
//   //   bool automaticallyImplyLeading,
//   //   List<Widget>? actions,
//   //   PreferredSizeWidget? bottom,
//   //   double? elevation,
//   //   double? scrolledUnderElevation,
//   //   Color? shadowColor,
//   //   Color? surfaceTintColor,
//   //   bool forceElevated,
//   //   Color? backgroundColor,
//   //   LinearGradient? backgroundGradient,
//   //   Color? foregroundColor,
//   //   IconThemeData? iconTheme,
//   //   IconThemeData? actionsIconTheme,
//   //   bool primary,
//   //   bool? centerTitle,
//   //   bool excludeHeaderSemantics,
//   //   double? titleSpacing,
//   //   double? expandedHeight,
//   //   double? collapsedHeight,
//   //   // bool floating,
//   //   // bool pinned,
//   //   ShapeBorder? shape,
//   //   // double toolbarHeight,
//   //   double? leadingWidth,
//   //   TextStyle? toolbarTextStyle,
//   //   TextStyle? titleTextStyle,
//   //   SystemUiOverlayStyle? systemOverlayStyle,
//   //   // bool forceMaterialTransparency,
//   //   Clip? clipBehavior,
//   //   // bool snap,
//   //   // bool stretch,
//   //   double stretchTriggerOffset = 100.0,
//   //   AsyncCallback? onStretchTrigger,
//   //   CustomClipper<Path>? appBarClipper,
//   //   bool isFullscreenDialog = false,
//   //   bool hasFadedTitle = false,
//   //   bool isStickying = false,
//   //   Widget? trailing,
//   //   VoidCallback? onBackButtonPressed,
//   //   VoidCallback? onTap,
//   //   bool hasNavigationDrawer = false,
//   //   SyntonicSearchBox? searchBox,
//   //   String? subtitle,
//   //   String? title,
//   //   ScrollController? scrollController,
//   //   bool = false,
//   // })
//   //     : this._(
//   //     // state: _AppBarState.flexible,
//   //     // context: context,
//   //     title: title,
//   //     actions: actions,
//   //     accentColor: accentColor,
//   //     bottom: bottom,
//   //     elevation: elevation,
//   //     expandedHeight: expandedHeight,
//   //     flexibleSpace: flexibleSpace,
//   //     isBackButtonEnabled: isBackButtonEnabled,
//   //     isFadedTitle: isFadedTitle,
//   //     isFullscreenDialog: isFullscreenDialog,
//   //     isStickying: isStickying,
//   //     onBackButtonPressed: onBackButtonPressed,
//   //     onTap: onTap,
//   //     needsNavigationDrawer: needsNavigationDrawer,
//   //     searchBox: searchBox,
//   //     subtitle: subtitle,
//   //     scrollController: scrollController,
//   //     hasTabBar: hasTabBar,
//   //     manualUrl: manualUrl,
//   //     trailing: trailing);
//
//   // const SyntonicSliverAppBar._({
//   //   this.context,
//   //   this.title,
//   //   this.actions,
//   //   // this.accentColor,
//   //   this.bottom,
//   //   this.elevation,
//   //   this.expandedHeight = kToolbarHeight,
//   //   this.flexibleSpace,
//   //   // this.isBackButtonEnabled = true,
//   //   this.hasFadedTitle = false,
//   //   this.isFullscreenDialog = false,
//   //   this.isStickying = false,
//   //   this.onBackButtonPressed,
//   //   this.onTap,
//   //   this.hasNavigationDrawer = false,
//   //   this.searchBox,
//   //   this.subtitle,
//   //   this.scrollController,
//   //   this.hasTabBar = false,
//   //   // this.manualUrl,
//   //   this.trailing,
//   //   // required this.state,
//   // });
//   //
//   // /// App bar for normal state.
//   // const SyntonicSliverAppBar(
//   //     {BuildContext? context,
//   //       String? title,
//   //       List<Widget>? actions,
//   //       Color? accentColor,
//   //       PreferredSizeWidget? bottom,
//   //       double? elevation,
//   //       double? expandedHeight = kToolbarHeight,
//   //       Widget? flexibleSpace,
//   //       bool isBackButtonEnabled = true,
//   //       bool hasFadedTitle = false,
//   //       bool isFullscreenDialog = false,
//   //       bool isStickying = false,
//   //       VoidCallback? onBackButtonPressed,
//   //       VoidCallback? onTap,
//   //       bool hasNavigationDrawer = false,
//   //       SyntonicSearchBox? searchBox,
//   //       Widget? searchBox2,
//   //       String? subtitle,
//   //       ScrollController? scrollController,
//   //       bool hasTabBar = false,
//   //       String? manualUrl,
//   //       Widget? trailing,
//   //     })
//   //     : this._(
//   //     // state: _AppBarState.flexible,
//   //     context: context,
//   //     title: title,
//   //     actions: actions,
//   //     // accentColor: accentColor,
//   //     bottom: bottom,
//   //     elevation: elevation,
//   //     expandedHeight: expandedHeight,
//   //     flexibleSpace: flexibleSpace,
//   //     // isBackButtonEnabled: isBackButtonEnabled,
//   //     hasFadedTitle: hasFadedTitle,
//   //     isFullscreenDialog: isFullscreenDialog,
//   //     isStickying: isStickying,
//   //     onBackButtonPressed: onBackButtonPressed,
//   //     onTap: onTap,
//   //     hasNavigationDrawer: hasNavigationDrawer,
//   //     searchBox: searchBox,
//   //     subtitle: subtitle,
//   //     scrollController: scrollController,
//   //     hasTabBar: hasTabBar,
//   //     // manualUrl: manualUrl,
//   //     trailing: trailing);
//   //
//   // /// App bar for fullscreen dialog.
//   // SyntonicSliverAppBar.fullscreenDialog({
//   //   required BuildContext context,
//   //   String? actionButtonText,
//   //   double? expandedHeight = kToolbarHeight,
//   //   String? title,
//   //   List<Widget>? actionIcons,
//   //   Color? accentColor,
//   //   PreferredSize? bottom,
//   //   double? elevation,
//   //   Widget? flexibleSpace,
//   //   bool isActionButtonEnabled = true,
//   //   bool isBackButtonEnabled = true,
//   //   bool needsNavigationDrawer = false,
//   //   // bool needsNavigationDrawer = false,
//   //   bool hasFadedTitle = false,
//   //   VoidCallback? onActionButtonPressed,
//   //   VoidCallback? onBackButtonPressed,
//   //   VoidCallback? onTap,
//   //   SyntonicSearchBox? searchBox,
//   //   String? subtitle,
//   //   String? manualUrl,
//   //   Widget? trailing,
//   // }) : this._(
//   //     // state: _AppBarState.flexible,
//   //     // context: context,
//   //     title: title,
//   //     trailing: trailing,
//   //     // manualUrl: manualUrl,
//   //     actions: actionIcons != null
//   //         ? actionIcons +
//   //         [
//   //           if (actionButtonText != null)
//   //             _getActionButton(
//   //                 actionButtonText: actionButtonText,
//   //                 // context: context,
//   //                 isActionButtonEnabled: isActionButtonEnabled,
//   //                 onActionButtonPressed: onActionButtonPressed)
//   //         ]
//   //         : [
//   //       if (actionButtonText != null)
//   //         _getActionButton(
//   //             actionButtonText: actionButtonText,
//   //             // context: context,
//   //             isActionButtonEnabled: isActionButtonEnabled,
//   //             onActionButtonPressed: onActionButtonPressed)
//   //     ],
//   //     // accentColor: accentColor,
//   //     // isBackButtonEnabled: isBackButtonEnabled,
//   //     hasNavigationDrawer: needsNavigationDrawer,
//   //     bottom: bottom,
//   //     elevation: elevation,
//   //     expandedHeight: expandedHeight,
//   //     flexibleSpace: FlexibleSpaceBar(
//   //       collapseMode: CollapseMode.pin,
//   //       background: ConstrainedBox(
//   //         constraints: BoxConstraints(
//   //           maxWidth: MediaQuery.of(context).size.width,
//   //         ),
//   //         child: flexibleSpace,
//   //       ),
//   //     ),
//   //     hasFadedTitle: hasFadedTitle,
//   //     isFullscreenDialog: true,
//   //     onBackButtonPressed: onBackButtonPressed,
//   //     onTap: onTap,
//   //     searchBox: searchBox,
//   //     subtitle: subtitle);
//
//   final Widget? flexibleSpace;
//   final Widget? flexibleSpacetmp;
//   final Widget? leading;
//   final bool automaticallyImplyLeading;
//   // final Widget? title;
//   final List<Widget>? actions;
//   final PreferredSizeWidget? bottom;
//   final double? elevation;
//   final double? scrolledUnderElevation;
//   final Color? shadowColor;
//   final Color? surfaceTintColor;
//   final bool forceElevated;
//   final Color? backgroundColor;
//
//   /// If backgroundGradient is non null, backgroundColor will be ignored
//   final LinearGradient? backgroundGradient;
//   final Color? foregroundColor;
//   final IconThemeData? iconTheme;
//   final IconThemeData? actionsIconTheme;
//   final bool primary;
//   final bool? centerTitle;
//   final bool excludeHeaderSemantics;
//   final double? titleSpacing;
//   final double? expandedHeight;
//   final double? collapsedHeight;
//   final bool floating;
//   final bool pinned;
//   final ShapeBorder? shape;
//   final double toolbarHeight;
//   final double? leadingWidth;
//   final TextStyle? toolbarTextStyle;
//   final TextStyle? titleTextStyle;
//   final SystemUiOverlayStyle? systemOverlayStyle;
//   final bool forceMaterialTransparency;
//   final Clip? clipBehavior;
//   final bool snap;
//   final bool stretch;
//   final double stretchTriggerOffset;
//   final AsyncCallback? onStretchTrigger;
//   final CustomClipper<Path>? appBarClipper;
//
//   final bool isFullscreenDialog;
//   final bool hasFadedTitle;
//   final bool isStickying;
//   final Widget? trailing;
//   final VoidCallback? onBackButtonPressed;
//   final VoidCallback? onTap;
//   final bool hasNavigationDrawer;
//   final SyntonicSearchBox? searchBox;
//   final String? subtitle;
//   final String? title;
//   final ScrollController? scrollController;
//   final bool hasTabBar;
//   // final BuildContext? context;
//
//   @override
//   _DynamicSliverAppBarState createState() => _DynamicSliverAppBarState();
//
//   @override
//   Size get preferredSize {
//     double _height = kToolbarHeight;
//     if (bottom != null) {
//       _height += bottom!.preferredSize.height;
//     }
//     return Size.fromHeight(_height);
//   }
//
//   static Widget _getActionButton({
//     required String actionButtonText,
//     required BuildContext context,
//     required bool isActionButtonEnabled,
//     VoidCallback? onActionButtonPressed,
//   }) {
//     return SyntonicButton.filled(
//       onTap: isActionButtonEnabled
//           ? onActionButtonPressed ?? () => Navigator.maybePop(context)
//           : () => {},
//       text: actionButtonText,
//     );
//   }
//
//   static Widget _getManualIcon(
//       {String? manualUrl, required BuildContext context}) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: IconButton(
//         icon: const Icon(
//           Icons.help,
//           color: SyntonicColor.primary_color,
//         ),
//         onPressed: () {
//           NavigationService.launchUrlInBrowser(url: manualUrl ?? '');
//         },
//       ),
//     );
//   }
// }
//
// class _DynamicSliverAppBarState extends State<SyntonicSliverAppBar> {
//   final GlobalKey _childKey = GlobalKey();
//
//   // As long as the height is 0 instead of the sliver app bar a sliver to box adapter will be used
//   // to calculate dynamically the size for the sliver app bar
//   double _height = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     // _updateHeight();
//   }
//
//   @override
//   void didUpdateWidget(covariant SyntonicSliverAppBar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // _updateHeight();
//   }
//
//   void _updateHeight() {
//     // Gets the new height and updates the sliver app bar. Needs to be called after the last frame has been rebuild
//     // otherwise this will throw an error
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       if (_childKey.currentContext == null) return;
//       setState(() {
//         _height = (_childKey.currentContext!.findRenderObject()! as RenderBox).size.height;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Needed to lay out the flexibleSpace the first time, so we can calculate its intrinsic height
//     // if (_height == 0) {
//     //   return SliverToBoxAdapter(
//     //     child: Stack(
//     //       children: [
//     //         Padding(
//     //           // Padding which centers the flexible space within the app bar
//     //           padding: EdgeInsets.symmetric(vertical: MediaQuery.paddingOf(context).top / 2),
//     //           child: Container(key: _childKey, child: Opacity(opacity: 0, child: widget.flexibleSpacetmp!) ?? SizedBox(height: kToolbarHeight)),
//     //         ),
//     //         Positioned.fill(
//     //           // 10 is the magic number which the app bar is pushed down within the sliver app bar. Couldnt find exactly where this number
//     //           // comes from and found it through trial and error.
//     //           top: 10,
//     //           child: Align(
//     //             alignment: Alignment.topCenter,
//     //             child: AppBar(
//     //               backgroundColor: Colors.transparent,
//     //               elevation: 0,
//     //               leading: widget.leading,
//     //               actions: widget.actions,
//     //             ),
//     //           ),
//     //         )
//     //       ],
//     //     ),
//     //   );
//     // }
//
//     final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
//     final bool useCloseButton =
//         parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
//     bool isDarkTheme =
//         MediaQuery.of(context).platformBrightness == Brightness.dark;
//
//     Widget _title = widget.searchBox ??
//         SyntonicListItem(
//           title: widget.title ?? '',
//           subtitle: widget.subtitle,
//           titleTextStyle: TitleTextStyle.Headline6,
//           hasPadding: false,
//           titleColor: Theme.of(context).colorScheme.primary,
//           trailingWidget: widget.trailing,
//           needsTitleOverFlowStateVisible: false,
//           needsSubtitleOverFlowStateVisible: false,
//           optionalWidgetTitle: widget.onTap != null ? const Icon(Icons.arrow_drop_down_outlined) : null,
//         );
//
//     // return SliverAppBar(
//     //   // backgroundColor: !isStickying ? ElevationOverlay.applyOverlay(context, Theme.of(context).colorScheme.surface, 4) : null,
//     //     leading: widget.hasNavigationDrawer
//     //         ? null
//     //         : useCloseButton
//     //         ? SyntonicIcon(icon: Icons.close, padding: 0, onPressed: () => widget.onBackButtonPressed ?? Navigator.pop(context))
//     //         : BackButton(
//     //         onPressed: widget.onBackButtonPressed,),
//     //     stretch: true,
//     //     snap: widget.hasFadedTitle ? false : true,
//     //     floating: true,
//     //     pinned: (widget.isFullscreenDialog || widget.hasTabBar || widget.hasFadedTitle) ? true : false,
//     //     title: widget.hasFadedTitle
//     //         ? SyntonicFade(
//     //         zeroOpacityOffset: widget.expandedHeight! - kToolbarHeight,
//     //         fullOpacityOffset: widget.expandedHeight!,
//     //         child: _title,
//     //         scrollController: widget.scrollController!)
//     //         : _title,
//     // //     actions: widget.manualUrl != null && actions != null
//     // //     ?
//     // //     [ _getManualIcon(manualUrl: manualUrl, context: context),
//     // //
//     // //     ]  + actions!
//     // //     :  manualUrl != null ?  [ _getManualIcon(manualUrl: manualUrl, context: context),
//     // //
//     // // ] : actions,
//     // elevation: widget.elevation ?? (widget.isStickying ? 0 : 4),
//     // expandedHeight: _height,
//     // flexibleSpace: widget.flexibleSpace,
//     // bottom: widget.bottom,
//     // // bottom: bottom != null ? PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight), child: Material(
//     // //     // elevation: overlapsContent ? 4.0 : 0,
//     // //     color: Colors.transparent,
//     // //     child: Stack(alignment: Alignment.bottomCenter,children: [Divider(
//     // //       height: 0,
//     // //       color: !isStickying ? null : isDarkTheme ? Colors.white54 : Colors.black12,
//     // //     ), Container(width: double.infinity, child: bottom,) as Widget],))) : null,
//     //
//     // );
//
//     return SliverAppBar(
//       // leading: widget.leading,
//       leading: widget.hasNavigationDrawer
//           ? null
//           : useCloseButton
//           ? SyntonicIcon(icon: Icons.close, padding: 0, onPressed: () => widget.onBackButtonPressed ?? Navigator.pop(context))
//           : BackButton(
//           onPressed: widget.onBackButtonPressed, color: Theme.of(context).colorScheme.primary),
//       automaticallyImplyLeading: widget.automaticallyImplyLeading,
//       // title: widget.title,
//       // title: widget.hasFadedTitle
//       //     ? SyntonicFade(
//       //     zeroOpacityOffset: _height - kToolbarHeight,
//       //     fullOpacityOffset: _height,
//       //     child: _title,
//       //     scrollController: widget.scrollController!)
//       //     : _title,
//       actions: widget.actions,
//       bottom: widget.bottom,
//       elevation: widget.elevation,
//       // elevation: widget.elevation ?? (widget.isStickying ? 0 : 4),
//       scrolledUnderElevation: widget.scrolledUnderElevation,
//       shadowColor: widget.shadowColor,
//       surfaceTintColor: widget.surfaceTintColor,
//       forceElevated: widget.forceElevated,
//       backgroundColor: widget.backgroundColor,
//       foregroundColor: widget.foregroundColor,
//       iconTheme: widget.iconTheme,
//       actionsIconTheme: widget.actionsIconTheme,
//       primary: widget.primary,
//       centerTitle: widget.centerTitle,
//       excludeHeaderSemantics: widget.excludeHeaderSemantics,
//       titleSpacing: widget.titleSpacing,
//       collapsedHeight: widget.collapsedHeight,
//       floating: widget.floating,
//       pinned: widget.pinned,
//       snap: widget.snap,
//       stretch: widget.stretch,
//       // stretch: true,
//       // snap: widget.hasFadedTitle ? false : true,
//       // floating: true,
//       // pinned: (widget.isFullscreenDialog || widget.hasTabBar || widget.hasFadedTitle) ? true : false,
//       stretchTriggerOffset: widget.stretchTriggerOffset,
//       onStretchTrigger: widget.onStretchTrigger,
//       shape: widget.shape,
//       toolbarHeight: widget.toolbarHeight,
//       expandedHeight: widget.expandedHeight,
//       leadingWidth: widget.leadingWidth,
//       toolbarTextStyle: widget.toolbarTextStyle,
//       titleTextStyle: widget.titleTextStyle,
//       systemOverlayStyle: widget.systemOverlayStyle,
//       forceMaterialTransparency: widget.forceMaterialTransparency,
//       clipBehavior: widget.clipBehavior,
//       flexibleSpace: IntrinsicDimension(
//           listener: (context, width, height, startOffset) {
//             print('WIDTH: $width');
//             print('HEIGHT: $height');
//             print('OFFSET: $startOffset');
//             setState(() {
//               _height = height + kToolbarHeight + 20;
//             });
//           },
//           builder: (context, width, height, startOffset) => widget.flexibleSpace!),
//     );
//   }
// }
//
//
//
//
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// //
// // import '../icons/syntonic_icon.dart';
// // // import 'package:weighlos/ui/shared/app_bar/invisible_expanded_header.dart';
// //
// // class SyntonicSliverAppBar extends StatefulWidget implements PreferredSizeWidget {
// //   const SyntonicSliverAppBar({
// //     this.flexibleSpace,
// //     super.key,
// //     this.leading,
// //     this.automaticallyImplyLeading = true,
// //     this.title,
// //     this.actions,
// //     this.bottom,
// //     this.elevation,
// //     this.scrolledUnderElevation,
// //     this.shadowColor,
// //     this.surfaceTintColor,
// //     this.forceElevated = false,
// //     this.backgroundColor,
// //     this.backgroundGradient,
// //     this.foregroundColor,
// //     this.iconTheme,
// //     this.actionsIconTheme,
// //     this.primary = true,
// //     this.centerTitle,
// //     this.excludeHeaderSemantics = false,
// //     this.titleSpacing,
// //     this.collapsedHeight,
// //     this.expandedHeight,
// //     this.floating = false,
// //     this.pinned = false,
// //     this.snap = false,
// //     this.stretch = false,
// //     this.stretchTriggerOffset = 100.0,
// //     this.onStretchTrigger,
// //     this.shape,
// //     this.toolbarHeight = kToolbarHeight + 20,
// //     this.leadingWidth,
// //     this.toolbarTextStyle,
// //     this.titleTextStyle,
// //     this.systemOverlayStyle,
// //     this.forceMaterialTransparency = false,
// //     this.clipBehavior,
// //     this.appBarClipper,
// //     this.isFullscreenDialog = false,
// //   });
// //
// //   final Widget? flexibleSpace;
// //   final Widget? leading;
// //   final bool automaticallyImplyLeading;
// //   final Widget? title;
// //   final List<Widget>? actions;
// //   final PreferredSizeWidget? bottom;
// //   final double? elevation;
// //   final double? scrolledUnderElevation;
// //   final Color? shadowColor;
// //   final Color? surfaceTintColor;
// //   final bool forceElevated;
// //   final Color? backgroundColor;
// //
// //   /// If backgroundGradient is non null, backgroundColor will be ignored
// //   final LinearGradient? backgroundGradient;
// //   final Color? foregroundColor;
// //   final IconThemeData? iconTheme;
// //   final IconThemeData? actionsIconTheme;
// //   final bool primary;
// //   final bool? centerTitle;
// //   final bool excludeHeaderSemantics;
// //   final double? titleSpacing;
// //   final double? expandedHeight;
// //   final double? collapsedHeight;
// //   final bool floating;
// //   final bool pinned;
// //   final ShapeBorder? shape;
// //   final double toolbarHeight;
// //   final double? leadingWidth;
// //   final TextStyle? toolbarTextStyle;
// //   final TextStyle? titleTextStyle;
// //   final SystemUiOverlayStyle? systemOverlayStyle;
// //   final bool forceMaterialTransparency;
// //   final Clip? clipBehavior;
// //   final bool snap;
// //   final bool stretch;
// //   final double stretchTriggerOffset;
// //   final AsyncCallback? onStretchTrigger;
// //   final CustomClipper<Path>? appBarClipper;
// //
// //   final bool isFullscreenDialog;
// //
// //   @override
// //   _DynamicSliverAppBarState createState() => _DynamicSliverAppBarState();
// //
// //   @override
// //   Size get preferredSize {
// //     double _height = kToolbarHeight;
// //     if (bottom != null) {
// //       _height += bottom!.preferredSize.height;
// //     }
// //     return Size.fromHeight(_height);
// //   }
// // }
// //
// // class _DynamicSliverAppBarState extends State<SyntonicSliverAppBar> {
// //   final GlobalKey _childKey = GlobalKey();
// //
// //   // As long as the height is 0 instead of the sliver app bar a sliver to box adapter will be used
// //   // to calculate dynamically the size for the sliver app bar
// //   double _height = 0;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _updateHeight();
// //   }
// //
// //   @override
// //   void didUpdateWidget(covariant SyntonicSliverAppBar oldWidget) {
// //     super.didUpdateWidget(oldWidget);
// //     _updateHeight();
// //   }
// //
// //   void _updateHeight() {
// //     // Gets the new height and updates the sliver app bar. Needs to be called after the last frame has been rebuild
// //     // otherwise this will throw an error
// //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //       if (_childKey.currentContext == null) return;
// //       setState(() {
// //         _height = (_childKey.currentContext!.findRenderObject()! as RenderBox).size.height;
// //       });
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     //Needed to lay out the flexibleSpace the first time, so we can calculate its intrinsic height
// //     if (_height == 0) {
// //       return SliverToBoxAdapter(
// //         child: Stack(
// //           children: [
// //             Padding(
// //               // Padding which centers the flexible space within the app bar
// //               padding: EdgeInsets.symmetric(vertical: MediaQuery.paddingOf(context).top / 2),
// //               child: Container(key: _childKey, child: widget.flexibleSpace ?? SizedBox(height: kToolbarHeight)),
// //             ),
// //             Positioned.fill(
// //               // 10 is the magic number which the app bar is pushed down within the sliver app bar. Couldnt find exactly where this number
// //               // comes from and found it through trial and error.
// //               top: 10,
// //               child: Align(
// //                 alignment: Alignment.topCenter,
// //                 child: AppBar(
// //                   backgroundColor: Colors.transparent,
// //                   elevation: 0,
// //                   leading: widget.leading,
// //                   actions: widget.actions,
// //                 ),
// //               ),
// //             )
// //           ],
// //         ),
// //       );
// //     }
// //
// //     return SliverAppBar(
// //       // leading: needsNavigationDrawer
// //       //     ? null
// //       //     : useCloseButton
// //       //     ? SyntonicIcon(icon: Icons.close, padding: 0, onPressed: () => onBackButtonPressed ?? Navigator.pop(context))
// //       //     : BackButton(
// //       //     onPressed: this.onBackButtonPressed, color: this.accentColor),
// //       leading: SyntonicIcon(icon: Icons.close, padding: 0, onPressed: () => Navigator.pop(context)),
// //       automaticallyImplyLeading: widget.automaticallyImplyLeading,
// //       title: widget.title,
// //       actions: widget.actions,
// //       bottom: widget.bottom,
// //       elevation: widget.elevation,
// //       scrolledUnderElevation: widget.scrolledUnderElevation,
// //       shadowColor: widget.shadowColor,
// //       surfaceTintColor: widget.surfaceTintColor,
// //       forceElevated: widget.forceElevated,
// //       backgroundColor: widget.backgroundColor,
// //       foregroundColor: widget.foregroundColor,
// //       iconTheme: widget.iconTheme,
// //       actionsIconTheme: widget.actionsIconTheme,
// //       primary: widget.primary,
// //       centerTitle: widget.centerTitle,
// //       excludeHeaderSemantics: widget.excludeHeaderSemantics,
// //       titleSpacing: widget.titleSpacing,
// //       collapsedHeight: widget.collapsedHeight,
// //       floating: widget.floating,
// //       pinned: widget.pinned,
// //       snap: widget.snap,
// //       stretch: widget.stretch,
// //       stretchTriggerOffset: widget.stretchTriggerOffset,
// //       onStretchTrigger: widget.onStretchTrigger,
// //       shape: widget.shape,
// //       toolbarHeight: widget.toolbarHeight,
// //       expandedHeight: _height,
// //       leadingWidth: widget.leadingWidth,
// //       toolbarTextStyle: widget.toolbarTextStyle,
// //       titleTextStyle: widget.titleTextStyle,
// //       systemOverlayStyle: widget.systemOverlayStyle,
// //       forceMaterialTransparency: widget.forceMaterialTransparency,
// //       clipBehavior: widget.clipBehavior,
// //       flexibleSpace: FlexibleSpaceBar(background: widget.flexibleSpace),
// //     );
// //   }
// // }