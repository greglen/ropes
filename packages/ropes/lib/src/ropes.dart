import 'package:ropes/src/vector.dart';

class Rope {
  final List<RopeNode> nodes;
  final double segmentLength;
  double stiffness;

  Rope(
    this.nodes, {
    this.stiffness = 1,
  }) : segmentLength = (nodes.last.position - nodes.first.position).length /
            (nodes.length - 1);

  /// Creates a new [Rope] which starts from [start] and is straight until
  /// [length] with [segments]
  factory Rope.from(
    Vector2D start,
    Vector2D length,
    int segments, {
    double stiffness = 1,
  }) {
    return Rope(
      List<RopeNode>.generate(
        segments + 1,
        (i) => RopeNode(
          start + (length / segments.toDouble()) * i.toDouble(),
          isFixed: i == 0,
        ),
      ),
      stiffness: stiffness,
    );
  }

  set start(Vector2D s) => nodes.first.position = s;

  Vector2D get start => nodes.first.position;

  double get length {
    RopeNode previousNode = nodes.first;
    double length = 0;
    for (final n in nodes.sublist(1)) {
      length += (n.position - previousNode.position).length;
      previousNode = n;
    }
    return length;
  }

  DateTime? _lastUpdate;
  void update(DateTime now) {
    final delta = now.difference(_lastUpdate ?? now);

    for (final n in nodes.sublist(1)) {
      /// We do a Verlet integration where we add the average displacement to the
      ///  forces multiplied by the square of time delta
      final newPos = n.position * 2 +
          const Vector2D(0, 9.8) *
              ((delta.inMicroseconds / 1000000) *
                  (delta.inMicroseconds / 1000000)) -
          (n.previousPosition ?? n.position);

      n.previousPosition = n.position;
      n.position = newPos;
    }
    for (int i = 0; i < 200; i++) {
      _solveConstraints();
    }
    _lastUpdate = now;
  }

  void _solveConstraints() {
    RopeNode previousNode = nodes.first;
    for (final n in nodes.sublist(1)) {
      final Vector2D delta = n.position - previousNode.position;
      final double l = delta.length;
      if (l != segmentLength) {
        final correction = delta.normalize * (l - segmentLength) * stiffness;
        if (previousNode.isFixed && n.isFixed) {
        } else if (!previousNode.isFixed && !n.isFixed) {
          previousNode.position += correction / 2;
          n.position -= correction / 2;
        } else if (previousNode.isFixed && !n.isFixed) {
          n.position -= correction;
        } else if (!previousNode.isFixed && n.isFixed) {
          previousNode.position += correction;
        } else {
          assert(false);
        }
      }
      previousNode = n;
    }
  }
}

class RopeNode {
  Vector2D? previousPosition;
  Vector2D position;
  bool isFixed;
  RopeNode(this.position, {this.isFixed = false});

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RopeNode &&
            other.position == position &&
            other.previousPosition == previousPosition);
  }

  @override
  int get hashCode {
    return (position.hashCode + previousPosition.hashCode).hashCode;
  }

  @override
  String toString() {
    return 'RopeNode {position: $position, previousPosition: $previousPosition}';
  }
}
