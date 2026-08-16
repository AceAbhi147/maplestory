import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/models/enums/facing_direction.dart';

class PetWidget extends StatelessWidget {
  final double petX;
  final double petY;
  final FacingDirection facingDirection;
  final String imagePath;

  const PetWidget({
    super.key,
    required this.petX,
    required this.petY,
    required this.facingDirection,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    Container petContainer = Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );

    return Align(
      alignment: Alignment(petX, petY),
      child: facingDirection == FacingDirection.left
          ? petContainer
          : Transform(
              transform: Matrix4.rotationY(pi),
              alignment: Alignment.bottomCenter,
              child: petContainer,
            ),
    );
  }
}
