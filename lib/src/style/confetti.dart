import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_template/config.dart';

class _Vector {
  double x, y;
  _Vector(this.x, this.y);
}

class _PaperSnipping {
  final Color frontColor;
  Size _bounds;
  _PaperSnipping({
    required this.frontColor,
    required Size bounds,
  }) : _bounds = bounds;

  static final Random _random = Random();
  static const degToRad = pi / 180;
  static const backSideBlend = Color(0x70EEEEEE);

  late final _Vector position = _Vector(
    _random.nextDouble() * _bounds.width,
    _random.nextDouble() * _bounds.height,
  );

  final double rotationSpeed = 800 + _random.nextDouble() * 600;
  final double angle = _random.nextDouble() * 360 * degToRad;
  final double size = 7.0;
  final double oscillationSpeed = 0.5 + _random.nextDouble() * 1.5;
  final double xSpeed = 40;
  final double ySpeed = 50 + _random.nextDouble() * 60;

  late List<_Vector> corners = List.generate(4, (index) {
    final angle = this.angle + degToRad * (45 + index * 90);
    return _Vector(cos(angle), sin(angle));
  });
  late final Color backColor = Color.alphaBlend(backSideBlend, frontColor);
  final paint = Paint()..style = PaintingStyle.fill;

  double rotation = _random.nextDouble() * 360 * degToRad;
  double cosA = 1.0;
  double time = _random.nextDouble();

  void draw(Canvas canvas) {
    paint.color = (cosA > 0) ? frontColor : backColor;
    final path = Path()..addPolygon(
      List.generate(
        4,
        (index) => Offset(
          position.x + corners[index].x * size,
          position.y + corners[index].y * size * cosA,
        )
      ),
      true,
    );
    canvas.drawPath(path, paint);
  }

  void update(double dt) {
    time += dt;
    rotation += rotationSpeed * dt;
    cosA = cos(degToRad * rotation);
    position.x += cos(time * oscillationSpeed) * xSpeed * dt;
    position.y += ySpeed * dt;
    if (position.y > _bounds.height) {
      position.x = _random.nextDouble() * _bounds.width;
      position.y = 0;
    }
  }

  void updateBounds(Size newBounds) {
    if (!newBounds.contains(Offset(position.x, position.y))) {
      position.x = _random.nextDouble() * newBounds.width;
      position.y = _random.nextDouble() * newBounds.height;
    }
    _bounds = newBounds;
  }

}

class ConfettiPainter extends CustomPainter {
  final UnmodifiableListView<Color> colors;
  ConfettiPainter({
    required Listenable animation,
    required Iterable<Color> colors,
  }) : colors = UnmodifiableListView(colors),
       super(repaint: animation);

  final defaultPaint = Paint();
  final int snippingsCount = 200;

  late final List<_PaperSnipping> _snippings;
  Size? _size;
  DateTime _lastTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    if (_size == null) {
      _snippings = List.generate(snippingsCount, (index) => _PaperSnipping(
        frontColor: colors[index % colors.length],
        bounds: size),
      );
    }

    final didResize = _size != null && _size != size;
    final now = DateTime.now();
    final dt = now.difference(_lastTime);
    for (final snipping in _snippings) {
      if (didResize) snipping.updateBounds(size);
      snipping.update(dt.inMilliseconds / 1000);
      snipping.draw(canvas);
    }

    _size = size;
    _lastTime = now;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}

class Confetti extends StatefulWidget {
  final bool isStopped;
  final List<Color> colors;
  const Confetti({
    super.key,
    this.colors = AppCfg.colorConfettiDefault,
    this.isStopped = false,
  });

  @override
  State<Confetti> createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti>
  with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), vsync: this);
    if (!widget.isStopped) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Confetti oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isStopped && !widget.isStopped) {
      _controller.repeat();
    } else if (!oldWidget.isStopped && widget.isStopped) {
      _controller.stop(canceled: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConfettiPainter(
        colors: widget.colors,
        animation: _controller,
      ),
      willChange: true,
      child: const SizedBox.expand(),
    );
  }
}


