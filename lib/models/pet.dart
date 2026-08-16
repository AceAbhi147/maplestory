import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/models/enums/facing_direction.dart';
import 'package:maplestory/models/enums/pet_state.dart';

class Pet {
  double _petX;
  final double _petY;
  FacingDirection _facingDirection;
  String _image = "";
  PetState _petState = PetState.idle;
  int _lastFrameTimestamp = 0;
  int _animationFrame = 0;

  Pet.name({
    double petX = -0.7,
    double petY = 0.97,
    FacingDirection facingDirection = FacingDirection.right,
  })
      : _petX = petX,
        _petY = petY,
        _facingDirection = facingDirection;


  double get petX => _petX;

  set petX(double value) {
    _petX = value;
  }

  double get petY => _petY;

  FacingDirection get facingDirection => _facingDirection;

  set facingDirection(FacingDirection value) {
    _facingDirection = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  PetState get petState => _petState;

  set petState(PetState value) {
    if (value != petState) {
      animationFrame = 0;
    }
    _petState = value;
  }

  int get lastFrameTimestamp => _lastFrameTimestamp;

  set lastFrameTimestamp(int value) {
    _lastFrameTimestamp = value;
  }

  int get animationFrame => _animationFrame;

  set animationFrame(int value) {
    _animationFrame = value;
  }

  void movePet(int timeElapsed, double playerX, double playerSpeedX,
      FacingDirection playerDirection) {
    num dt = (timeElapsed - lastFrameTimestamp).clamp(0.0, 150);
    if (playerSpeedX == 0.0) {
      petState = PetState.idle;
    } else if ((playerX - petX).abs() >= 0.25) {
      petState = PetState.moving;
    }

    if (playerX >= petX) {
      facingDirection = FacingDirection.right;
    } else {
      facingDirection = FacingDirection.left;
    }

    switch (petState) {
      case PetState.idle:
        if (dt >= 100) {
          animationFrame = (animationFrame + 1) % AppAssets.cat_staying.length;
          lastFrameTimestamp = timeElapsed;
        }
        image = "assets/images/cat/cat_$animationFrame.png";
        break;
      case PetState.moving:
        if ((playerX - petX).abs() >= 0.25) {
          petX += playerSpeedX * dt;
        }
        if (dt >= 100) {
          animationFrame = (animationFrame + 1) % AppAssets.cat_running.length;
          lastFrameTimestamp = timeElapsed;
        }
        image = "assets/images/cat/catrunning_$animationFrame.png";
        break;
    }
  }
}
