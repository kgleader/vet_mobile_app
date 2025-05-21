import 'package:flutter/material.dart';
import 'dart:math' as math; // Needed for pi

class DecorativeRingPainter extends CustomPainter {
  final Color baseColor;

  DecorativeRingPainter({required this.baseColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double maxRadius = size.width / 2;
    // Adjusted stroke width for a potentially thinner appearance of each band
    final double ringStrokeWidth = maxRadius * 0.12; 

    // Define paint for different rings with adjusted opacities
    final Paint ringPaint1 = Paint()
      ..color = baseColor.withOpacity(0.2) // Lightest green (outermost)
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringStrokeWidth;

    final Paint ringPaint2 = Paint()
      ..color = baseColor.withOpacity(0.5) // Medium green
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringStrokeWidth;

    final Paint ringPaint3 = Paint()
      ..color = baseColor // Darkest green (innermost, full baseColor opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringStrokeWidth;
    
    final Paint dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Calculate radii for rings
    // The distance between the centers of the strokes is (ringStrokeWidth * spacingMultiplier)
    // If spacingMultiplier is 2.0, the visual gap between ring edges will be equal to ringStrokeWidth
    const double spacingMultiplier = 2.0;

    double radius1 = maxRadius - (ringStrokeWidth / 2); // Outermost ring center
    // Radius for the center of the middle ring
    double radius2 = maxRadius - (ringStrokeWidth / 2) - (ringStrokeWidth * spacingMultiplier); 
    // Radius for the center of the innermost ring
    double radius3 = maxRadius - (ringStrokeWidth / 2) - (ringStrokeWidth * spacingMultiplier * 2);

    // Draw rings
    canvas.drawCircle(center, radius1, ringPaint1);
    canvas.drawCircle(center, radius2, ringPaint2);
    canvas.drawCircle(center, radius3, ringPaint3);

    final double dotRadius = maxRadius * 0.025; 

    void drawDotsOnRing(double ringRadius) {
      for (int i = 0; i < 4; i++) {
        final double angle = math.pi / 2 * i; 
        final Offset dotPos = Offset(
          center.dx + ringRadius * math.cos(angle),
          center.dy + ringRadius * math.sin(angle)
        );
        canvas.drawCircle(dotPos, dotRadius, dotPaint);
      }
    }

    drawDotsOnRing(radius1);
    drawDotsOnRing(radius2);
    drawDotsOnRing(radius3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
