import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

/// Birbirine bağlı üç daireden oluşan uygulama logosu.
class RutinLogo extends StatelessWidget {
  const RutinLogo({super.key, this.size = 128});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Rutin Ağı logosu',
      image: true,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(size * 0.31),
          boxShadow: const [
            BoxShadow(
              color: Color(0x2E3D2A0A),
              blurRadius: 40,
              offset: Offset(0, 16),
            ),
          ],
        ),
        child: CustomPaint(
          size: Size.square(size * 0.625),
          painter: _LogoPainter(),
        ),
      ),
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Çizim 48x48'lik bir alana göre yapılıp ölçekleniyor.
    final scale = size.width / 48;
    Offset point(double x, double y) => Offset(x * scale, y * scale);
    final radius = 5.5 * scale;

    final line = Paint()
      ..color = AppColors.ink
      ..strokeWidth = 3.5 * scale
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(point(13, 34), point(24, 13), line);
    canvas.drawLine(point(24, 13), point(35, 33), line);
    canvas.drawLine(point(13, 34), point(35, 33), line);

    canvas.drawCircle(point(24, 12), radius, Paint()..color = AppColors.primary);
    canvas.drawCircle(point(24, 12), radius, line);

    canvas.drawCircle(point(12, 35), radius + 1.75 * scale, Paint()..color = AppColors.logoYellow);

    canvas.drawCircle(point(36, 33), radius, Paint()..color = AppColors.ink);
    canvas.drawCircle(point(36, 33), radius, line);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
