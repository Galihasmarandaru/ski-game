import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';
import 'package:ski_master/game/input.dart';
import 'package:ski_master/game/player/player.dart';
import 'package:ski_master/game/player/snowman.dart';

class Gameplay extends Component with HasGameReference {
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
    final world = World(children: [map, input]);
    await add(world);

    // If want to potrait mode then we change width into 180 and height into 320
    final camera = CameraComponent.withFixedResolution(
      width: 320,
      height: 180,
      world: world,
    );
    await add(camera);

    final tiles = game.images.fromCache('../images/tilemap_packed.png'); // lokasi ambilnya sesuai di Level1.tmx assets/images
    final spriteSheet = SpriteSheet(image: tiles, srcSize: Vector2.all(16));

    final spawnPointLayer = map.tileMap.getLayer<ObjectGroup>('SpawnPoint');
    final objects = spawnPointLayer?.objects;

    if (objects != null) {
      for (final object in objects) {
        switch (object.class_) {
          case 'Player':
            final player = Player(
              position: Vector2(object.x, object.y),
              sprite: spriteSheet.getSprite(5, 10),
            );
            await world.add(player);
            camera.follow(player);
            break;
          case 'Snowman':
            final snowman = Snowman(
              position: Vector2(object.x, object.y),
              sprite: spriteSheet.getSprite(5, 9),
            );
            await world.add(snowman);
            break;
        }
      }
    }

    // camera.moveTo(Vector2(map.size.x * 0.5, camera.viewport.virtualSize.y * 0.5)); // X = 320/2 (160), Y = 180/2 (90)

    // Camera target == Viewfinder anchor (aka logical center)
    // Default value of anchor for Viewfinder is Anchor.center
  }
}
