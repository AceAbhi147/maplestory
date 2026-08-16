import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplestory/models/enums/facing_direction.dart';

class PlayerWidget extends StatelessWidget {
  final double playerX;
  final double playerY;
  final FacingDirection facingDirection;
  final String imagePath;

  const PlayerWidget({
    super.key,
    required this.playerX,
    required this.playerY,
    required this.facingDirection,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) return SizedBox.shrink();

    Container playerContainer = Container(
      height: 100,
      width: 90,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );

    return Align(
      alignment: Alignment(playerX, playerY),
      child: facingDirection == FacingDirection.right
          ? playerContainer
          : Transform(transform: Matrix4.rotationY(pi),
          alignment: Alignment.bottomCenter,
          child: playerContainer,),
    );
  }
}
