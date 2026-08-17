import 'dart:collection';
import 'dart:math';

import 'package:maplestory/models/enums/ninja_star_state.dart';
import 'package:maplestory/models/enums/player_state.dart';
import 'package:maplestory/models/enums/snail_state.dart';
import 'package:maplestory/models/ninja_star.dart';
import 'package:maplestory/models/snail.dart';

import '../models/player.dart';
import '../models/points_popup_data.dart';

class CollisionDetection {
  static final collisionEpsilon = 0.1;

  static void checkForCollisionBtwNinjaStarAndSnail(
    List<Snail> snails,
    Queue<NinjaStar> ninjaStars,
    List<PointsPopupData> popups,
    Player player,
  ) {
    for (final snail in snails) {
      for (final ninjaStar in ninjaStars) {
        if (((snail.snailX - ninjaStar.starCurrPosX).abs() <=
                collisionEpsilon) &&
            ((snail.snailY - ninjaStar.starPosY).abs() <= collisionEpsilon) &&
            snail.snailState != SnailState.hurting &&
            snail.snailState != SnailState.dead &&
            ninjaStar.ninjaStarState != NinjaStarState.dead) {
          snail.snailState = SnailState.hurting;
          ninjaStar.ninjaStarState = NinjaStarState.dead;
          player.xp = min(1.0, player.xp + 0.1);
          player.score += snail.points;
          popups.add(
            PointsPopupData(points: snail.points, x: snail.snailX, y: 0.0),
          );
        }
      }
    }
  }

  static void checkForCollisionBtwPlayerAndSnail(
    Player player,
    List<Snail> snails,
    List<PointsPopupData> popups,
  ) {
    for (final snail in snails) {
      if (((player.playerX - snail.snailX).abs() <= collisionEpsilon) &&
          (player.playerY - snail.snailY).abs() <= collisionEpsilon &&
          snail.snailState != SnailState.hurting &&
          snail.snailState != SnailState.dead &&
          player.playerState != PlayerState.hurting &&
          player.playerState != PlayerState.dead) {
        player.jump(isHurt: true);
        player.playerState = PlayerState.hurting;
        player.hp = max(0.0, player.hp - 0.1);
        popups.add(PointsPopupData(points: -10, x: player.playerX, y: 0.0));
      }
    }
  }
}
