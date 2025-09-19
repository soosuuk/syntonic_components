import 'package:flutter/cupertino.dart';

class FadeInOutContainer extends StatefulWidget {
  final Widget child;
  final bool visible;
  final Duration duration;

  const FadeInOutContainer({
    Key? key,
    required this.child,
    required this.visible,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<FadeInOutContainer> createState() => _FadeInOutState();
}

class _FadeInOutState extends State<FadeInOutContainer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (widget.visible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant FadeInOutContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: IgnorePointer(
        ignoring: !widget.visible,
        child: widget.child,
      ),
    );
  }
}
