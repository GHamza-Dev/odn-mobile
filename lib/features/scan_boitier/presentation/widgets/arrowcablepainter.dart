
import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

import '../../../../core/themes/app_colors.dart';

class ArrowCablePainter extends CustomPainter {
  final Color color;
  final double lineWidth;
  final double arrowSize;

  ArrowCablePainter({
    this.color = AppColors.primary,
    this.lineWidth = 4.0,
    this.arrowSize = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = color
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final paintFill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    final cx = arrowSize;
    final halfHeight = (h - 2 * arrowSize) / 2;
    final bendY = arrowSize + halfHeight;
    final endX = w - arrowSize;

    // Draw top arrow
    final ui.Path topArrow = ui.Path()
      ..moveTo(cx, 0)
      ..lineTo(cx - arrowSize, arrowSize)
      ..lineTo(cx + arrowSize, arrowSize)
      ..close();
    canvas.drawPath(topArrow, paintFill);

    // Draw cable path with rounded corners
    final ui.Path cablePath = ui.Path()
      ..moveTo(cx, arrowSize)
      ..lineTo(cx, bendY)
      ..lineTo(endX, bendY)
      ..lineTo(endX, h - arrowSize);
    canvas.drawPath(cablePath, paintLine);

    // Draw bottom arrow
    final ui.Path bottomArrow = ui.Path()
      ..moveTo(endX, h)
      ..lineTo(endX - arrowSize, h - arrowSize)
      ..lineTo(endX + arrowSize, h - arrowSize)
      ..close();
    canvas.drawPath(bottomArrow, paintFill);
  }

  @override
  bool shouldRepaint(covariant ArrowCablePainter oldDelegate) {
    return oldDelegate.color    != color ||
        oldDelegate.lineWidth != lineWidth ||
        oldDelegate.arrowSize != arrowSize;
  }
}