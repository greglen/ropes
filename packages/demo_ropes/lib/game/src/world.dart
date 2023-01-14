import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ropes/ropes.dart';

class World {
  final List<RopeObject> _ropes = [];
  List<RopeObject> get ropes => _ropes;
  void addRope(RopeObject r) => _ropes.add(r);
  void removeRope(RopeObject r) => _ropes.remove(r);

  void update(DateTime now) {
    for (final r in _ropes) {
      r.update(now);
    }
  }

  RopeObject? ropeHeadAt(Offset pos) {
    final p = Vector2D(pos.dx, pos.dy);
    return _ropes.firstWhereOrNull(
      (r) => (r.rope.nodes.first.position - p).length < 5,
    );
  }
}

class RopeObject {
  final Rope rope;
  bool selected = false;
  RopeObject(this.rope);

  void update(DateTime now) => rope.update(now);
}
