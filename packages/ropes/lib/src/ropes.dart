import 'vector.dart';

class Rope {
  final List<Vector2D> points;
  final Vector2D fixedPoint;
  Rope(this.fixedPoint, this.points);

  /// Creates a new [Rope] which starts from [fixedPoint] and is straight until [length] with [segments]
  factory Rope.from(
    Vector2D fixedPoint,
    Vector2D length,
    int segments,
  ) {
    return Rope(
      fixedPoint,
      List<Vector2D>.generate(
        segments + 1,
        (i) => fixedPoint + (length / segments.toDouble()) * i.toDouble(),
      ),
    );
  }

  DateTime? _lastUpdate;
  void update({DateTime? now}) {
    now ??= DateTime.now();

    // update the rope here
    //

    _lastUpdate = now;
  }
}
