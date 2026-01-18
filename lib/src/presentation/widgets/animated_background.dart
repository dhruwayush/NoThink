import 'dart:math';
import 'dart:ui' show ImageFilter; 
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget? child;
  const AnimatedBackground({super.key, this.child});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base Dark Background
        Container(color: AppTheme.backgroundDark),
        
        // Moving Gradient Orbs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _MeshGradientPainter(_controller.value),
              size: Size.infinite,
            );
          },
        ),
        
        // Blur Overlay for Softness
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3), // Darken slightly
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(color: Colors.transparent),
          ),
        ),

        if (widget.child != null) widget.child!,
      ],
    );
  }
}

class _MeshGradientPainter extends CustomPainter {
  final double progress;
  _MeshGradientPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    
    // Orb 1: Primary Purple
    final p1 = Offset(
      w * 0.2 + sin(progress * 2 * pi) * 50,
      h * 0.3 + cos(progress * 2 * pi) * 50,
    );
    final paint1 = Paint()
      ..color = AppTheme.primary.withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    canvas.drawCircle(p1, w * 0.6, paint1);

    // Orb 2: Secondary Blue/Cyan
    final p2 = Offset(
      w * 0.8 - cos(progress * 2 * pi) * 50,
      h * 0.7 - sin(progress * 2 * pi) * 50,
    );
    final paint2 = Paint()
      ..color = Colors.blueAccent.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 120);
    canvas.drawCircle(p2, w * 0.7, paint2);
  }

  @override
  bool shouldRepaint(_MeshGradientPainter oldDelegate) => oldDelegate.progress != progress;
}
