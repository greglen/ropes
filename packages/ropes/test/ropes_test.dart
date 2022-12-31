import 'package:ropes/ropes.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    test('First Test', () {
      final rope = Rope.from(Vector2D.zero, const Vector2D(1, 1), 20);
      expect(rope.fixedPoint, Vector2D.zero);
      expect(rope.nodes.length, 21);
      expect(rope.nodes.first, RopeNode(Vector2D.zero));
      expect(rope.nodes.last, RopeNode(const Vector2D(1, 1)));
    });
  });
}
