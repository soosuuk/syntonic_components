import 'package:flutter/cupertino.dart';

class SyntonicParallaxView extends StatefulWidget {
  final double height;
  final double maxParallaxShift;
  final double scrollOffset;
  final double parallaxScrollRange;
  final double parallaxSpeedFactor;
  final WidgetBuilder backgroundBuilder;
  final WidgetBuilder foregroundBuilder;

  const SyntonicParallaxView({
    super.key,
    required this.height,
    this.maxParallaxShift = 250,
    required this.scrollOffset,
    this.parallaxScrollRange = 500,
    this.parallaxSpeedFactor = 0.23,
    required this.backgroundBuilder,
    required this.foregroundBuilder,
  });

  @override
  State<SyntonicParallaxView> createState() => _SyntonicParallaxViewState();
}

class _SyntonicParallaxViewState extends State<SyntonicParallaxView> {
  double get _parallaxOffset {
    final progress = (widget.scrollOffset / widget.parallaxScrollRange).clamp(0.0, 1.0);
    return (progress * widget.maxParallaxShift * widget.parallaxSpeedFactor) - widget.maxParallaxShift;
  }

  double _parallaxOffsett() {
    // 0〜1の範囲に正規化
    final progress = (widget.scrollOffset / widget.parallaxScrollRange).clamp(0.0, 1.0);
    // 移動量を定義（例：最大で40px下に動く）
    return progress * widget.maxParallaxShift * widget.parallaxSpeedFactor;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // SizedBox(
        //   height: widget.height,
        //   width: double.infinity,
        //   child: ClipRect(
        //     child: OverflowBox(
        //       minHeight: widget.height + widget.maxParallaxShift,
        //       maxHeight: widget.height + widget.maxParallaxShift,
        //       alignment: Alignment.topCenter,
        //       child: Transform.translate(
        //         offset: Offset(0, _parallaxOffset),
        //         child: widget.backgroundBuilder(context),
        //       ),
        //     ),
        //   ),
        // ),
        ClipRect(
          child: SizedBox(
            height: widget.height,
            width: double.infinity,
            child: Transform.translate(
              offset: Offset(0, _parallaxOffsett()),
              child: SizedBox(
                height: widget.height + widget.maxParallaxShift,
                width: double.infinity,
                child: widget.backgroundBuilder(context),
              ),
            ),
          ),
        ),
        SizedBox(
          height: widget.height,
          width: double.infinity,
          child: widget.foregroundBuilder(context),
        ),
      ],
    );
  }
}
