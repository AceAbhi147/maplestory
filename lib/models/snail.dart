import 'dart:math';

import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/models/enums/facing_direction.dart';

import 'enums/snail_state.dart';

class Snail {
  double _snailX;
  final double _snailY;
  double _snailSpeedX;
  int _animationFrame = 0;
  int _lastFrameTimestamp = 0;
  SnailState _snailState = SnailState.moving;
  late FacingDirection _snailDirection;
  String image = "";
  final double _minX;
  final double _maxX;

  Snail.name({
    required double snailX,
    required double snailSpeedX,
    required double minX,
    required double maxX,
    double snailY = 0.98,
  }) : _snailX = snailX,
       _snailSpeedX = snailSpeedX,
       _minX = minX,
       _maxX = maxX,
       _snailY = snailY {
    _snailDirection = _snailSpeedX > 0.0
        ? FacingDirection.right
        : FacingDirection.left;
  }

  SnailState get snailState => _snailState;

  set snailState(SnailState value) {
    _snailState = value;
    _animationFrame = 0;
  }

  FacingDirection get snailDirection => _snailDirection;

  set snailDirection(FacingDirection value) {
    _snailDirection = value;
  }

  int get animationFrame => _animationFrame;

  set animationFrame(int value) {
    _animationFrame = value;
  }

  double get snailSpeedX => _snailSpeedX;

  set snailSpeedX(double value) {
    _snailSpeedX = value;
  }

  double get snailY => _snailY;

  double get snailX => _snailX;

  set snailX(double value) {
    _snailX = value;
  }

  int get lastFrameTimestamp => _lastFrameTimestamp;

  double get minX => _minX;

  double get maxX => _maxX;

  void moveSnail(int timeElapsed) {
    num dt = (timeElapsed - _lastFrameTimestamp);
    switch (snailState) {
      case SnailState.moving:
        if (snailX <= minX) {
          snailSpeedX = 0.00003;
          snailDirection = FacingDirection.right;
        } else if (snailX >= maxX) {
          snailSpeedX = -0.00003;
          snailDirection = FacingDirection.left;
        }
        snailX += snailSpeedX * dt;
        if (dt >= 100.0) {
          _animationFrame =
              (_animationFrame + 1) % AppAssets.snail_staying.length;
          _lastFrameTimestamp = timeElapsed;
        }
        image = "assets/images/snail/snail_$_animationFrame.png";
        break;
      case SnailState.hurting:
        snailSpeedX = 0.0;
        animationFrame = min(AppAssets.snail_hurting.length - 1, dt ~/ 200);
        image = "assets/images/snail/snailhurt_$_animationFrame.png";

        if (dt >= 800) {
          snailState = SnailState.dead;
          _lastFrameTimestamp = timeElapsed;
        }
        break;
      default:
        image = "";
        animationFrame = 0;
        break;
    }
  }
}
