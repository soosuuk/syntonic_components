import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'backdropPanels.dart';

// class BackdropPage extends StatefulWidget {
//   final Widget backdropWidget;
//   final Widget frontLayerContents;
//   final Widget backLayerContents;
//
//   BackdropPage({required this.backdropWidget, required this.frontLayerContents, required this.backLayerContents});
//
//   @override
//   _BackdropPageState createState() => new _BackdropPageState();
//   }
//
// class _BackdropPageState extends State<BackdropPage> with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller = new AnimationController(
//         vsync: this, duration: new Duration(milliseconds: 100), value: 1.0);
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controller.dispose();
//   }
//
//   bool get isPanelVisible {
//     final AnimationStatus status = controller.status;
//     return status == AnimationStatus.completed ||
//         status == AnimationStatus.forward;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       // drawer: NavigationDrawer(),
//       body: new BackdropPanels(
//         controller: controller,
//           isPanelVisible: isPanelVisible,
//         onBackdropStateChanged: () => set(),
//           backdropWidget: widget.backdropWidget,
//         frontLayerContents: widget.frontLayerContents,
//         backLayerContents: widget.backLayerContents
//       ),
//     );
//   }
//
//   set() {
//     controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
//     final AnimationStatus status = controller.status;
//     return status == AnimationStatus.completed ||
//         status == AnimationStatus.forward;
//   }
// }


class BackdropPage extends HookWidget {
  final Widget backdropWidget;
  final Widget frontLayerContents;
  final Widget backLayerContents;
  late AnimationController controller;

  BackdropPage({required this.backdropWidget, required this.frontLayerContents, required this.backLayerContents});

  @override
  Widget build(BuildContext context) {
    this.controller = useAnimationController(
        duration: Duration(milliseconds: 100), initialValue: 1.0);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BackdropState()),
        ],
        child: Consumer<BackdropState>(builder: (context, state, child) {
          state.controller = this.controller;

          return new Scaffold(
            // drawer: NavigationDrawer(),
            body: new BackdropPanels(
                controller: state.controller,
                isPanelVisible: state.isPanelVisible,
                onBackdropStateChanged: () => state.notify(),
                backdropWidget: this.backdropWidget,
                frontLayerContents: this.frontLayerContents,
                backLayerContents: this.backLayerContents),
          );
        }));
  }
}

class BackdropState extends ChangeNotifier {
  late AnimationController controller;

  bool get isPanelVisible {
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  notify() {
    controller.fling(velocity: isPanelVisible ? -1.0 : 1.0);
    final AnimationStatus status = controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }
}
