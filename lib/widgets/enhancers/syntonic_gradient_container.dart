import 'package:syntonic_components/configs/constants/syntonic_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum GradientStartPosition {
  left,
  top,
  right,
  bottom
}

class SyntonicGradientContainer extends StatelessWidget {
  final Widget? child;
  final GradientStartPosition? startAt;
  final double? height;
  final double? width;
  final List<Color>? color;
  final List<double>? stops;

  const SyntonicGradientContainer({this.child, this.color, this.height, this.stops, this.width, this.startAt = GradientStartPosition.top});

  @override
  Widget build(BuildContext context) {
    late AlignmentGeometry _begin;
    late AlignmentGeometry _end;
    
    switch (startAt) {
      case GradientStartPosition.left:
        _begin = FractionalOffset.centerLeft;
       _end = FractionalOffset.centerRight;
        break;
      case GradientStartPosition.top:
        _begin = FractionalOffset.topCenter;
        _end = FractionalOffset.bottomCenter;
        break;
      case GradientStartPosition.right:
        _begin = FractionalOffset.centerRight;
        _end = FractionalOffset.centerLeft;
        break;
      case GradientStartPosition.bottom:
        _begin = FractionalOffset.bottomCenter;
        _end = FractionalOffset.topCenter;
        break;
      default:
        _begin = FractionalOffset.centerLeft;
        _end = FractionalOffset.centerRight;
        break;
    }
    
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: _begin,
          end: _end,
          colors: color ?? [
            ElevationOverlay.applyOverlay(context, Theme.of(context).colorScheme.surface, 4),
            ElevationOverlay.applyOverlay(context, Theme.of(context).colorScheme.surface, 4).withOpacity(0),
          ],
          stops: stops ?? const [
            0.0,
            1.0,
          ],
        ),
      ),
    );
  }
}
