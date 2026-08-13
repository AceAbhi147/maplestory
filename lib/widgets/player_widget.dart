import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplestory/assets/assets.dart';

class PlayerWidget extends StatelessWidget {
  final double playerX;
  final double playerY;
  final double playerSpeedX;
  final double playerSpeedY;
  final bool isFacingLeft;
  final bool isHurting;
  final bool isThrowing;
  final bool isJumping;
  final int imageCount;

  const PlayerWidget({
    super.key,
    required this.playerX,
    required this.playerY,
    required this.playerSpeedX,
    required this.playerSpeedY,
    required this.isFacingLeft,
    this.isHurting = false,
    this.isThrowing = false,
    this.isJumping = false,
    required this.imageCount,
  });

  @override
  Widget build(BuildContext context) {
    int standingImageLen = AppAssets.ninja_standing.length;
    int runningImgLen = AppAssets.ninja_running.length;
    String img = "assets/images/ninja/ninja";

    if (isThrowing) {
      img += "throw2.png";
    } else if (isJumping) {
      img += "jump1.png";
    } else if (isHurting) {
      img += "hurt.png";
    } else if (playerSpeedX == 0.0) {
      int count = (imageCount % standingImageLen) + 1;
      img += "stand$count.png";
    } else if (playerSpeedX != 0.0) {
      int count = (imageCount % runningImgLen) + 1;
      img += "running$count.png";
    }

    return !isFacingLeft
        ? Align(
            alignment: Alignment(playerX, playerY),
            child: Container(
              height: 100,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment(playerX, playerY),
            child: Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.rotationY(pi),
              child: Container(
                height: 100,
                width: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(img),
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
          );
  }
}
