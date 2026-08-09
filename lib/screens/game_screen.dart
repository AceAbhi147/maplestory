import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/widgets/snail_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>{
  Timer? _gameTimer;

  bool gameStarted = false;
  bool gameEnded = false;

  // Snail position
  double snailX = 0.5;
  double snailY = 1.0;
  double snailVelocityX = -0.01;
  int snailImageCount = 0;

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
          Container(color: Colors.green, height: 10),
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
