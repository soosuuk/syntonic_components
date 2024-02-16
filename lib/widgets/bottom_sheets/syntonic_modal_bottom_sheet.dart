import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


abstract class SyntonicModalBottomSheet<VM extends SyntonicModalBottomSheetViewModel<VS>, VS extends SyntonicModalBottomSheetViewState> {
  const SyntonicModalBottomSheet({Key? key, required this.vm,}) : super();
  final VM vm;
  static const double minExtent = 0.5;
  static const double maxExtent = 1.0;

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
      showDragHandle: true,
        context: context,
        builder: (_) {
          return Consumer(
              builder: (context, ref, child) {
            return WillPopScope(
              onWillPop: () async {
                if (onPop != null) {
                  print('閉じる');
                  onPop(context: context, ref: ref);
                }
                return true;
              }, child: _contents(context: context, ref: ref,),);
          });
        }
    );
  }

  Widget _contents({required BuildContext context, required WidgetRef ref,}) {
    return DraggableScrollableActuator(
      child: DraggableScrollableSheet(
        key: GlobalKey(),
        initialChildSize: 0.5,
        maxChildSize: 1,
        minChildSize: 0,
        expand: false,
        snap: true,
        snapSizes: const [0.5],
        // controller: viewModel(ref).controller,
        builder: (BuildContext context, ScrollController scrollController) {
          return  PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: vm.pageController,
              children: _pageViews(context: context, ref: ref, scrollController: scrollController));
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

class SyntonicModalBottomSheetViewModel<VS extends SyntonicModalBottomSheetViewState> extends StateNotifier<VS> {
  SyntonicModalBottomSheetViewModel({required VS viewState}) : super(viewState);

  static const double minExtent = 0.5;
  static const double maxExtent = 1.0;
  final DraggableScrollableController controller = DraggableScrollableController();
  PageController? pageController;
}

// @freezed
class SyntonicModalBottomSheetViewState {
  SyntonicModalBottomSheetViewState({Key? key});
  }