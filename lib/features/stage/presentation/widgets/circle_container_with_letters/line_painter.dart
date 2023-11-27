import 'package:flutter/material.dart';

import '../../../../../config/theme/colors.dart';

class LinePainter extends CustomPainter {
  Offset? startPosition;
  Offset? endPosition;

  LinePainter({required this.startPosition, required this.endPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MainColors().pinkHighlightColor
      ..strokeWidth = 10.0;

    if (startPosition != null && endPosition != null) {
      canvas.drawLine(
        startPosition!,
        endPosition!,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.startPosition != startPosition ||
        oldDelegate.endPosition != endPosition;
  }
}
