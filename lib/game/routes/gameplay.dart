import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';

class Gameplay extends Component with KeyboardHandler {
  Gameplay(
    this.currentLevel, {
    super.key,
    this.onPausePressed,
    this.onLevelComplete,
    this.onGameOver,
  });

  static const id = 'Gameplay';

  final int currentLevel;
  final VoidCallback? onPausePressed;
  final VoidCallback? onLevelComplete;
  final VoidCallback? onGameOver;

  @override
  Future<void> onLoad() async {
    final map = await TiledComponent.load('Level1.tmx', Vector2.all(16));

    final world = World(children: [map]);
    await add(world);

    // If want to potrait mode then we change width into 180 and height into 320
    final camera = CameraComponent.withFixedResolution(
      width: 320,
      height: 180,
      world: world,
    );
    await add(camera);

    camera.moveTo(Vector2(map.size.x * 0.5, camera.viewport.virtualSize.y * 0.5)); // X = 320/2 (160), Y = 180/2 (90)

    // Camera target == Viewfinder anchor (aka logical center)
    // Default value of anchor for Viewfinder is Anchor.center
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyP)) {
      onPausePressed?.call();
    } else if (keysPressed.contains(LogicalKeyboardKey.keyC)) {
      onLevelComplete?.call();
    } else if (keysPressed.contains(LogicalKeyboardKey.keyO)) {
      onGameOver?.call();
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
