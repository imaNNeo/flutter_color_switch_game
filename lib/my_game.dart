import 'dart:ui';
import 'package:color_switch_game/player.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'circle_rotator.dart';
import 'color_switcher.dart';
import 'ground.dart';

class MyGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player myPlayer;

  final List<Color> gameColors;

  MyGame({
    this.gameColors = const [
      Colors.redAccent,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.yellowAccent,
    ],
  }) : super(
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1000,
          ),
        );

  @override
  Color backgroundColor() => const Color(0xff222222);

  @override
  void onMount() {
    world.add(Ground(position: Vector2(0, 400)));
    world.add(myPlayer = Player(position: Vector2(0, 250)));
    generateGameComponents();
    super.onMount();
  }

  @override
  void update(double dt) {
    final cameraY = camera.viewfinder.position.y;
    final playerY = myPlayer.position.y;

    if (playerY < cameraY) {
      camera.viewfinder.position = Vector2(0, playerY);
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    myPlayer.jump();
    super.onTapDown(event);
  }

  void generateGameComponents() {
    world.add(ColorSwitcher(position: Vector2(0, 180)));
    world.add(CircleRotator(
      position: Vector2(0, 0),
      size: Vector2(200, 200),
    ));


    world.add(ColorSwitcher(position: Vector2(0, -200)));
    world.add(CircleRotator(
      position: Vector2(0, -400),
      size: Vector2(150, 150),
    ));
  }
}
