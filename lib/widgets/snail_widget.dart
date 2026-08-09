import 'dart:math';

import 'package:flutter/material.dart';

class SnailWidget extends StatelessWidget {
  final double snailX;
  final double snailY;
  final double snailVelocityX;
  final int imageCount;

  const SnailWidget({
    super.key,
    required this.snailX,
    required this.snailY,
    required this.snailVelocityX,
    required this.imageCount,
  });

  @override
  Widget build(BuildContext context) {
    return snailVelocityX < 0
        ? Align(
            alignment: Alignment(snailX, snailY),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/snail/snail_0${imageCount + 1}.png",
                  ),
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment(snailX, snailY),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/snail/snail_0${imageCount + 1}.png",
                    ),
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          );
  }
}
