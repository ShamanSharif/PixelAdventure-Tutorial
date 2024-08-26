import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/actors/player.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent _cam;
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

    addAll([_cam, world]);
    return super.onLoad();
  }
}
