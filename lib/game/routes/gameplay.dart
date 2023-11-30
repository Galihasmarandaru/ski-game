import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';

class Gameplay extends Component with KeyboardHandler {
  Gameplay(
    this.currentLevel, {
    super.key,
    this.onPausePressed,
  });

  static const id = 'Gameplay';

  final int currentLevel;
  final VoidCallback? onPausePressed;

  @override
  Future<void> onLoad() async {
    final map = await TiledComponent.load('sampleMap.tmx', Vector2.all(64));
    await add(map);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.keyP)) {
      onPausePressed?.call();
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
