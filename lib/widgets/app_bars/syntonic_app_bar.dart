// import 'package:syntonic_components/widgets/search_box.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../configs/themes/syntonic_color.dart';
// import '../services/navigation_service.dart';
// import 'fade.dart';
// import 'lists/basic_list_item.dart';
//
// class SyntonicAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final BuildContext? context;
//   final List<Widget>? actions;
//   final double? expandedHeight;
//   final String? title;
//   final Color? accentColor;
//   final Color? backButtonColor;
//   final double? elevation;
//   final Widget? flexibleSpace;
//   final bool isFadedTitle;
//   final bool isFullscreenDialog;
//   final bool isStickying;
//   final VoidCallback? onBackButtonPressed;
//   final VoidCallback? onTap;
//   final bool needsNavigationDrawer;
//   final SearchBox? searchBox;
//   final String? subtitle;
//   final ScrollController? scrollController;
//   final bool hasTabBar;
//   final PreferredSizeWidget? bottom;
//   final String? manualUrl;
//   final Widget? trailing;
//
//   /// App bar for normal state.
//   const SyntonicAppBar(
//       {this.context,
//         this.title,
//         this.actions,
//         this.accentColor,
//         this.backButtonColor,
//         this.bottom,
//         this.elevation,
//         this.expandedHeight = kToolbarHeight,
//         this.flexibleSpace,
//         this.isFadedTitle = false,
//         this.isFullscreenDialog = false,
//         this.isStickying = false,
//         this.onBackButtonPressed,
//         this.onTap,
//         this.needsNavigationDrawer = false,
//         this.searchBox,
//         this.subtitle,
//         this.scrollController,
//         this.hasTabBar = false,
//         this.manualUrl,
//       this.trailing});
//
//   /// App bar for fullscreen dialog.
//   SyntonicAppBar.fullscreenDialog(
//       {required BuildContext context,
//         required String actionButtonText,
//         double? expandedHeight,
//         String? title,
//         List<Widget>? actionIcons,
//         Color? accentColor,
//         Color? actionButtonColor,
//         Color? backButtonColor,
//         PreferredSizeWidget? bottom,
//         Color? actionButtonTextColor,
//         double? elevation,
//         Widget? flexibleSpace,
//         bool isFadedTitle = false,
//         VoidCallback? onActionButtonPressed,
//         VoidCallback? onBackButtonPressed,
//         VoidCallback? onTap,
//         SearchBox? searchBox,
//         String? subtitle,
//         Widget? trailing,
//       })
//       : this(
//       context: context,
//       title: title,
//       trailing: trailing,
//       actions: actionIcons != null
//           ? actionIcons +
//           [
//             Padding(
//               padding: EdgeInsets.all(10.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     primary: actionButtonColor,
//                     onPrimary: actionButtonTextColor,
//                     elevation: 0
//                 ),
//                 onPressed: onActionButtonPressed,
//                 child: Text(actionButtonText),
//               ),
//             )
//           ]
//           : [
//         Padding(
//           padding: EdgeInsets.all(10.0),
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 primary: actionButtonColor,
//                 onPrimary: actionButtonTextColor,
//                 elevation: 0
//             ),
//             onPressed: onActionButtonPressed ??
//                     () => Navigator.maybePop(context),
//             child: Text(actionButtonText),
//           ),
//         )
//       ],
//       accentColor: accentColor,
//       backButtonColor: backButtonColor,
//       bottom: bottom,
//       elevation: elevation,
//       expandedHeight: expandedHeight,
//       flexibleSpace: FlexibleSpaceBar(
//         collapseMode: CollapseMode.pin,
//         background: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width,
//           ),
//           child: flexibleSpace,
//         ),
//       ),
//       isFadedTitle: isFadedTitle,
//       isFullscreenDialog: true,
//       onBackButtonPressed: onBackButtonPressed,
//       onTap: onTap,
//       searchBox: searchBox,
//       subtitle: subtitle);
//
//   @override
//   Widget build(BuildContext context) {
//     // Check whether should be close button.
//     final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
//     final bool useCloseButton =
//         parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
//     bool isDarkTheme = MediaQuery.of(context).platformBrightness ==
//         Brightness.dark;
//
//     return AppBar(
//       // backgroundColor: !isStickying ? ElevationOverlay.applyOverlay(context, Theme.of(context).colorScheme.surface, 4) : null,
//       leading: needsNavigationDrawer
//           ? null
//           : useCloseButton
//           ? CloseButton(
//           onPressed: this.onBackButtonPressed,
//           color: this.backButtonColor)
//           : BackButton(
//           onPressed: this.onBackButtonPressed, color: this.accentColor),
//       iconTheme: IconThemeData(
//         color: this.accentColor, //change your color here
//       ),
//       // snap: isFadedTitle ? false : true,
//       // floating: true,
//       // pinned: (this.isFullscreenDialog || this.hasTabBar || isFadedTitle) ? true : false,
//       title: isFadedTitle
//           ? Fade(
//               zeroOpacityOffset: expandedHeight! - kToolbarHeight,
//               fullOpacityOffset: expandedHeight!,
//               child: this.searchBox ??
//                   BasicListItem(
//                     title: this.title ?? '',
//                     subtitle: this.subtitle,
//                     titleTextStyle: TitleTextStyle.Headline6,
//                     hasPadding: false,
//                     trailingWidget: this.trailing,
//                     needsTitleOverFlowStateVisible: false,
//                     needsSubtitleOverFlowStateVisible: false,
//                     optionalWidgetTitle: onTap != null ? const Icon(Icons.arrow_drop_down_outlined) : null,
//                   ),
//               scrollController: scrollController!)
//           : this.searchBox ??
//               BasicListItem(
//                 title: this.title ?? '',
//                 subtitle: this.subtitle,
//                 titleTextStyle: TitleTextStyle.Headline6,
//                 hasPadding: false,
//                 titleColor: accentColor,
//                 trailingWidget: this.trailing,
//                 needsTitleOverFlowStateVisible: false,
//                 needsSubtitleOverFlowStateVisible: false,
//                 optionalWidgetTitle: onTap != null ? const Icon(Icons.arrow_drop_down_outlined) : null,
//               ),
//       actions: manualUrl != null && actions != null
//           ?
//       [ _getManualIcon(manualUrl: manualUrl, context: context),
//
//       ]  + actions!
//           :  manualUrl != null ?  [ _getManualIcon(manualUrl: manualUrl, context: context),
//
//       ] : actions,
//       elevation: elevation ?? (this.isStickying ? 0 : 4),
//       // expandedHeight: this.expandedHeight,
//       flexibleSpace: flexibleSpace,
//       bottom: bottom,
//       // bottom: bottom != null ? PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight), child: Material(
//       //     // elevation: overlapsContent ? 4.0 : 0,
//       //     color: Colors.transparent,
//       //     child: Stack(alignment: Alignment.bottomCenter,children: [Divider(
//       //       height: 0,
//       //       color: !isStickying ? null : isDarkTheme ? Colors.white54 : Colors.black12,
//       //     ), Container(width: double.infinity, child: bottom,) as Widget],))) : null,
//
//     );
//   }
//
//   static Widget _getManualIcon({String? manualUrl, required BuildContext context }) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: IconButton(
//         icon: Icon(
//           Icons.help,
//           color: SyntonicColor.primary_color,
//         ),
//         onPressed: () {
//           NavigationService.launchUrlInBrowser(url: manualUrl ?? '');
//         },
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize {
//     double _height = kToolbarHeight;
//     if (bottom != null) {
//       _height += bottom!.preferredSize.height;
//     }
//     return Size.fromHeight(_height);
//   }
// }
//
//
