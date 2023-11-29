import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ski_master/game/game.dart';

void main() {
  runApp(const SkiMasterApp());
}

class SkiMasterApp extends StatelessWidget {
  const SkiMasterApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameWidget.controlled(gameFactory: SkiMasterGame.new),
    );
  }
}
