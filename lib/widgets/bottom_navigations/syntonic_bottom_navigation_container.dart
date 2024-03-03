// import 'package:badges/badges.dart';
// import 'package:syntonic_components/models/fcm_data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syntonic_components/widgets/syntonic_base_view.dart';
import 'package:syntonic_components/widgets/bottom_navigations/syntonic_bottom_navigation_item.dart';
import 'package:flutter/material.dart';

import '../app_bars/syntonic_sliver_app_bar.dart';
import '../base_view_state.dart';
// import 'package:syntonic_components/widgets/syntonic_sliver_app_bar.dart';

class SyntonicBottomNavigationContainer extends SyntonicBaseView {
  /// items of [BottomNavigationBar].
  final List<SyntonicBottomNavigationItem> bottomNavigationItems;
  final Function()? onTapBottomNavigationBar;

  SyntonicBottomNavigationContainer(
      {required this.bottomNavigationItems, this.onTapBottomNavigationBar})
      : super(vm: BottomNavigationContainerManager());

  // @override
  // List<SingleChildWidget>? get providers => [
  //   ChangeNotifierProvider(create: (_) => BottomNavigationContainerManager()),
  // ];

  @override
  SyntonicSliverAppBar? appBar(
          {required BuildContext context, required WidgetRef ref}) =>
      null;

  @override
  Widget mainContents({required BuildContext context, required WidgetRef ref}) {
    return Scaffold(
      body: bottomNavigationItems[
          (viewModel(ref) as BottomNavigationContainerManager).currentIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (onTapBottomNavigationBar != null) {
            onTapBottomNavigationBar!();
          }
          if ((viewModel(ref) as BottomNavigationContainerManager)
                  .currentIndex ==
              index) {
            // bottomNavigationItems[index]
            //     .navigatorKey
            //     .currentState!
            //     .popUntil((route) => route.isFirst);
            // bottomNavigationItems[index]
            //     .screen
            //     .provider
            //     .scrollController
            //     .animateTo(
            //   0.0,
            //   curve: Curves.easeOut,
            //   duration: const Duration(milliseconds: 300),
            // );
            //
            // for (SyntonicBaseView _childView
            // in bottomNavigationItems[index].screen.childViews!) {
            //   for (SyntonicBaseView _childView in _childView.childViews!) {
            //     _childView.provider.scrollController.animateTo(
            //       0.0,
            //       curve: Curves.easeOut,
            //       duration: const Duration(milliseconds: 300),
            //     );
            //   }
            // }
          } else {
            (viewModel(ref) as BottomNavigationContainerManager)
                .setCurrentIndex(index);
          }
        },
        selectedIndex:
            (viewModel(ref) as BottomNavigationContainerManager).currentIndex,
        destinations: [
          for (final item in bottomNavigationItems)
            NavigationDestination(
              icon: item.icon,
              label: item.label,
            )
        ],
      ),
    );
  }

  // @override
  // BottomNavigationContainerManager getViewModelBy(BuildContext context) => BottomNavigationContainerManager();

// Widget _getIconWithBadge(Icon icon, int badgeVal) {
//   return Stack(
//     children: <Widget>[
//       icon,
//       new Positioned(
//           right: -0,
//           top: 0,
//           child: Container(
//             alignment: Alignment.center,
//             padding: (badgeVal > 99)
//                 ? EdgeInsets.fromLTRB(3, 0, 3, 0)
//                 : EdgeInsets.fromLTRB(0, 0, 0, 0),
//             decoration: BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             constraints: BoxConstraints(
//               minWidth: (badgeVal == 0) ? 14 : 18,
//               minHeight: (badgeVal == 0) ? 14 : 18,
//             ),
//             child: Text(
//               (badgeVal > 99)
//                   ? '99+'
//                   : ((badgeVal == 0) ? '' : badgeVal.toString()),
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 10,
//               ),
//             ),
//           ))
//     ],
//   );
// }
}

class BottomNavigationContainerState extends BaseViewState {
  BottomNavigationContainerState(
      {required bool needsInitialize, required bool isSkeletonLoadingApplied})
      : super(
            needsInitialize: needsInitialize,
            isSkeletonLoadingApplied: isSkeletonLoadingApplied);
}

class BottomNavigationContainerManager extends BaseViewModel {
  int currentIndex = 0;
  BottomNavigationContainerManager()
      : super(
            viewState: BottomNavigationContainerState(
                needsInitialize: false, isSkeletonLoadingApplied: false));
  void setCurrentIndex(int index) {
    currentIndex = index;
    // notifyListeners();
  }
}
