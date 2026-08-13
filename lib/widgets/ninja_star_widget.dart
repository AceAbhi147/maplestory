import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplestory/assets/assets.dart';

class NinjaStarWidget extends StatelessWidget {
  final double starDimension;
  final double starPosX;
  final double starPosY;
  final double starSpeedX;
  final bool isAttacking;

  const NinjaStarWidget({
    super.key,
    required this.starPosX,
    required this.starPosY,
    required this.isAttacking,
    required this.starSpeedX,
    required this.starDimension,
  });

  @override
  Widget build(BuildContext context) {
    if (!isAttacking) return SizedBox.shrink();
    return starSpeedX > 0.0
        ? Align(
            alignment: Alignment(starPosX, starPosY),
            child: Container(
              height: starDimension,
              width: starDimension,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.ninja_star.first),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment(starPosX, starPosY),
            child: Transform(
              transform: Matrix4.rotationY(pi),
              child: Container(
                height: starDimension,
                width: starDimension,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.ninja_star.first),
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          );
  }
}
