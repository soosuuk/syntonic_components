import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../buttons/syntonic_button.dart';


abstract class SyntonicModalBottomSheet<VM extends SyntonicModalBottomSheetViewModel<VS>, VS extends SyntonicModalBottomSheetViewState> {
  const SyntonicModalBottomSheet({Key? key, required this.vm, this.initialSize}) : super();
  final VM vm;
  final double? initialSize;

  VM viewModel(WidgetRef ref) => ref.read(provider.notifier);
  StateNotifierProvider<VM, VS> get provider => StateNotifierProvider<VM, VS>((ref) => vm);

  List<Widget> children({required BuildContext context, required WidgetRef ref});
  Function? onPop({required BuildContext context, required WidgetRef ref});

  /// Open modal bottom sheet.
  openModalBottomSheet({required BuildContext context,}) {
    // this.pageController = pageController;
    // contents = children;
    // provider = ChangeNotifierProvider<SyntonicModalBottomSheetViewModel>((ref) => SyntonicModalBottomSheetViewModel());

    showModalBottomSheet(
        enableDrag: true,
        useSafeArea: true,
        isScrollControlled: true,
      showDragHandle: vm.state.currentPageIndex == 0,
        context: context,
        builder: (_) {
          return Consumer(
              builder: (context, ref, child) {
            return WillPopScope(
              onWillPop: () async {
                if (onPop != null) {
                  onPop(context: context, ref: ref);
                }
                return true;
              }, child: _contents(context: context, ref: ref),);
          });
        }
    );
  }

  Widget _contents({required BuildContext context, required WidgetRef ref,}) {
    vm.pageController = PageController(initialPage: vm.state.currentPageIndex.toInt());
    return DraggableScrollableActuator(
      child: DraggableScrollableSheet(
        key: GlobalKey(),
        initialChildSize: initialSize ?? vm.minExtent,
        maxChildSize: vm.maxExtent,
        minChildSize: 0,
        expand: false,
        snap: true,
        snapSizes: [vm.minExtent],
        // controller: viewModel(ref).controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return  Column(children: [SyntonicButton.transparent(onTap: () {onPop(context: context, ref: ref); Navigator.of(context).pop();}, text: 'Done',), Expanded(child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: vm.pageController,
              children: _pageViews(context: context, ref: ref, scrollController: scrollController)))],);
        },
      ),
    );
  }

  List<Widget> _pageViews({required BuildContext context, required WidgetRef ref, required ScrollController scrollController,}) {
  List<Widget> _pageViews = [];

  for (int i = 0; i < children(context: context, ref: ref).length; i++) {
    _pageViews.add(_pageView(context: context, ref: ref, scrollController: scrollController, index: i));
  }

  return _pageViews;
  }

  Widget _pageView({required BuildContext context, required WidgetRef ref, required ScrollController scrollController, required int index}) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        // SliverToBoxAdapter(
        //   child: Column(children: contents,),
        // ),
        SliverList.list(
          children: [children(context: context, ref: ref)[index]],
        ),
      ],
    );
  }

}

abstract class SyntonicModalBottomSheetViewModel<VS extends SyntonicModalBottomSheetViewState> extends StateNotifier<VS> {
  SyntonicModalBottomSheetViewModel({required VS viewState}) : super(viewState) {
    pageController.addListener(() {
      if (pageController.positions.isNotEmpty) {
        state = state.copyWith(currentPageIndex: pageController.page!) as VS;
        print(state.currentPageIndex);
        print('ページ　');
      }
    });
  }

  final double minExtent = 0.5;
  final double maxExtent = 1.0;
  final DraggableScrollableController controller = DraggableScrollableController();
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
  SyntonicModalBottomSheetViewState({this.currentPageIndex = 0});
  final double currentPageIndex;

  SyntonicModalBottomSheetViewState copyWith(
  {double? currentPageIndex,
  }) {
    return SyntonicModalBottomSheetViewState(currentPageIndex: currentPageIndex?? this.currentPageIndex);
  }
  }