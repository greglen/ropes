import 'dart:math';

class Vector2D {
  final double x, y;
  const Vector2D(
    this.x,
    this.y,
  );

  double get length => sqrt(x * x + y * y);

  Vector2D get normalize => this / length;

  Vector2D operator +(Vector2D v) => Vector2D(x + v.x, y + v.y);

  Vector2D operator -(Vector2D v) => Vector2D(x - v.x, y - v.y);

  Vector2D operator *(double d) => Vector2D(d * x, d * y);

  Vector2D operator /(double d) => Vector2D(x / d, y / d);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vector2D && other.x == x && other.y == y);

  @override
  int get hashCode => (x + y).hashCode;

  @override
  String toString() => 'Vector2D {x: $x, y: $y}';

  static const zero = Vector2D(0, 0);
}
