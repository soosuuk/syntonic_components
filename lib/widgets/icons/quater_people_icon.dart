import 'package:flutter/material.dart';

class QuarterCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // Set the opacity to 50%
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = -3.14 / 2;
    const sweepAngle = 3.14 / 2;

    for (int i = 0; i < 4; i++) {
      canvas.drawArc(
          rect, startAngle + (sweepAngle * i), sweepAngle, true, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class QuarterCircleIcon extends StatelessWidget {
  final List<String> imageUrls;

  const QuarterCircleIcon({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: const Size(32, 32),
          painter: QuarterCirclePainter(),
        ),
        ...imageUrls.asMap().entries.map((entry) {
          final index = entry.key;
          final url = entry.value;
          return Positioned.fill(
            child: ClipPath(
              clipper: _QuarterClipper(index),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class _QuarterClipper extends CustomClipper<Path> {
  final int index;

  _QuarterClipper(this.index);

  @override
  Path getClip(Size size) {
    final path = Path();
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = -3.14 / 2;
    const sweepAngle = 3.14 / 2;

    path.moveTo(size.width / 2, size.height / 2);
    path.arcTo(rect, startAngle + (sweepAngle * index), sweepAngle, false);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
