import 'dart:collection';

import 'package:maplestory/models/enums/ninja_star_state.dart';
import 'package:maplestory/models/enums/player_state.dart';
import 'package:maplestory/models/enums/snail_state.dart';
import 'package:maplestory/models/ninja_star.dart';
import 'package:maplestory/models/snail.dart';

import '../models/player.dart';

class CollisionDetection {
  static final collisionEpsilon = 0.1;

  static void checkForCollisionBtwNinjaStarAndSnail(
    List<Snail> snails,
    Queue<NinjaStar> ninjaStars,
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
        }
      }
    }
  }

  static void checkForCollisionBtwPlayerAndSnail(
    Player player,
    List<Snail> snails,
  ) {
    for (final snail in snails) {
      if (((player.playerX - snail.snailX).abs() <= collisionEpsilon) &&
          (player.playerY - snail.snailY).abs() <= collisionEpsilon &&
          snail.snailState != SnailState.hurting &&
          snail.snailState != SnailState.dead &&
          player.playerState != PlayerState.hurting &&
          player.playerState != PlayerState.dead) {
        player.playerState = PlayerState.hurting;
      }
    }
  }
}
