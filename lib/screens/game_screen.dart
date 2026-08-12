import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/widgets/pet_widget.dart';
import 'package:maplestory/widgets/player_widget.dart';
import 'package:maplestory/widgets/snail_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Timer? _gameTimer;

  bool gameStarted = false;
  bool gameEnded = false;

  // Snail position
  double snailX = 0.5;
  double snailY = 0.98;
  double snailVelocityX = -0.01;
  int snailImageCount = 0;

  // Player position
  double playerX = -0.5;
  double playerY = 0.98;
  double playerSpeedX = 0.0;
  double playerSpeedY = 0.0;
  bool isFacingLeft = false;
  int playerImageCount = 0;
  double gravity = -9.8;
  double velocityY = 2.5;
  double dt = 0.01;

  // Pet position
  double petX = -0.7;
  double petY = 0.97;
  bool isPetFacingLeft = false;
  bool isPetRunning = false;
  int petImageCount = 0;

  @override
  void initState() {
    startGame();
    super.initState();
  }

  // Start game timer
  void startGame() {
    if (gameStarted) return;
    resetGame();
    gameStarted = true;
    _gameTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        moveSnail();
        movePlayer();
        movePet();
      });
    });
  }

  // Reset Game
  void resetGame() {
    gameStarted = false;
    gameEnded = false;
    _gameTimer = null;
  }

  // End Game
  void endGame() {
    gameEnded = true;
    _gameTimer?.cancel();
  }

  // Move snail
  void moveSnail() {
    if (snailX <= 0.3) {
      snailVelocityX = 0.01;
    } else if (snailX >= 0.8) {
      snailVelocityX = -0.01;
    }

    snailX += snailVelocityX;
    snailImageCount = (snailImageCount + 1) % AppAssets.snail_staying.length;
  }

  // Move player
  void movePlayer() {
    playerImageCount = (playerImageCount + 1) % 1000;
    playerX += playerSpeedX;
  }

  // Move player left() {
  void movePlayerLeft() {
    isFacingLeft = true;
    playerSpeedX = -0.05;
  }

  // Move player right() {
  void movePlayerRight() {
    isFacingLeft = false;
    playerSpeedX = 0.05;
  }

  // Stop player movement
  void stopPlayerMovement() {
    playerSpeedX = 0.0;
  }

  // Move pet
  void movePet() {
    petImageCount = (petImageCount + 1) % 1000;
    if ((playerX - petX).abs() >= 0.25) {
      petX += playerSpeedX;
      isPetRunning = true;
    } else {
      isPetRunning = false;
    }

    if (playerX >= petX) {
      isPetFacingLeft = false;
    } else {
      isPetFacingLeft = true;
    }
  }

  // Player jumps
  bool isJumping = false;
  void playerJumps() {
    if (isJumping) return;
    isJumping = true;
    if (isFacingLeft) {
      playerSpeedX -= 0.05;
    } else {
      playerSpeedX += 0.05;
    }
    Timer.periodic(
      const Duration(milliseconds: 16),
          (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        setState(() {
          velocityY += gravity * dt;

          playerY -= velocityY * dt;

          if (playerY >= 0.98) {
            playerY = 0.98;
            isJumping = false;
            playerSpeedX = 0.0;
            velocityY = 2.5;
            timer.cancel();
          }
        });
      },
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
              color: Colors.blue,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(-1.0, 1.0),
                    child: GestureDetector(
                      onTapDown: (_) => movePlayerLeft(),
                      onTapUp: (_) => stopPlayerMovement(),
                      onTapCancel: () => stopPlayerMovement(),
                      child: Container(
                        height: 300,
                        width: 100,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 0.5),
                    child: GestureDetector(
                      onTap: () => playerJumps(),
                      child: Container(
                        height: 300,
                        width: 500,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(1.0, 1.0),
                    child: GestureDetector(
                      onTapDown: (_) => movePlayerRight(),
                      onTapUp: (_) => stopPlayerMovement(),
                      onTapCancel: () => stopPlayerMovement(),
                      child: Container(
                        height: 300,
                        width: 100,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.0, 1.0),
                    child: Container(color: Colors.green, height: 20),
                  ),
                  PetWidget(
                    petX: petX,
                    petY: petY,
                    petSpeedX: playerSpeedX,
                    isFacingLeft: isPetFacingLeft,
                    isRunning: isPetRunning,
                    imageCount: petImageCount,
                  ),
                  PlayerWidget(
                    playerX: playerX,
                    playerY: playerY,
                    playerSpeedX: playerSpeedX,
                    playerSpeedY: velocityY,
                    isFacingLeft: isFacingLeft,
                    isJumping: isJumping,
                    imageCount: playerImageCount,
                  ),
                  SnailWidget(
                    snailX: snailX,
                    snailY: snailY,
                    snailVelocityX: snailVelocityX,
                    imageCount: snailImageCount,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("M A P E L S T O R Y"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () {}, child: Text("Attack")),
                      ElevatedButton(onPressed: () {}, child: Text("←")),
                      ElevatedButton(onPressed: () {}, child: Text("↑")),
                      ElevatedButton(onPressed: () {}, child: Text("→")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
