import 'dart:math';

import 'package:clock/clock.dart';
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
  RopeObject? _selected;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.addListener(_update);
    _controller.repeat();
    super.initState();
  }

  DateTime? _lastUpdate;
  void _update() {
    _lastUpdate ??= clock.now();
    _lastUpdate = _lastUpdate!.add(const Duration(milliseconds: 160));
    widget.world.update(_lastUpdate ?? clock.now());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (d) {
        _selected = widget.world.ropeHeadAt(d.localPosition);
        _selected?.selected = true;
      },
      onTapUp: (d) {
        _selected?.selected = false;
        _selected = null;
      },
      onPanUpdate: (d) {
        _selected?.rope.start =
            Vector2D(d.localPosition.dx, d.localPosition.dy);
      },
      onPanCancel: () {
        _selected?.selected = false;
        _selected = null;
      },
      onPanEnd: (d) {
        _selected?.selected = false;
        _selected = null;
      },
      child: CustomPaint(
        painter: _Painter(
          widget.world,
          repaint: _controller,
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final World world;
  _Painter(this.world, {super.repaint});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);

    for (final ropeObject in world.ropes) {
      final r = ropeObject.rope;
      final path = Path();
      path.moveTo(r.start.x, r.start.y);

      Vector2D pre = r.nodes.first.position;
      for (final n in r.nodes.sublist(1)) {
        final p = n.position;

        /// we map +-10% of stretch to +-255 to change the color of the segment
        final double stretch =
            (((pre - p).length - r.segmentLength) / r.segmentLength * 10 * 255)
                .clamp(
          -255.0,
          255.0,
        );

        final Paint paint = Paint()
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..color = Color.fromRGBO(
            max(0, stretch.round()), // me map positive stretch to reds
            max(0, -stretch.round()), // me map negative stretch to greens
            1,
            1,
          );
        canvas.drawLine(Offset(pre.x, pre.y), Offset(p.x, p.y), paint);
        pre = p;
      }

      canvas.drawCircle(
        Offset(r.start.x, r.start.y),
        5,
        Paint()..color = ropeObject.selected ? Colors.yellow : Colors.black,
      );
    }

    // TextSpan span = TextSpan(
    //   style: const TextStyle(
    //     color: Colors.black,
    //     fontSize: 22,
    //   ),
    //   text: world.lastDelta.inMilliseconds.toString(),
    // );
    // TextPainter tp = TextPainter(
    //   text: span,
    //   textAlign: TextAlign.left,
    //   textDirection: TextDirection.ltr,
    // );
    // tp.layout();

    // tp.paint(
    //   canvas,
    //   Offset(size.width - tp.width - 2, 0),
    // );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
