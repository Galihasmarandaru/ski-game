import 'package:flame/components.dart';

class Snowman extends PositionComponent {
  Snowman({super.position, required Sprite sprite}) : _body = SpriteComponent(sprite: sprite, anchor: Anchor.center);

  final SpriteComponent _body;

  @override
  Future<void> onLoad() async {
    await add(_body);
  }
}
