import 'package:ropes/src/vector.dart';
import 'package:test/test.dart';

void main() {
  test('Vector Add', () {
    expect(const Vector2D(1, 1) + const Vector2D(1, 1), const Vector2D(2, 2));
  });
  test('Vector Subtract', () {
    expect(const Vector2D(1, 1) - const Vector2D(1, 1), Vector2D.zero);
  });
  test('Vector Multiply', () {
    expect(const Vector2D(1, 1) * 2, const Vector2D(2, 2));
  });
  test('Vector Divide', () {
    expect(const Vector2D(1, 1) / 2, const Vector2D(.5, .5));
  });
}
