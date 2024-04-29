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
  final bool shouldRemainOffset;
  final double offset;

  const SyntonicFade._(
      {
        Key? key,
        required this.scrollController,
      required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = kToolbarHeight,
      required this.fadeMode, this.shouldRemainOffset = false, this.offset = 0}) : super(key: key);

  const SyntonicFade.on(
      {
        required ScrollController scrollController,
      required Widget child,
      double zeroOpacityOffset = 0,
      double fullOpacityOffset = kToolbarHeight, bool shouldRemainOffset = false, double offset = 0})
      : this._(
            scrollController: scrollController,
            child: child,
            zeroOpacityOffset: zeroOpacityOffset,
            fullOpacityOffset: fullOpacityOffset,
            shouldRemainOffset: shouldRemainOffset,
            offset: offset,
            fadeMode: _FadeMode.on);

  const SyntonicFade.off(
      {
        Key? key, required ScrollController scrollController,
      required Widget child,
      double zeroOpacityOffset = 0,
      double fullOpacityOffset = kToolbarHeight, bool shouldRemainOffset = false, double offset = 0})
      : this._(
    key: key,
            scrollController: scrollController,
            child: child,
            zeroOpacityOffset: zeroOpacityOffset,
            fullOpacityOffset: fullOpacityOffset,
      shouldRemainOffset: shouldRemainOffset,
            offset: offset,
            fadeMode: _FadeMode.off);

  @override
  _FadeState createState() => _FadeState();
}

class _FadeState extends State<SyntonicFade> {
  double _offset = 0;

  @override
  initState() {
    super.initState();
    // // print('オフセット');
    // // print(widget.zeroOpacityOffset);
    // // print(widget.fullOpacityOffset);
    if (widget.shouldRemainOffset && widget.fullOpacityOffset > 1) {
      _offset = widget.offset;
    }
    widget.scrollController.addListener(_setOffset);
  }

  @override
  void didUpdateWidget(covariant SyntonicFade oldWidget) {
    // // print('フェード');
    // // print(widget.fullOpacityOffset);
    super.didUpdateWidget(oldWidget);
  }
  //
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
    // // print('高さ');
    // // print(widget.zeroOpacityOffset);
    // // print(widget.fullOpacityOffset);
    // return (_offset - 0) / (widget.fullOpacityOffset - 0).clamp(0.0, 1.0);
    // return _offset/widget.fullOpacityOffset;

    // if (widget.fullOpacityOffset == widget.zeroOpacityOffset) {
    //   return _offset/widget.fullOpacityOffset;
    // } else if(){
    //
    // }

    if (widget.fullOpacityOffset == widget.zeroOpacityOffset) {
      // // print('メイン0');
      return 0;
    } else if (widget.fullOpacityOffset > widget.zeroOpacityOffset) {
      switch (widget.fadeMode) {
        case _FadeMode.on:
          if (_offset < widget.zeroOpacityOffset) {
            return 0;
          }

          if (_offset <= widget.zeroOpacityOffset) {
            // // print("fade onnn if 0");
            return 0;
          } else if (_offset >= widget.fullOpacityOffset) {
            // // print("fade onnn else if 1");
            return 1;
          } else {
            // // print((_offset - widget.zeroOpacityOffset) /
            //     (widget.fullOpacityOffset - widget.zeroOpacityOffset));
            double _value =
                0.0 - (widget.zeroOpacityOffset - _offset) / widget.zeroOpacityOffset;
            // print(_value);
            return _value > 1 ? 1 : _value;
            // print(
            //     "fade onnn else ${(_offset - widget.zeroOpacityOffset) / (widget.fullOpacityOffset - widget.zeroOpacityOffset)}");
            return (_offset - widget.zeroOpacityOffset) /
                (widget.fullOpacityOffset - widget.zeroOpacityOffset);
          }
        case _FadeMode.off:
          if (_offset < widget.zeroOpacityOffset) {
            return 1;
          }

          if (_offset == widget.fullOpacityOffset) {
            // print("fade off if 0");

            return 0;
          } else if (_offset == widget.zeroOpacityOffset) {
            // print("fade off else if 1");

            return 1;
          } else {
            double _value =
            1.0 - (_offset - widget.zeroOpacityOffset) / widget.zeroOpacityOffset;
            // print("fade off else ${(_value < 0 || _value > 1) ? 0 : _value}");
            return _value < 0 ? 0 : _value;
          }
      }
    } else {
      switch (widget.fadeMode) {
        case _FadeMode.off:
          if (_offset <= widget.zeroOpacityOffset) {
            // print("BBB fade onnn if 0");
            return 0;
          } else if (_offset >= widget.fullOpacityOffset) {
            // print("BBB fade onnn else if 1");
            // return 1;
            // print(_offset);
            // print(widget.zeroOpacityOffset);
            // print(widget.fullOpacityOffset);
            return (_offset - widget.zeroOpacityOffset) /
                (widget.fullOpacityOffset - widget.zeroOpacityOffset);
          } else {
            // // print((_offset - widget.zeroOpacityOffset) /
            //     (widget.fullOpacityOffset - widget.zeroOpacityOffset));
            // print(
            //     "BBB fade onnn else ${(_offset - widget.zeroOpacityOffset) / (widget.fullOpacityOffset - widget.zeroOpacityOffset)}");
            return (_offset - widget.zeroOpacityOffset) /
                (widget.fullOpacityOffset - widget.zeroOpacityOffset);
          }
        case _FadeMode.on:
          if (_offset == widget.fullOpacityOffset) {
            // print("BBB fade off if 0");

            return 0;
          } else if (_offset == widget.zeroOpacityOffset) {
            // print("BBB fade off else if 1");

            return 1;
          } else {
            // if (_offset <= widget.zeroOpacityOffset) {
            //   return 1;
            // }

            // // print((widget.fullOpacityOffset - (widget.fullOpacityOffset - _offset)) /
            //     widget.fullOpacityOffset);
            double _value =
                (widget.fullOpacityOffset - _offset) / widget.fullOpacityOffset;
            // print("BBB fade off else ${_value < 0 ? 0 : _value}");
            return _value < 0 ? 0 : _value;
          }
      }

      // fading in
      if (_offset <= widget.zeroOpacityOffset) {
        // print('other 0');
        return 0;
      } else if (_offset >= widget.fullOpacityOffset) {
        // print('other 1');
        return 1;
      } else {
        // print(
        //     'other ${(_offset - widget.zeroOpacityOffset) / (widget.fullOpacityOffset - widget.zeroOpacityOffset)}');
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
    // return widget.child;
    return Opacity(
      opacity: _calculateOpacity(),
      child: RepaintBoundary(
        child: widget.child,
      ),
    );
  }
}
