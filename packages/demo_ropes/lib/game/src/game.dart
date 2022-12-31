import 'package:demo_ropes/game/src/world.dart';
import 'package:flutter/material.dart';
import 'package:ropes/ropes.dart';

class Game extends StatefulWidget {
  final World world;
  const Game(this.world, {super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.addListener(_update);
    _controller.repeat();
    super.initState();
  }

  void _update() {
    final now = DateTime.now();
    widget.world.update(now);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _Painter(widget.world, repaint: _controller),
    );
  }
}

class _Painter extends CustomPainter {
  final World world;
  _Painter(this.world, {super.repaint});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);

    final paint = Paint();
    for (Rope r in world.ropes) {
      Path path = Path();
      path.moveTo(r.fixedPoint.x, r.fixedPoint.y);
      for (final p in r.points) {
        path.lineTo(p.x, p.y);
      }
      canvas.drawPath(path, paint..style = PaintingStyle.stroke);

      canvas.drawCircle(
        Offset(r.fixedPoint.x, r.fixedPoint.y),
        5,
        Paint(),
      );
    }

    TextSpan span = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 22,
      ),
      text: world.lastDelta.inMilliseconds.toString(),
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    tp.paint(
      canvas,
      Offset(size.width - tp.width - 2, 0),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
