import 'dart:async';

import 'package:flame/components.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState { idle, running }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure> {
  final String character;
  Player({super.position, required this.character});

  late final SpriteAnimation idleAnimaiton;
  late final SpriteAnimation runningAnimaiton;
  final double stepTime = 0.05;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  _loadAllAnimations() {
    idleAnimaiton = _getSpriteAnimation("Idle", 11);

    runningAnimaiton = _getSpriteAnimation("Run", 12);

    animations = {
      PlayerState.idle: idleAnimaiton,
      PlayerState.running: runningAnimaiton,
    };

    current = PlayerState.idle;
  }

  SpriteAnimation _getSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache("Main-Characters/$character/$state-(32x32).png"),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
