import 'package:ropes/ropes.dart';

class World {
  final List<Rope> _ropes = [];
  List<Rope> get ropes => _ropes;
  void addRope(Rope r) => _ropes.add(r);
  void removeRope(Rope r) => _ropes.remove(r);

  Duration lastDelta = Duration.zero;
  DateTime? _lastUpdate;
  void update(DateTime now) {
    lastDelta =
        _lastUpdate != null ? now.difference(_lastUpdate!) : Duration.zero;
    for (final r in _ropes) {
      r.update(now: now);
    }
    _lastUpdate = now;
  }
}
