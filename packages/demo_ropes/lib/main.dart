import 'package:demo_ropes/game/game.dart';
import 'package:flutter/material.dart';
import 'package:ropes/ropes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Home();
  }
}

class _Home extends StatefulWidget {
  const _Home();

  @override
  State<_Home> createState() => __HomeState();
}

class __HomeState extends State<_Home> {
  World world = World();

  @override
  void initState() {
    _reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ropes Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.restart_alt),
                  onPressed: _reload,
                )
              ],
            ),
          ),
          Expanded(child: Game(world)),
        ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void _reload() {
    world.ropes.toList().forEach(world.removeRope);
    world.addRope(
      Rope.from(
        const Vector2D(200, 100),
        const Vector2D(200, 0),
        10,
        stiffness: .1,
      ),
    );
    world.addRope(
      Rope.from(
        const Vector2D(400, 100),
        const Vector2D(200, 0),
        20,
        stiffness: 1.8,
      ),
    );
  }
}
