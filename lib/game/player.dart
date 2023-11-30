import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends PositionComponent with HasGameReference {
  Player({super.position});

  late final SpriteComponent _body;

  @override
  Future<void> onLoad() async {
    final tiles = game.images.fromCache('../images/tilemap_packed.png'); // lokasi ambilnya sesuai di Level1.tmx assets/images
    final spriteSheet = SpriteSheet(image: tiles, srcSize: Vector2.all(16));

    _body = SpriteComponent(
      sprite: spriteSheet.getSprite(5, 10),
      anchor: Anchor.center,
    );

    await add(_body);
  }
}
