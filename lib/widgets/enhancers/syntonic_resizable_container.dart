import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../configs/constants/syntonic_color.dart';

class SyntonicResizableContainer extends StatefulWidget {
  /// Child.
  final Widget? child;
  final Widget Function(double scale)? onInteractionUpdate;
  late double scale;
  late TransformationController _cellTransformationController = TransformationController();

  /// The maximum allowed scale.
  ///
  /// The scale will be clamped between this and [minScale] inclusively.
  ///
  /// Defaults to 2.5.
  ///
  /// Cannot be null, and must be greater than zero and greater than minScale.
  final double maxScale;

  /// The minimum allowed scale.
  ///
  /// The scale will be clamped between this and [maxScale] inclusively.
  ///
  /// Scale is also affected by [boundaryMargin]. If the scale would result in
  /// viewing beyond the boundary, then it will not be allowed. By default,
  /// boundaryMargin is EdgeInsets.zero, so scaling below 1.0 will not be
  /// allowed in most cases without first increasing the boundaryMargin.
  ///
  /// Defaults to 0.8.
  ///
  /// Cannot be null, and must be a finite number greater than zero and less
  /// than maxScale.
  final double minScale;

  late double currentSize;
  late double maxSize;
  late double minSize;
  final double defaultSize;

  SyntonicResizableContainer({required this.defaultSize, this.child, this.onInteractionUpdate, this.maxScale = 2.5, this.minScale = 0.8}) {
    currentSize = defaultSize;
    maxSize = defaultSize * maxScale;
    minSize = defaultSize * minScale;
    scale = 1.0;
  }

  @override
  _ResizableContainerState createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<SyntonicResizableContainer> {

  ///initial position
  // double leftPos = 33;
  // double rightPos = 33;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
            behavior: HitTestBehavior.deferToChild,
          onTap: () {},
          onScaleUpdate: (details) {
            double _scale = details.scale;
            // print(widget.currentSize);
            // print(widget.minSize);
            if (widget.currentSize * _scale > widget.defaultSize ? widget.currentSize * _scale <= widget.maxSize : widget.currentSize * _scale >= widget.minSize ) {
              // widget.scale = _scale;
              widget.currentSize *= _scale;
              setState(() {});
            }
            // debugPrint(widget._scale.toString());
          },
          // onHorizontalDragUpdate: (details) {
          //   final midPos = details.delta;
          //   transformX += midPos.dx;
          //   setState(() {});
          //   debugPrint(midPos.toString());
          // },
          child: Container(
              height: widget.currentSize,
              // width: 60,
              // color: Colors.red,
              child: widget.onInteractionUpdate != null ? widget.onInteractionUpdate!(widget.currentSize) : const SizedBox()
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}