import 'package:flutter/material.dart';

enum _FadeMode {
  on,
  off,
}
class SyntonicFade extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;
  final _FadeMode fadeMode;

  const SyntonicFade._(
      {required this.scrollController,
      required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = kToolbarHeight, required this.fadeMode});

  const SyntonicFade.on(
      {required ScrollController scrollController,
        required Widget child,
        double zeroOpacityOffset = 0,
        double fullOpacityOffset = kToolbarHeight}) : this._(scrollController: scrollController, child: child, zeroOpacityOffset: zeroOpacityOffset, fullOpacityOffset: fullOpacityOffset, fadeMode: _FadeMode.on);

  const SyntonicFade.off(
      {required ScrollController scrollController,
        required Widget child,
        double zeroOpacityOffset = 0,
        double fullOpacityOffset = kToolbarHeight}) : this._(scrollController: scrollController, child: child, zeroOpacityOffset: zeroOpacityOffset, fullOpacityOffset: fullOpacityOffset, fadeMode: _FadeMode.off);

  @override
  _FadeState createState() => _FadeState();
}

class _FadeState extends State<SyntonicFade> {
  double _offset = 0;

  @override
  initState() {
    super.initState();
    _offset = widget.scrollController.offset;
    widget.scrollController.addListener(_setOffset);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      _offset = widget.scrollController.offset;
    });
  }

  double _calculateOpacity() {
    // print('高さ');
    // print(widget.zeroOpacityOffset);
    // print(widget.fullOpacityOffset);
    // return (_offset - 0) / (widget.fullOpacityOffset - 0).clamp(0.0, 1.0);
    // return _offset/widget.fullOpacityOffset;

    // if (widget.fullOpacityOffset == widget.zeroOpacityOffset) {
    //   return _offset/widget.fullOpacityOffset;
    // } else if(){
    //
    // }


    if (widget.fullOpacityOffset == widget.zeroOpacityOffset) {
      return 1;
    } else if (widget.fullOpacityOffset > widget.zeroOpacityOffset) {

      switch (widget.fadeMode) {
        case _FadeMode.on:
          if (_offset <= widget.zeroOpacityOffset) {
            print("fade onnn if");
            return 0;
          } else if (_offset >= widget.fullOpacityOffset) {
            print("fade onnn else if");
            return 1;
          } else {
            // print((_offset - widget.zeroOpacityOffset) /
            //     (widget.fullOpacityOffset - widget.zeroOpacityOffset));
            print("fade onnn else");
            return (_offset - widget.zeroOpacityOffset) /
                (widget.fullOpacityOffset - widget.zeroOpacityOffset);
          }
        case _FadeMode.off:
          if (_offset == widget.fullOpacityOffset) {
            print("fade off if");

            return 0;
          } else if (_offset == widget.zeroOpacityOffset) {
            print("fade off else if");

            return 1;
          } else {
            // if (_offset <= widget.zeroOpacityOffset) {
            //   return 1;
            // }
            print("fade off else");

            print((widget.fullOpacityOffset - (widget.fullOpacityOffset - _offset)) /
                widget.fullOpacityOffset);
            double _value = (widget.fullOpacityOffset - _offset) /
                widget.fullOpacityOffset;
            return _value < 0 ? 0 : _value;
          }
      }
    } else {
      // fading in
      if (_offset <= widget.zeroOpacityOffset) {
        return 0;
      } else if (_offset >= widget.fullOpacityOffset) {
        return 1;
      } else {
        return (_offset - widget.zeroOpacityOffset) /
            (widget.fullOpacityOffset - widget.zeroOpacityOffset);
      }
      // fading out
      if (_offset <= widget.fullOpacityOffset) {
        return 1;
      } else if (_offset >= widget.zeroOpacityOffset) {
        return 0;
      } else {
        return (_offset - widget.fullOpacityOffset) /
            (widget.zeroOpacityOffset - widget.fullOpacityOffset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _calculateOpacity(),
      child: RepaintBoundary(child: widget.child,),
    );
  }
}
