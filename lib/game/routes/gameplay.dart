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
    await add(map);
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
