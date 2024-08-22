import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/levels/level.dart';

class PixelAdventure extends FlameGame {
  @override
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent _cam;
  final _world = Level();

  @override
  FutureOr<void> onLoad() {
    _cam = CameraComponent.withFixedResolution(
      world: _world,
      width: 640,
      height: 360,
    );
    _cam.viewfinder.anchor = Anchor.topLeft;

    addAll([_cam, _world]);
    return super.onLoad();
  }
}
