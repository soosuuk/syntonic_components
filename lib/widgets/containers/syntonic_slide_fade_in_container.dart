import 'package:flutter/cupertino.dart';

class SlideFadeInContainer extends StatelessWidget {
  final Widget child;

  const SlideFadeInContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(
          begin: const Offset(0, 0.2), end: Offset.zero), // 少し下から上に移動
      duration: const Duration(milliseconds: 600), // アニメーションの長さ
      curve: Curves.easeOut, // イージング
      builder: (context, offset, child) {
        return LayoutBuilder(builder: (context, constraints) {
          return Transform.translate(
            offset: offset * constraints.maxHeight, // オフセットを画面のサイズに合わせてスケール調整
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1), // フェードインアニメーション
              duration: const Duration(milliseconds: 800),
              builder: (context, opacity, _) {
                return Opacity(
                  opacity: opacity,
                  child: child,
                );
              },
              child: child,
            ),
          );
        });
      },
      child: child,
    );
  }
}
