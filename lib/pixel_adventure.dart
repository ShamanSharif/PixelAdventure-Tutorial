import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:pixel_adventure/actors/player.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent _cam;
  // late final JoystickComponent _joystick;
  final Player _player = Player();

  @override
  Future<void> onLoad() async {
    // Loading all images to cache
    await images.loadAllImages();

    final world = Level(
      levelName: "Level-01",
      player: _player,
    );

    _cam = CameraComponent.withFixedResolution(
      world: world,
      width: 640,
      height: 360,
    );
    _cam.viewfinder.anchor = Anchor.topLeft;
    _cam.priority = 1;

    addAll([_cam, world]);
    // _addJoystick();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // _handleJoystickInput();
    super.update(dt);
  }

  // Private Methods

  // void _addJoystick() {
  //   _joystick = JoystickComponent(
  //     knob: SpriteComponent(
  //       sprite: Sprite(
  //         images.fromCache("Hud/Knob.png"),
  //       ),
  //     ),
  //     background: SpriteComponent(
  //       sprite: Sprite(
  //         images.fromCache("Hud/Joystick.png"),
  //       ),
  //     ),
  //     margin: const EdgeInsets.only(left: 32, bottom: 32),
  //     priority: 10,
  //   );

  //   add(_joystick);
  // }

  // void _handleJoystickInput() {
  //   switch (_joystick.direction) {
  //     case JoystickDirection.left:
  //     case JoystickDirection.upLeft:
  //     case JoystickDirection.downLeft:
  //       _player.playerDirection = PlayerDirection.left;
  //       break;
  //     case JoystickDirection.right:
  //     case JoystickDirection.upRight:
  //     case JoystickDirection.downRight:
  //       _player.playerDirection = PlayerDirection.right;
  //       break;
  //     default:
  //       _player.playerDirection = PlayerDirection.none;
  //       break;
  //   }
  // }
}
