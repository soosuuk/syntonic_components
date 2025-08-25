import 'package:flutter/material.dart';

class SyntonicDynamicAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget child;

  const SyntonicDynamicAppBar({super.key, required this.child});

  @override
  State<SyntonicDynamicAppBar> createState() => _SyntonicDynamicAppBarState();

  @override
  Size get preferredSize => _SyntonicDynamicAppBarState.calculatePreferredSize();
}

class _SyntonicDynamicAppBarState extends State<SyntonicDynamicAppBar> {
  static Size? _childOnlySize;
  final GlobalKey _childKey = GlobalKey();

  static Size calculatePreferredSize() {
    final topPadding =
        WidgetsBinding.instance.platformDispatcher.views.first.padding.top;
    if (_childOnlySize != null) {
      return Size(_childOnlySize!.width, _childOnlySize!.height + topPadding);
    }
    return Size.fromHeight(kToolbarHeight + topPadding); // fallback
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateSize());
  }

  void _updateSize() {
    final context = _childKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null && box.hasSize) {
        setState(() {
          _childOnlySize = box.size;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surfaceContainer,
      elevation: 0,
      child: SafeArea(
        bottom: false,
        child: KeyedSubtree(
          key: _childKey,
          child: widget.child,
        ),
      ),
    );
  }
}
