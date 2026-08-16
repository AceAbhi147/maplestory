import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/models/enums/facing_direction.dart';

class NinjaStarWidget extends StatelessWidget {
  final double starPosX;
  final double starPosY;
  final FacingDirection directionThrown;

  const NinjaStarWidget({
    super.key,
    required this.starPosX,
    required this.starPosY,
    required this.directionThrown,
  });

  @override
  Widget build(BuildContext context) {
    Container ninjaStar = Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.ninja_star.first),
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );

    return Align(
      alignment: Alignment(starPosX, starPosY),
      child: directionThrown == FacingDirection.right ? ninjaStar : Transform(
        transform: Matrix4.rotationY(pi),
        alignment: Alignment.bottomCenter,
        child: ninjaStar,),
    );
  }
}
