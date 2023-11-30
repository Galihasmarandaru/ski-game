import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';

class Player extends PositionComponent with HasGameReference {
  Player({super.position});

  late final SpriteComponent _body;
  final _moveDirection = Vector2(0, 1);

  static const _maxSpeed = 80;
  static const _acceleration = 0.5;
  var _speed = 0.0;

  @override
  Future<void> onLoad() async {
    final tiles = game.images.fromCache('../images/tilemap_packed.png'); // lokasi ambilnya sesuai di Level1.tmx assets/images
    final spriteSheet = SpriteSheet(image: tiles, srcSize: Vector2.all(16));

    _body = SpriteComponent(
      sprite: spriteSheet.getSprite(5, 10), // getSprite(5, 10) is coordinate icon in tilemap_packed.png
      anchor: Anchor.center,
    );

    await add(_body);
  }

  // Frame per second = 60 frames
  // Time per frame = 1/60 seconds or 16 ms
  // delta time (dt)

  // Speed = Distance/Time
  // Distance = Speed x Time
  @override
  void update(double dt) {
    _speed = lerpDouble(_speed, _maxSpeed, _acceleration * dt)!;
    position.addScaled(_moveDirection, _speed * dt);
    print('SPEED: $_speed');
  }
}
