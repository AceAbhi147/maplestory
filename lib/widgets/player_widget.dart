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
    int throwingImgLen = AppAssets.ninja_throwing.length;
    int hurtingImgLen = AppAssets.ninja_hurting.length;
    int jumpingImgLen = AppAssets.ninja_jump.length;
    String img = "assets/images/ninja/ninja";

    if (isJumping) {
      img += "jump1.png";
    } else if (playerSpeedX == 0.0) {
      int count = (imageCount % standingImageLen) + 1;
      img += "stand$count.png";
    } else if (playerSpeedX != 0.0) {
      int count = (imageCount % runningImgLen) + 1;
      img += "running$count.png";
    } else if (isThrowing) {
      int count = (imageCount % throwingImgLen) + 1;
      img += "throw$count.png";
    } else if (isHurting) {
      // int count = (imageCount % hurtingImgLen) + 1;
      img += "hurt.png";
    } else if (isJumping) {
      // Do nothing
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
