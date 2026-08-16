import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplestory/models/enums/facing_direction.dart';

class SnailWidget extends StatelessWidget {
  final double snailX;
  final double snailY;
  final FacingDirection currentDirection;
  final String image;

  const SnailWidget({
    super.key,
    required this.snailX,
    required this.snailY,
    required this.currentDirection,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) return SizedBox.shrink();

    Container snailContainer = Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );

    return Align(
      alignment: Alignment(snailX, snailY),
      child: currentDirection == FacingDirection.left
          ? snailContainer
          : Transform(
              transform: Matrix4.rotationY(pi),
              alignment: Alignment.bottomCenter,
              child: snailContainer,
            ),
    );
  }
}
