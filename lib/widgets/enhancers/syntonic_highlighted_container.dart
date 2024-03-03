import 'dart:async';

import 'package:flutter/material.dart';


class SyntonicHighlightedContainer extends StatefulWidget {
  /// Child.
  final Widget? child;

  /// Color.
  final Color? color;

  final bool isEnabled;

  const SyntonicHighlightedContainer(
      {this.child, this.color, this.isEnabled = true});

  @override
  _HighlightedContainerState createState() => _HighlightedContainerState();
}

class _HighlightedContainerState extends State<SyntonicHighlightedContainer> {
  final _animationDuration = const Duration(seconds: 1);
  late Timer _timer;
  late Color _color;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_animationDuration,
        (timer) => widget.isEnabled ? _changeColor() : null);
    _color = Colors.transparent;
  }

  void _changeColor() {
    final newColor = _color == widget.color || _color == Colors.transparent
        ? Colors.white70
        : widget.color ?? Colors.transparent;
    setState(() {
      _color = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEnabled) {
      return AnimatedContainer(
        duration: _animationDuration,
        color: _color,
        child: widget.child,
      );
    } else {
      return Container(
        color: _color,
        child: widget.child,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
