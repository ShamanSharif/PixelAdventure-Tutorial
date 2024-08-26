import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/src/services/hardware_keyboard.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

enum PlayerState { idle, running }

enum PlayerDirection { left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  String character;
  Player({super.position, this.character = "Virtual-Guy"});

  // Animation Related Variables
  late final SpriteAnimation _idleAnimaiton;
  late final SpriteAnimation _runningAnimaiton;
  final double _stepTime = 0.05;
  var _isFacingRight = true;

  // Movement Related Variables
  var playerDirection = PlayerDirection.none;
  final _moveSpeed = 100.0;
  var _velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    var isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    var isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (isLeftKeyPressed && isRightKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else {
      playerDirection = PlayerDirection.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  // Private Methods

  void _loadAllAnimations() {
    _idleAnimaiton = _getSpriteAnimation("Idle", 11);

    _runningAnimaiton = _getSpriteAnimation("Run", 12);

    animations = {
      PlayerState.idle: _idleAnimaiton,
      PlayerState.running: _runningAnimaiton,
    };

    current = PlayerState.idle;
  }

  SpriteAnimation _getSpriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache("Main-Characters/$character/$state-(32x32).png"),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: _stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlayerMovement(double dt) {
    var dirX = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (_isFacingRight) {
          flipHorizontallyAroundCenter();
          _isFacingRight = false;
        }
        dirX -= _moveSpeed;
        current = PlayerState.running;
        break;
      case PlayerDirection.right:
        if (!_isFacingRight) {
          flipHorizontallyAroundCenter();
          _isFacingRight = true;
        }
        dirX += _moveSpeed;
        current = PlayerState.running;
        break;
      case PlayerDirection.none:
        // dirX = 0.0;
        current = PlayerState.idle;
        break;
      default:
        break;
    }
    _velocity = Vector2(dirX, 0);
    position += _velocity * dt;
  }
}
