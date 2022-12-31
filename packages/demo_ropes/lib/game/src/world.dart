import 'package:ropes/ropes.dart';

class World {
  final List<Rope> _ropes = [];
  List<Rope> get ropes => _ropes;
  void addRope(Rope r) => _ropes.add(r);
  void removeRope(Rope r) => _ropes.remove(r);

  void update(DateTime now) {
    for (final r in _ropes) {
      r.update(now);
    }
  }
}
