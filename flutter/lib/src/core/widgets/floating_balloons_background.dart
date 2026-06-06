import 'dart:math';
import 'package:flutter/material.dart';

class Balloon {
  double x;
  double y;
  double speed;
  double size;
  double swingSpeed;
  double swingRange;
  double phase;
  Color color;

  Balloon({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
    required this.swingSpeed,
    required this.swingRange,
    required this.phase,
    required this.color,
  });
}

class FloatingBalloonsBackground extends StatefulWidget {
  final Widget child;

  const FloatingBalloonsBackground({super.key, required this.child});

  @override
  State<FloatingBalloonsBackground> createState() =>
      _FloatingBalloonsBackgroundState();
}

class _FloatingBalloonsBackgroundState extends State<FloatingBalloonsBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<Balloon> _balloons = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )
      ..addListener(() {
        _updateBalloons();
      })
      ..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_balloons.isEmpty) {
      final size = MediaQuery.of(context).size;
      for (int i = 0; i < 15; i++) {
        _balloons.add(_createBalloon(size.width, size.height, isInitial: true));
      }
    }
  }

  Balloon _createBalloon(double screenWidth, double screenHeight,
      {bool isInitial = false}) {
    final colors = [
      Colors.pink.shade100,
      Colors.blue.shade100,
      Colors.orange.shade100,
      Colors.purple.shade100,
      Colors.green.shade100,
    ];

    return Balloon(
      x: _random.nextDouble() * screenWidth,
      y: isInitial ? _random.nextDouble() * screenHeight : screenHeight + 100,
      speed: 0.4 + _random.nextDouble() * 0.8,
      size: 40 + _random.nextDouble() * 25,
      swingSpeed: 1.0 + _random.nextDouble() * 1.5,
      swingRange: 10 + _random.nextDouble() * 12,
      phase: _random.nextDouble() * pi * 2,
      color: colors[_random.nextInt(colors.length)].withValues(alpha: 0.25),
    );
  }

  void _updateBalloons() {
    final size = MediaQuery.of(context).size;
    if (size.width == 0 || size.height == 0) return;

    setState(() {
      for (var balloon in _balloons) {
        balloon.y -= balloon.speed;
        balloon.phase += 0.01 * balloon.swingSpeed;

        if (balloon.y < -balloon.size - 100) {
          final index = _balloons.indexOf(balloon);
          _balloons[index] =
              _createBalloon(size.width, size.height, isInitial: false);
        }
      }
    });
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
        Positioned.fill(
          child: CustomPaint(
            painter: BalloonPainter(balloons: _balloons),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class BalloonPainter extends CustomPainter {
  final List<Balloon> balloons;

  BalloonPainter({required this.balloons});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.15)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (var balloon in balloons) {
      paint.color = balloon.color;
      final currentX = balloon.x + sin(balloon.phase) * balloon.swingRange;

      final path = Path()
        ..moveTo(currentX, balloon.y + balloon.size * 0.5)
        ..quadraticBezierTo(
          currentX + sin(balloon.phase * 2) * 8,
          balloon.y + balloon.size * 1.0,
          currentX,
          balloon.y + balloon.size * 1.4,
        );
      canvas.drawPath(path, linePaint);

      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(currentX, balloon.y),
          width: balloon.size * 0.8,
          height: balloon.size,
        ),
        paint,
      );

      final knotPath = Path()
        ..moveTo(currentX, balloon.y + balloon.size * 0.48)
        ..lineTo(currentX - 5, balloon.y + balloon.size * 0.56)
        ..lineTo(currentX + 5, balloon.y + balloon.size * 0.56)
        ..close();
      canvas.drawPath(knotPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
