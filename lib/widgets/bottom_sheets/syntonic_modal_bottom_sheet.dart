import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class SyntonicModalBottomSheet {

  /// Open modal bottom sheet.
  openModalBottomSheet({required BuildContext context, required List<Widget> menus, List<SingleChildWidget>? providers, Function? onPop}) {
    showModalBottomSheet(
      showDragHandle: true,
        context: context,
        builder: (_) {
          return providers != null ?
          MultiProvider(
              providers: providers,
          child:WillPopScope(
          onWillPop: () async {
            if (onPop != null) {
              onPop!();
            }
            return true;
          }, child: Column(
          mainAxisSize: MainAxisSize.min,
          children: menus + [SizedBox(height: 24)],
          ),),) :
          Column(
            mainAxisSize: MainAxisSize.min,
            children: menus + [SizedBox(height: 24)],
          );
        }
    );
  }

}