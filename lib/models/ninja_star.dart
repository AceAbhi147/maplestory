import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/models/enums/facing_direction.dart';
import 'package:maplestory/models/enums/ninja_star_state.dart';

class NinjaStar {
  double _starSpeedX;
  final double _starInitPosX;
  double _starCurrPosX;
  final double _starPosY;
  late final FacingDirection _directionThrown;
  NinjaStarState _ninjaStarState = NinjaStarState.moving;
  String _image = "";
  int _lastFrameTimestamp;

  NinjaStar.name({
    required double starSpeedX,
    required double starCurrPosX,
    required double starInitPosX,
    required int lastFrameTimestamp,
    required double starPosY,
  }) : _starCurrPosX = starCurrPosX,
       _starPosY = starPosY,
       _starInitPosX = starInitPosX,
       _lastFrameTimestamp = lastFrameTimestamp,
       _starSpeedX = starSpeedX {
    _directionThrown = _starSpeedX > 0.0
        ? FacingDirection.right
        : FacingDirection.left;
  }

  double get starSpeedX => _starSpeedX;

  set starSpeedX(double value) {
    _starSpeedX = value;
  }

  double get starInitPosX => _starInitPosX;

  double get starCurrPosX => _starCurrPosX;

  set starCurrPosX(double value) {
    _starCurrPosX = value;
  }

  double get starPosY => _starPosY;

  FacingDirection get directionThrown => _directionThrown;

  NinjaStarState get ninjaStarState => _ninjaStarState;

  set ninjaStarState(NinjaStarState value) {
    _ninjaStarState = value;
  }

  int get lastFrameTimestamp => _lastFrameTimestamp;

  set lastFrameTimestamp(int value) {
    _lastFrameTimestamp = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  void moveNinjaStar(int timeElapsed) {
    if (ninjaStarState == NinjaStarState.dead) {
      image = "";
      return;
    }
    num dt = (timeElapsed - lastFrameTimestamp).clamp(0.0, 33.0);
    double newPosX = starCurrPosX + (starSpeedX * dt);
    if ((newPosX - starInitPosX).abs() >= 0.5) {
      image = "";
      ninjaStarState = NinjaStarState.dead;
      return;
    }

    image = AppAssets.ninja_star.first;
    starCurrPosX = newPosX;
    lastFrameTimestamp = timeElapsed;
  }
}
