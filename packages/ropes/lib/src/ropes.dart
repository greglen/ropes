import 'vector.dart';

class Rope {
  final List<RopeNode> nodes;
  final Vector2D fixedPoint;
  final double segmentLength;
  Rope(this.fixedPoint, this.nodes)
      : segmentLength = (nodes.last.position - nodes.first.position).length /
            (nodes.length - 1);

  /// Creates a new [Rope] which starts from [fixedPoint] and is straight until [length] with [segments]
  factory Rope.from(
    Vector2D fixedPoint,
    Vector2D length,
    int segments,
  ) {
    return Rope(
      fixedPoint,
      List<RopeNode>.generate(
        segments + 1,
        (i) => RopeNode(
          fixedPoint + (length / segments.toDouble()) * i.toDouble(),
          isFixed: i == 0,
        ),
      ),
    );
  }

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
      Vector2D newPos = n.position * 2 +
          const Vector2D(0, 9.8) *
              ((delta.inMicroseconds / 1000000) *
                  (delta.inMicroseconds / 1000000)) -
          (n.previousPosition ?? n.position);

      n.previousPosition = n.position;
      n.position = newPos;
    }
    for (int i = 0; i < 10; i++) {
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
        final correction = delta.normalize * (l - segmentLength);
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
