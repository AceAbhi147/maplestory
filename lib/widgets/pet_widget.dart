import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplestory/assets/assets.dart';

class PetWidget extends StatelessWidget {
  final double petX;
  final double petY;
  final double petSpeedX;
  final bool isFacingLeft;
  final bool isRunning;
  final int imageCount;

  const PetWidget({
    super.key,
    required this.petX,
    required this.petY,
    required this.petSpeedX,
    required this.isFacingLeft,
    required this.isRunning,
    required this.imageCount,
  });

  @override
  Widget build(BuildContext context) {
    String img = "assets/images/cat/cat";
    if (petSpeedX != 0.0 && isRunning) {
      int count = (imageCount % AppAssets.cat_running.length) + 1;
      img += "running_$count.png";
    } else {
      int count = (imageCount % AppAssets.cat_staying.length) + 1;
      img += "_$count.png";
    }

    return !isFacingLeft
        ? Align(
            alignment: Alignment(petX, petY),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(img),
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment(petX, petY),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(img),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          );
  }
}
