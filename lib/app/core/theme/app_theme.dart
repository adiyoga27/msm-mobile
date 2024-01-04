import 'package:flutter/material.dart';

Color primaryColor = const Color(0xAA00004D);
double value20 = 20.0;

class CurvedContainerPath extends CustomPainter {
  final bool isFirst;
  CurvedContainerPath({
    required this.isFirst,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = isFirst ? const Color(0xFFEBB850) : const Color(0xFF2248A9)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.4167167, 0);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width * 0.9995000, size.height * 0.3935055,
        size.width, size.height * 0.6614251);
    path0.cubicTo(
        size.width * 0.8579167,
        size.height * 0.2007339,
        size.width * 0.6047750,
        size.height * 0.5215759,
        size.width * 0.4330167,
        size.height * 0.1192999);
    path0.quadraticBezierTo(size.width * 0.3838583, size.height * -0.0282123,
        size.width * 0.4167167, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
