import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


class SyntonicModalBottomSheet {

  late final List<Widget> contents;
  static const double minExtent = 0.5;
  static const double maxExtent = 1.0;
  late WidgetRef ref;
  final _controller = DraggableScrollableController();
  PageController? pageController;
  var provider;

  /// Open modal bottom sheet.
  openModalBottomSheet({required BuildContext context, required List<Widget> children, Function? onPop, PageController? pageController}) {
    this.pageController = pageController;
    contents = children;
    provider = ChangeNotifierProvider<SyntonicModalBottomSheetViewModel>((ref) => SyntonicModalBottomSheetViewModel());

    showModalBottomSheet(
        enableDrag: true,
        useSafeArea: true,
        isScrollControlled: true,
      showDragHandle: true,
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              if (onPop != null) {
                onPop!();
              }
              return true;
            }, child: _contents,);
        }
    );
  }

  Widget get _contents {
    return Consumer(
      builder: (context, ref, child) {
        this.ref = ref;
        return DraggableScrollableActuator(
          child: DraggableScrollableSheet(
            key: GlobalKey(),
            initialChildSize: 0.5,
            maxChildSize: 1,
            minChildSize: 0,
            expand: false,
            snap: true,
            snapSizes: const [0.5],
            controller: _controller,
            builder: (BuildContext context, ScrollController scrollController) {
              return  PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: pageController ?? PageController(),
              children: _pageViews(scrollController: scrollController));
            },
          ),
        );
      },);


    return Column(
      mainAxisSize: MainAxisSize.min,
      children: contents + [SizedBox(height: 24)],
    );
  }

  Widget _draggableScrollableSheetBuilder(
      BuildContext context, ScrollController scrollController) {
    // draggableSheetContext = context;
    // SyntonicModalBottomSheetViewModel _viewModel =
    // context.read<SyntonicModalBottomSheetViewModel>();
    var _provider = ChangeNotifierProvider<SyntonicModalBottomSheetViewModel>((ref) => SyntonicModalBottomSheetViewModel());

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (scrollNotification) {
        print("noti extent" + scrollNotification.extent.toString());

        if (ref.read(_provider).isExpanded) {
          ref.read(_provider).initialExtent = minExtent;
        }
        if (scrollNotification.extent == maxExtent) {
          ref.read(_provider).changeExpanded(true);
        } else {
          ref.read(_provider).changeExpanded(true);
        }

        // if (scrollNotification.extent > minExtent) {
        //   _menuBottomSheetViewModel.initialExtent = _menuBottomSheetViewModel.isExpanded ? minExtent : maxExtent;
        //   DraggableScrollableActuator.reset(context);
        //   // scrollController.animateTo(
        //   //   1.0,
        //   //   curve: Curves.easeOut,
        //   //   duration: const Duration(milliseconds: 300),
        //   // );
        // }
        return true;
      },
      child: Column(children: contents),
    );
  }

  List<Widget> _pageViews({required ScrollController scrollController,}) {
  List<Widget> _pageViews = [];

  for (int i = 0; i < contents.length; i++) {
    _pageViews.add(_pageView(scrollController: scrollController, index: i));
  }

  return _pageViews;
  }

  Widget _pageView({required ScrollController scrollController, required int index}) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        // SliverToBoxAdapter(
        //   child: Column(children: contents,),
        // ),
        SliverList.list(
          children: [contents[index]],
        ),
      ],
    );
  }

}

class SyntonicModalBottomSheetViewModel extends ChangeNotifier {
  int selectedIndexDiscount = 0;
  bool isActived = false;
  bool isExpanded = false;
  double _initialExtent = 0.25;

  double get initialExtent => _initialExtent;

  set initialExtent(double initialExtent) {
    _initialExtent = initialExtent;
    notifyListeners();
  }

  void changeExpanded(bool isExpanded) {
    this.isExpanded = isExpanded;
    notifyListeners();
  }
}