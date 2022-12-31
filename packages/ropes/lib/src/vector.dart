class Vector2D {
  final double x, y;
  const Vector2D(
    this.x,
    this.y,
  );

  Vector2D operator +(Vector2D v) {
    return Vector2D(x + v.x, y + v.y);
  }

  Vector2D operator -(Vector2D v) {
    return Vector2D(x - v.x, y - v.y);
  }

  Vector2D operator *(double d) {
    return Vector2D(d * x, d * y);
  }

  Vector2D operator /(double d) {
    return Vector2D(x / d, y / d);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Vector2D && other.x == x && other.y == y);
  }

  @override
  int get hashCode {
    return (x + y).hashCode;
  }

  @override
  String toString() {
    return 'Vector2D {x: $x, y: $y}';
  }

  static const zero = Vector2D(0, 0);
}
