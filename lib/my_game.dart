import 'dart:ui';
import 'package:color_switch_game/player.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'circle_rotator.dart';
import 'color_switcher.dart';
import 'ground.dart';
import 'star_component.dart';

class MyGame extends FlameGame
    with TapCallbacks, HasCollisionDetection, HasDecorator, HasTimeScale {
  late Player myPlayer;

  final List<Color> gameColors;

  final ValueNotifier<int> currentScore = ValueNotifier(0);

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
  void onLoad() {
    decorator = PaintDecorator.blur(0);
    FlameAudio.bgm.initialize();
    super.onLoad();
  }

  @override
  void onMount() {
    _initializeGame();
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

  void _initializeGame() {
    currentScore.value = 0;
    world.add(Ground(position: Vector2(0, 400)));
    world.add(myPlayer = Player(position: Vector2(0, 250)));
    camera.moveTo(Vector2(0, 0));
    _generateGameComponents();
    FlameAudio.bgm.play('background.mp3');
  }

  void _generateGameComponents() {
    world.add(ColorSwitcher(position: Vector2(0, 180)));
    world.add(CircleRotator(
      position: Vector2(0, 0),
      size: Vector2(200, 200),
    ));
    world.add(StarComponent(
      position: Vector2(0, 0),
    ));

    world.add(ColorSwitcher(position: Vector2(0, -200)));
    world.add(CircleRotator(
      position: Vector2(0, -400),
      size: Vector2(150, 150),
    ));
    world.add(CircleRotator(
      position: Vector2(0, -400),
      size: Vector2(180, 180),
    ));
    world.add(StarComponent(
      position: Vector2(0, -400),
    ));
  }

  void gameOver() {
    FlameAudio.bgm.stop();
    for (var element in world.children) {
      element.removeFromParent();
    }
    _initializeGame();
  }

  bool get isGamePaused => timeScale == 0.0;

  bool get isGamePlaying => !isGamePaused;

  void pauseGame() {
    (decorator as PaintDecorator).addBlur(10);
    timeScale = 0.0;
    FlameAudio.bgm.pause();
  }

  void resumeGame() {
    (decorator as PaintDecorator).addBlur(0);
    timeScale = 1.0;
    FlameAudio.bgm.resume();
  }

  void increaseScore() {
    currentScore.value++;
  }
}
