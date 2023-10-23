import 'dart:math' as math;

import 'package:color_switch_game/my_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ColorSwitcher extends PositionComponent with HasGameRef<MyGame>, CollisionCallbacks {
  ColorSwitcher({
    required super.position,
    this.radius = 20,
  }) : super(
          anchor: Anchor.center,
          size: Vector2.all(radius * 2),
        );

  final double radius;
  final _paint = Paint();

  @override
  void onLoad() {
    super.onLoad();
    add(CircleHitbox(
      position: size / 2,
      radius: radius,
      anchor: anchor,
      collisionType: CollisionType.passive,
    ));
  }

  @override
  void render(Canvas canvas) {
    final length = gameRef.gameColors.length;
    final sweepAngle = (math.pi * 2) / length;
    for (int i = 0; i < length; i++) {
      canvas.drawArc(
        size.toRect(),
        i * sweepAngle,
        sweepAngle,
        true,
        _paint..color = gameRef.gameColors[i],
      );
    }
  }
}
