import 'package:ropes/ropes.dart';
import 'package:ropes/src/vector.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('First Test', () {
      final rope = Rope.from(Vector2D.zero, const Vector2D(1, 1), 20);
      expect(rope.fixedPoint, Vector2D.zero);
      expect(rope.points.length, 21);
      expect(rope.points.first, Vector2D.zero);
      expect(rope.points.last, const Vector2D(1, 1));
    });
  });
}
