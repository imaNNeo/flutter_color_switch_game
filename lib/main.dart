import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(game: MyGame()),
  );
}

class MyGame extends FlameGame with TapCallbacks {
  late Player myPlayer;

  @override
  Color backgroundColor() => const Color(0xff222222);

  @override
  void onMount() {
    add(myPlayer = Player());
    super.onMount();
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }
}

class Player extends PositionComponent {
  final _velocity = Vector2(0, 30.0);
  final _gravity = 980.0;
  final _jumpSpeed = 350.0;

  @override
  void onMount() {
    position = Vector2(150, 100);
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += _velocity * dt;
    _velocity.y += _gravity * dt;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(
      position.toOffset(),
      15,
      Paint()..color = Colors.yellow,
    );
  }

  void jump() {
    _velocity.y = -_jumpSpeed;
  }
}
