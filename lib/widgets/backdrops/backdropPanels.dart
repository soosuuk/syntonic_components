import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'backdrop_sub_header.dart';

// class BackdropPanels extends StatefulWidget {
//   final AnimationController controller;
//   final bool isPanelVisible;
//   final VoidCallback onBackdropStateChanged;
//   final Widget backdropWidget;
//   final Widget frontLayerContents;
//   final Widget backLayerContents;
//
//   BackdropPanels({required this.controller, required this.isPanelVisible, required this.onBackdropStateChanged, required this.backdropWidget, required this.frontLayerContents, required this.backLayerContents});
//
//   @override
//   _BackdropPanelsState createState() => new _BackdropPanelsState();
// }
//
// class _BackdropPanelsState extends State<BackdropPanels> {
//   static const header_height = 60.0;
//
//   Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
//     final height = constraints.biggest.height;
//     final backPanelHeight = height - header_height;
//     final frontPanelHeight = -header_height;
//
//     return new RelativeRectTween(
//         begin: new RelativeRect.fromLTRB(
//             0.0, backPanelHeight, 0.0, frontPanelHeight),
//         end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
//         .animate(new CurvedAnimation(
//         parent: widget.controller, curve: Curves.linear));
//   }
//
//   Widget bothPanels(BuildContext context, BoxConstraints constraints) {
//
//     return new Container(
//       child: new Stack(
//         children: <Widget>[
//           widget.backLayerContents,
//           new PositionedTransition(
//             rect: getPanelAnimation(constraints),
//             child: new Material(
//               color: Colors.white,
//               elevation: 12.0,
//               borderRadius: new BorderRadius.only(
//                   topLeft: new Radius.circular(16.0),
//                   topRight: new Radius.circular(16.0)),
//               child: new Column(
//                 children: <Widget>[
//                   new Container(
//                     // height: header_height,
//                       child: Container(
//                         child: new SyntonicBackdropSubHeader(
//                             title: 'search',
//                             controller: widget.controller,
//                             isPanelVisible: widget.isPanelVisible,
//                             onBackdropStateChanged : widget.onBackdropStateChanged,
//                             widget: widget.backdropWidget
//                         ),
//                       )
//                   ),
//                   new Expanded(
//                     child: new Center(
//                       child: widget.frontLayerContents,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new LayoutBuilder(
//       builder: bothPanels,
//     );
//   }
// }

class BackdropPanels extends StatelessWidget {
  final AnimationController controller;
  final bool isPanelVisible;
  final VoidCallback onBackdropStateChanged;
  final Widget backdropWidget;
  final Widget frontLayerContents;
  final Widget backLayerContents;

  const BackdropPanels(
      {required this.controller,
      required this.isPanelVisible,
      required this.onBackdropStateChanged,
      required this.backdropWidget,
      required this.frontLayerContents,
      required this.backLayerContents});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    // return frontLayerContents;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => BackdropPanelsState(controller: controller)),
        ],
        child: Consumer<BackdropPanelsState>(builder: (context, state, child) {
          return Container(
            child: Stack(
              children: <Widget>[
                backLayerContents,
                PositionedTransition(
                  rect: state.getPanelAnimation(constraints),
                  child: Material(
                    // color: Colors.white,
                    elevation: 12.0,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    child: Column(
                      children: <Widget>[
                        Container(
                            // height: header_height,
                            child: Container(
                          child: SyntonicBackdropSubHeader(
                              title: 'search',
                              controller: controller,
                              isPanelVisible: isPanelVisible,
                              onBackdropStateChanged: onBackdropStateChanged,
                              widget: backdropWidget),
                        )),
                        Expanded(
                          child: Center(
                            child: frontLayerContents,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }));
  }
}

class BackdropPanelsState extends ChangeNotifier {
  static const header_height = 60.0;
  final AnimationController controller;

  BackdropPanelsState({required this.controller});

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - header_height;
    const frontPanelHeight = -header_height;

    return RelativeRectTween(
            begin: RelativeRect.fromLTRB(
                0.0, backPanelHeight, 0.0, frontPanelHeight),
            end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
  }
}
