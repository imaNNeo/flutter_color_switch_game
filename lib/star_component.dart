import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/rendering.dart';
import 'package:flutter/material.dart';

class StarComponent extends PositionComponent {
  late Sprite _starSprite;

  StarComponent({
    required super.position,
  }) : super(
          size: Vector2(28, 28),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _starSprite = await Sprite.load('star_icon.png');
    decorator.addLast(PaintDecorator.tint(Colors.white));
    add(CircleHitbox(
      radius: size.x / 2,
      collisionType: CollisionType.passive,
    ));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _starSprite.render(
      canvas,
      position: size / 2,
      size: size,
      anchor: Anchor.center,
    );
  }
}
