import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syntonic_components/widgets/lists/syntonic_list_item.dart';
import 'package:syntonic_components/widgets/texts/headline_6_text.dart';
// import 'package:provider/provider.dart';

import '../buttons/syntonic_button.dart';

abstract class SyntonicModalBottomSheet<
    VM extends SyntonicModalBottomSheetViewModel<VS>,
    VS extends SyntonicModalBottomSheetViewState> {
  const SyntonicModalBottomSheet({Key? key, required this.vm, this.initialSize})
      : super();
  final VM vm;
  final double? initialSize;

  VM viewModel(WidgetRef ref) => ref.read(provider.notifier);
  StateNotifierProvider<VM, VS> get provider =>
      StateNotifierProvider<VM, VS>((ref) => vm);

  Widget child(
      {required BuildContext context, required WidgetRef ref});
  Function? onPop({required BuildContext context, required WidgetRef ref});

  /// Open modal bottom sheet.
  openModalBottomSheet<S>({
    required BuildContext context,
  }) {
    showModalBottomSheet(
        enableDrag: true,
        useSafeArea: true,
        isScrollControlled: true,
        clipBehavior: Clip.hardEdge,
        // showDragHandle: vm.state.currentPageIndex == 0,
        context: context,
        builder: (context) {
          return Consumer(builder: (context, ref, child) {
            return WillPopScope(
              onWillPop: () async {
                onPop(context: context, ref: ref);
                return true;
              },
              child: _contents<S>(context: context, ref: ref),
            );
          });
        });
  }

  Widget _contents<S>({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    vm.pageController =
        PageController(initialPage: vm.state.currentPageIndex.toInt());


    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: DraggableScrollableSheet(
        // key: GlobalKey(),
        initialChildSize: ref.watch(provider
            .select((viewState) => (viewState).currentExtent)),
        maxChildSize: vm.maxExtent,
        minChildSize: 0,
        expand: false,
        snap: true,
        snapSizes: [vm.minExtent],
        controller: viewModel(ref).controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return MaterialApp(
            theme: Theme.of(context),
            home: Scaffold(
              // appBar: AppBar(
              //   title: Text('Example'),
              // ),
              body: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Navigator(
                  onGenerateRoute: (context) => MaterialPageRoute<S>(
                builder: (context) => SingleChildScrollView(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            child: child(context: context, ref: ref),
          )),
          ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Center(child: Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),),
                    Padding(padding: EdgeInsets.only(top: 12),child: SyntonicButton.transparent(onTap: () {
                      Navigator.of(context).pop();
                      // actionAddingViewModel.pageController.jumpToPage(0);
                    }, text: 'done'),)
                  ],)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// class _Contents extends StatelessWidget {
//
//   _Contents({
//     required this.context,
//     required this.ref,
//   });
//
//   final BuildContext context;
//   final WidgetRef ref;
//
//   @override
//   Widget build(BuildContext context) {
//     vm.pageController =
//         PageController(initialPage: vm.state.currentPageIndex.toInt());
//
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus!.unfocus();
//       },
//       child: DraggableScrollableActuator(
//         child: DraggableScrollableSheet(
//           key: GlobalKey(),
//           initialChildSize: ref.watch(provider
//               .select((viewState) => (viewState).currentExtent)),
//           maxChildSize: vm.maxExtent,
//           minChildSize: 0,
//           expand: false,
//           snap: true,
//           snapSizes: [vm.minExtent],
//           // controller: viewModel(ref).controller,
//           builder: (BuildContext context, ScrollController scrollController) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 vm.state.currentPageIndex == 0
//                     ? Padding(
//                   padding: const EdgeInsets.only(
//                       left: 16, top: 8, right: 16),
//                   child: Stack(
//                     alignment: AlignmentDirectional.topEnd,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 40,
//                             height: 3,
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).colorScheme.outline,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           )
//                         ],
//                       ),
//                       SyntonicButton.transparent(
//                         onTap: () {
//                           onPop(context: context, ref: ref);
//                           Navigator.of(context).pop();
//                         },
//                         text: 'Done',
//                       )
//                     ],
//                   ),
//                 )
//                     : const SizedBox(),
//                 Expanded(
//                     child: PageView(
//                         physics: const NeverScrollableScrollPhysics(),
//                         controller: vm.pageController,
//                         children: _pageViews(
//                             context: context,
//                             ref: ref,
//                             scrollController: scrollController)))
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   List<Widget> _pageViews({
//     required BuildContext context,
//     required WidgetRef ref,
//     required ScrollController scrollController,
//   }) {
//     List<Widget> _pageViews = [];
//
//     for (int i = 0; i < children(context: context, ref: ref).length; i++) {
//       _pageViews.add(_pageView(
//           context: context,
//           ref: ref,
//           scrollController: scrollController,
//           index: i));
//     }
//
//     return _pageViews;
//   }
//
//   Widget _pageView(
//       {required BuildContext context,
//         required WidgetRef ref,
//         required ScrollController scrollController,
//         required int index}) {
//     return CustomScrollView(
//       controller: scrollController,
//       slivers: [
//         // SliverToBoxAdapter(
//         //   child: Column(children: contents,),
//         // ),
//         SliverList.list(
//           children: [children(context: context, ref: ref)[index]],
//         ),
//       ],
//     );
//   }
// }

abstract class SyntonicModalBottomSheetViewModel<
    VS extends SyntonicModalBottomSheetViewState> extends StateNotifier<VS> {
  SyntonicModalBottomSheetViewModel({required VS viewState})
      : super(viewState) {
    pageController.addListener(() {
      if (pageController.positions.isNotEmpty) {
        state = state.copyWith(currentPageIndex: pageController.page!) as VS;
      }
    });
  }

  final double minExtent = 0.5;
  final double maxExtent = 1.0;
  final DraggableScrollableController controller =
      DraggableScrollableController();
  PageController pageController = PageController();

  @override
  set state(VS value) {
    super.state = value;
  }

  @override
  VS get state => super.state;
}

// @freezed
class SyntonicModalBottomSheetViewState {
  SyntonicModalBottomSheetViewState({this.currentPageIndex = 0, required this.currentExtent});
  final double currentPageIndex;
  final double currentExtent;

  SyntonicModalBottomSheetViewState copyWith({
    double? currentPageIndex,
    double? currentExtent,
  }) {
    return SyntonicModalBottomSheetViewState(
        currentPageIndex: currentPageIndex ?? this.currentPageIndex, currentExtent: currentExtent ?? this.currentExtent);
  }
}
