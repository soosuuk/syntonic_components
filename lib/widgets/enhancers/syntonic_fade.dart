import 'package:flutter/material.dart';

class SyntonicFade extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;

  SyntonicFade(
      {required this.scrollController,
      required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = kToolbarHeight});

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
    if (widget.fullOpacityOffset == widget.zeroOpacityOffset) {
      return 1;
    } else if (widget.fullOpacityOffset > widget.zeroOpacityOffset) {
      // fading in
      if (_offset <= widget.zeroOpacityOffset) {
        return 0;
      } else if (_offset >= widget.fullOpacityOffset) {
        return 1;
      } else {
        return (_offset - widget.zeroOpacityOffset) /
            (widget.fullOpacityOffset - widget.zeroOpacityOffset);
      }
    } else {
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
      child: widget.child,
    );
  }
}
