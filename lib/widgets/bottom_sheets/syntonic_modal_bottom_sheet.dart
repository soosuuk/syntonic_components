import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


class SyntonicModalBottomSheet {

  late final List<Widget> contents;
  static const double minExtent = 0.5;
  static const double maxExtent = 1.0;

  /// Open modal bottom sheet.
  openModalBottomSheet({required BuildContext context, required List<Widget> menus, List<SingleChildWidget>? providers, Function? onPop}) {
    contents = menus;

    showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
      showDragHandle: true,
        context: context,
        builder: (_) {
          return providers != null ?
          MultiProvider(
              providers: [ChangeNotifierProvider(create: (_) => SyntonicModalBottomSheetViewModel()), ...providers],
          child:WillPopScope(
          onWillPop: () async {
            if (onPop != null) {
              onPop!();
            }
            return true;
          }, child: _contents,),) :
          _contents;
        }
    );
  }

  Widget get _contents {
    return Consumer<SyntonicModalBottomSheetViewModel>(
      builder: (context, model, child) => DraggableScrollableActuator(
        child: DraggableScrollableSheet(
          // key: Key(model.initialExtent.toString()),
          maxChildSize: maxExtent,
          initialChildSize: minExtent,
          minChildSize: minExtent,
          // snap: true,
          expand: false,
          builder: _draggableScrollableSheetBuilder,
        ),
      ),);


    return Column(
      mainAxisSize: MainAxisSize.min,
      children: contents + [SizedBox(height: 24)],
    );
  }

  Widget _draggableScrollableSheetBuilder(
      BuildContext context, ScrollController scrollController) {
    // draggableSheetContext = context;
    SyntonicModalBottomSheetViewModel _viewModel =
    context.read<SyntonicModalBottomSheetViewModel>();

    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (scrollNotification) {
        print(scrollNotification.extent);

        if (_viewModel.isExpanded) {
          _viewModel.initialExtent = minExtent;
        }
        if (scrollNotification.extent == maxExtent) {
          _viewModel.changeExpanded(true);
        } else {
          _viewModel.changeExpanded(false);
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
      child: Column(children: contents,),
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