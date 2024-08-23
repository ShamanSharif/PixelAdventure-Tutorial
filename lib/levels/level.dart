import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pixel_adventure/actors/player.dart';

class Level extends World {
  final String levelName;

  Level({required this.levelName});
  late TiledComponent level;

  @override
  Future<void> onLoad() async {
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));
    add(level);

    final spawnPointsLayer =
        level.tileMap.getLayer<ObjectGroup>("Spawn-Points");

    for (var spawnPoint in spawnPointsLayer?.objects ?? <TiledObject>[]) {
      switch (spawnPoint.class_) {
        case 'Player':
          final player = Player(
            character: "Virtual-Guy",
            position: Vector2(spawnPoint.x, spawnPoint.y),
          );
          add(player);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
