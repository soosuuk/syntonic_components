import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../syntonic_base_view.dart';

class SyntonicAnimationEnhancer extends StatefulWidget {
  final Widget child;
  final bool isEnabled;
  final int duration;

  // var provider = ChangeNotifierProvider<SyntonicAnimationEnhancerProvider>((ref) => SyntonicAnimationEnhancerProvider());

  SyntonicAnimationEnhancer(
      {required this.child, this.isEnabled = false, this.duration = 300});

  // @override
  // Widget build(BuildContext context, WidgetRef ref) {
  //   return AnimatedContainer(
  //       duration: Duration(milliseconds: ref.read(provider).duration),
  //     child: FractionallySizedBox(
  //       widthFactor: 0.8, // 80% of the parent's width
  //       heightFactor: 0.3, // 30% of the parent's height
  //       child: Container(
  //         color: Colors.red,
  //       ),
  //     ),
  //     // child: child,
  //   );
  // }

  @override
  State<StatefulWidget> createState() => _SyntonicAnimationEnhancerState();
}

class _SyntonicAnimationEnhancerState extends State<SyntonicAnimationEnhancer> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration), // アニメーションの期間を設定
    );

    _animation = Tween<double>(
      begin: 0.0, // 初期サイズ
      end: 1.0, // 最終的なサイズ（1.0は子のサイズを意味します）
    ).animate(_controller);

    // カスタムのアニメーションカーブを設定
    final CurvedAnimation curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubicEmphasized, // ここでカスタムカーブを指定
    );

    // 初期表示でアニメーションを開始
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isEnabled) {
      return widget.child;
    }

    return FadeTransition(opacity: _animation, child: RepaintBoundary(child: ScaleTransition(
      scale: _animation,
      child: widget.child,
    ),),);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SyntonicAnimationEnhancerProvider with ChangeNotifier {

  SyntonicAnimationEnhancerProvider({this.duration = 300, this.widthFactor = 1, this.heightFactor = 1}) {
    onInit();
  }

  final int duration;
  final double widthFactor;
  final double heightFactor;
  late AnimationController _controller;
  late Animation<double> _animation;


  // @override
  // void dispose() {
  //   onDispose();
  //   super.dispose();
  // }

  Future<dynamic>? onInit() {
    return null;
  }
}