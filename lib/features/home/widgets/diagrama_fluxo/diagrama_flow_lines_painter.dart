import 'package:flutter/material.dart';

class DiagramaFlowLinesPainter extends CustomPainter {
  final int itemCount;
  final Size cardSize;
  final double gap;
  final double topPadding;
  final double leftPadding;

  DiagramaFlowLinesPainter({
    required this.itemCount,
    required this.cardSize,
    required this.gap,
    required this.topPadding,
    required this.leftPadding,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4C7EDB)
      ..strokeWidth = 2.6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < itemCount - 1; i++) {
      final start = Offset(
        leftPadding + (i + 1) * cardSize.width + (i * gap),
        topPadding + cardSize.height / 2,
      );
      final end = Offset(
        leftPadding + (i + 1) * cardSize.width + (i * gap) + gap,
        topPadding + cardSize.height / 2,
      );

      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(
          start.dx + gap * 0.35,
          start.dy - 22,
          end.dx - gap * 0.35,
          end.dy + 22,
          end.dx,
          end.dy,
        );

      canvas.drawPath(path, paint);

      final arrowPaint = Paint()
        ..color = const Color(0xFF4C7EDB)
        ..style = PaintingStyle.fill;
      final arrowPath = Path()
        ..moveTo(end.dx, end.dy)
        ..lineTo(end.dx - 10, end.dy - 6)
        ..lineTo(end.dx - 10, end.dy + 6)
        ..close();

      canvas.drawPath(arrowPath, arrowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
