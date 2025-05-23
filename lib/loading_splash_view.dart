import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:random_group_generator/all_material.dart';

class LoadingSplashView extends StatelessWidget {
  final String title;
  final String animationAsset;
  final Color? backgroundColor;
  final Duration duration;
  final VoidCallback onCompleted;

  const LoadingSplashView({
    super.key,
    required this.title,
    required this.animationAsset,
    required this.onCompleted,
    this.backgroundColor,
    this.duration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future.delayed(duration, onCompleted);

    final decorations = [
      // Circles
      _DecorationShape(
        shape: ShapeType.circle,
        top: -90,
        left: -90,
        size: 180,
        color: Colors.white.withOpacity(0.08),
      ),
      _DecorationShape(
        shape: ShapeType.circle,
        bottom: -110,
        right: -70,
        size: 220,
        color: Colors.white.withOpacity(0.05),
      ),
      // Boxes
      _DecorationShape(
        shape: ShapeType.box,
        top: size.height * 0.3,
        left: -40,
        size: 120,
        color: Colors.white.withOpacity(0.07),
      ),
      _DecorationShape(
        shape: ShapeType.box,
        bottom: 80,
        right: 50,
        size: 100,
        color: Colors.white.withOpacity(0.06),
      ),
      // Triangles
      _DecorationShape(
        shape: ShapeType.triangle,
        top: 80,
        right: 70,
        size: 140,
        color: Colors.white.withOpacity(0.04),
      ),
      _DecorationShape(
        shape: ShapeType.triangle,
        bottom: 150,
        left: 30,
        size: 60,
        color: Colors.white.withOpacity(0.1),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor ?? AllMaterial.colorBluePrimary,
      body: Stack(
        children: [
          // Render all shapes
          ...decorations.map((d) {
            return Positioned(
              top: d.top,
              bottom: d.bottom,
              left: d.left,
              right: d.right,
              child: SizedBox(
                width: d.size,
                height: d.size,
                child: _buildShape(d),
              ),
            );
          }),

          // Main Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: size.width * 0.3,
                  child: Lottie.asset(
                    animationAsset,
                    repeat: true,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AllMaterial.colorWhite,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Sedang mengambil data...",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AllMaterial.colorWhite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShape(_DecorationShape d) {
    switch (d.shape) {
      case ShapeType.circle:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: d.color,
          ),
        );

      case ShapeType.box:
        return Container(
          decoration: BoxDecoration(
            color: d.color,
            borderRadius: BorderRadius.circular(d.size * 0.15),
          ),
        );

      case ShapeType.triangle:
        return CustomPaint(
          painter: _TrianglePainter(color: d.color),
        );

      default:
        return const SizedBox();
    }
  }
}

enum ShapeType { circle, box, triangle }

class _DecorationShape {
  final ShapeType shape;
  final double? top;
  final double? left;
  final double? bottom;
  final double? right;
  final double size;
  final Color color;

  _DecorationShape({
    required this.shape,
    this.top,
    this.left,
    this.bottom,
    this.right,
    required this.size,
    required this.color,
  });
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path();
    path.moveTo(size.width / 2, 0); // Top center
    path.lineTo(0, size.height); // Bottom left
    path.lineTo(size.width, size.height); // Bottom right
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
