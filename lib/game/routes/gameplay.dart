import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';
import 'package:ski_master/game/input.dart';
import 'package:ski_master/game/player.dart';

class Gameplay extends Component {
  Gameplay(
    this.currentLevel, {
    super.key,
    required this.onPausePressed,
    required this.onLevelComplete,
    required this.onGameOver,
  });

  static const id = 'Gameplay';

  final int currentLevel;
  final VoidCallback onPausePressed;
  final VoidCallback onLevelComplete;
  final VoidCallback onGameOver;

  late final input = Input(keyCallbacks: {
    LogicalKeyboardKey.keyP: onPausePressed,
    LogicalKeyboardKey.keyC: onLevelComplete,
    LogicalKeyboardKey.keyO: onGameOver,
  });

  @override
  Future<void> onLoad() async {
    final map = await TiledComponent.load('Level1.tmx', Vector2.all(16));
    final player = Player(position: Vector2(map.size.x * 0.5, 8));

    final world = World(children: [map, input, player]);
    await add(world);

    // If want to potrait mode then we change width into 180 and height into 320
    final camera = CameraComponent.withFixedResolution(
      width: 320,
      height: 180,
      world: world,
    );
    await add(camera);

    // camera.moveTo(Vector2(map.size.x * 0.5, camera.viewport.virtualSize.y * 0.5)); // X = 320/2 (160), Y = 180/2 (90)
    camera.follow(player);

    // Camera target == Viewfinder anchor (aka logical center)
    // Default value of anchor for Viewfinder is Anchor.center
  }
}
