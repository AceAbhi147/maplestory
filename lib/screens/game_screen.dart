import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/models/enums/facing_direction.dart';
import 'package:maplestory/models/enums/ninja_star_state.dart';
import 'package:maplestory/models/enums/player_state.dart';
import 'package:maplestory/models/enums/snail_state.dart';
import 'package:maplestory/models/ninja_star.dart';
import 'package:maplestory/models/pet.dart';
import 'package:maplestory/models/player.dart';
import 'package:maplestory/models/points_popup_data.dart';
import 'package:maplestory/utils/collision_detection.dart';
import 'package:maplestory/widgets/hud_bar_widget.dart';
import 'package:maplestory/widgets/ninja_star_widget.dart';
import 'package:maplestory/widgets/pet_widget.dart';
import 'package:maplestory/widgets/player_widget.dart';
import 'package:maplestory/widgets/points_popup.dart';
import 'package:maplestory/widgets/snail_widget.dart';

import '../models/snail.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  Ticker? _gameTicker;
  int _elapsedTime = 0;

  bool gameStarted = false;
  bool gameEnded = false;

  List<Snail> snails = [];
  Queue<NinjaStar> ninjaStars = Queue();
  List<PointsPopupData> popups = [];

  late final Pet pet;
  late final Player player;

  @override
  void initState() {
    initialiseSnails();
    pet = Pet.name();
    player = Player.name(pet: pet);
    startGame();
    super.initState();
  }

  @override
  void dispose() {
    _gameTicker!.dispose();
    super.dispose();
  }

  // Start game timer
  void startGame() {
    if (gameStarted) return;
    resetGame();
    gameStarted = true;
    _gameTicker = Ticker((elapsed) {
      _elapsedTime = elapsed.inMilliseconds;
      movePlayer(_elapsedTime);
      moveSnail(_elapsedTime);
      moveNinjaStar(_elapsedTime);
      CollisionDetection.checkForCollisionBtwPlayerAndSnail(
        player,
        snails,
        popups,
      );
      CollisionDetection.checkForCollisionBtwNinjaStarAndSnail(
        snails,
        ninjaStars,
        popups,
        player,
      );
      if (snails.isEmpty || player.playerState == PlayerState.dead) {
        endGame();
      }
      setState(() => {});
    });

    _gameTicker!.start();
  }

  // Initialise snails
  void initialiseSnails() {
    snails.add(
      Snail.name(maxX: 0.8, minX: 0.0, snailSpeedX: 0.00003, snailX: 0.5),
    );
    snails.add(
      Snail.name(maxX: 0.8, minX: 0.3, snailSpeedX: -0.00003, snailX: 0.8),
    );
  }

  // Reset Game
  void resetGame() {
    gameStarted = false;
    gameEnded = false;
    _elapsedTime = Duration.zero.inMilliseconds;
  }

  // End Game
  void endGame() {
    if (gameEnded) return;

    gameEnded = true;
    gameStarted = false;

    _gameTicker?.stop();

    setState(() {});
  }

  // Move snail
  void moveSnail(int timeElapsed) {
    snails.removeWhere(
          (snail) => snail.snailState == SnailState.dead,
    );
    for (final snail in snails) {
      snail.moveSnail(timeElapsed);
    }
  }

  // Move ninja star if any
  void moveNinjaStar(int timeElapsed) {
    while (ninjaStars.isNotEmpty &&
        ninjaStars.first.ninjaStarState == NinjaStarState.dead) {
      ninjaStars.removeFirst();
    }

    for (final ninjaStar in ninjaStars) {
      ninjaStar.moveNinjaStar(timeElapsed);
    }
  }

  // Move Player and pet with it
  void movePlayer(int timeElapsed) {
    player.movePlayer(timeElapsed);
  }

  void throwNinjaStar() {
    player.playerState = PlayerState.attacking;
    ninjaStars.add(
      NinjaStar.name(
        starSpeedX: player.facingDirection == FacingDirection.left
            ? -0.0008
            : 0.0008,
        starCurrPosX: player.playerX,
        starInitPosX: player.playerX,
        starPosY: player.playerY - 0.1,
        lastFrameTimestamp: _elapsedTime,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade700, Colors.lightBlue.shade100],
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  gameEnded
                      ? Align(
                          alignment: Alignment(0.0, 0.0),
                          child: Text(
                            "Game Over!!",
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: "Game",
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          HudBarWidget(
                            x: -0.8,
                            y: -0.9,
                            width: 200,
                            height: 30,
                            backgroundColor: Colors.white,
                            fillColor: Colors.red,
                            progressValue: player.hp,
                            title: "HP",
                          ),
                          HudBarWidget(
                            x: 0.8,
                            y: -0.9,
                            width: 200,
                            height: 30,
                            backgroundColor: Colors.white,
                            fillColor: Colors.green,
                            progressValue: player.xp,
                            title: "XP",
                          ),
                        ],
                      ),
                      Text(
                        "Total Score: ${player.score}",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Game",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  ...popups.map(
                    (popup) => Align(
                      alignment: Alignment(popup.x, popup.y),
                      child: PointsPopup(
                        points: popup.points,
                        key: ValueKey(popup.id),
                        onFinished: () {
                          setState(() {
                            popups.remove(popup);
                          });
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1.0, 1.0),
                    child: GestureDetector(
                      onTapDown: (_) =>
                          player.continuouslyMovePlayer(FacingDirection.left),
                      onTapUp: (_) => player.stopPlayerMovement(),
                      onTapCancel: () => player.stopPlayerMovement(),
                      child: Container(
                        height: 300,
                        width: 100,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.5),
                    child: GestureDetector(
                      onTap: () => player.jump(),
                      child: Container(
                        height: 300,
                        width: 500,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(1.0, 1.0),
                    child: GestureDetector(
                      onTapDown: (_) =>
                          player.continuouslyMovePlayer(FacingDirection.right),
                      onTapUp: (_) => player.stopPlayerMovement(),
                      onTapCancel: () => player.stopPlayerMovement(),
                      child: Container(
                        height: 300,
                        width: 100,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 1.0),
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        image: DecorationImage(
                          image: AssetImage(AppAssets.grass),
                          repeat: ImageRepeat.repeatX,
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  ...ninjaStars.map(
                    (ninjaStar) => NinjaStarWidget(
                      starPosX: ninjaStar.starCurrPosX,
                      starPosY: ninjaStar.starPosY,
                      directionThrown: ninjaStar.directionThrown,
                      imagePath: ninjaStar.image,
                    ),
                  ),
                  PetWidget(
                    petX: pet.petX,
                    petY: pet.petY,
                    facingDirection: pet.facingDirection,
                    imagePath: pet.image,
                  ),
                  GestureDetector(
                    onTap: () => throwNinjaStar(),
                    child: PlayerWidget(
                      playerX: player.playerX,
                      playerY: player.playerY,
                      facingDirection: player.facingDirection,
                      imagePath: player.image,
                    ),
                  ),
                  ...snails.map(
                    (snail) => SnailWidget(
                      snailX: snail.snailX,
                      snailY: snail.snailY,
                      currentDirection: snail.snailDirection,
                      image: snail.image,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown.shade900,
                image: DecorationImage(
                  image: AssetImage(AppAssets.rock),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitHeight,
                  repeat: ImageRepeat.repeatX,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
