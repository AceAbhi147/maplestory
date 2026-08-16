import 'package:maplestory/assets/assets.dart';
import 'package:maplestory/models/enums/facing_direction.dart';
import 'package:maplestory/models/enums/player_state.dart';
import 'package:maplestory/models/pet.dart';

class Player {
  double _playerX;
  double _playerY;
  double _playerSpeedX;
  double _playerSpeedY;
  FacingDirection _facingDirection;
  int _lastFrameTimestamp;
  int _lastPhysicsTimestamp;
  int _animationFrame;
  PlayerState _playerState;
  String _image;
  Pet _pet;
  double jumpingUpVelocity = 1.5;
  double gravity = -4.2;
  bool _isGrounded = true;

  Player.name({
    double playerX = -0.5,
    double playerY = 0.98,
    double playerSpeedX = 0.0,
    double playerSpeedY = 0.0,
    FacingDirection facingDirection = FacingDirection.right,
    int lastFrameTimestamp = 0,
    int lastPhysicsTimestamp = 0,
    int animationFrame = 0,
    PlayerState playerState = PlayerState.idle,
    String image = "",
    required Pet pet,
  }) : _playerX = playerX,
       _playerY = playerY,
       _playerSpeedX = playerSpeedX,
       _playerSpeedY = playerSpeedY,
       _facingDirection = facingDirection,
       _lastFrameTimestamp = lastFrameTimestamp,
       _lastPhysicsTimestamp = lastPhysicsTimestamp,
       _animationFrame = animationFrame,
       _playerState = playerState,
       _image = image,
       _pet = pet;

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  PlayerState get playerState => _playerState;

  set playerState(PlayerState value) {
    _playerState = value;
    _animationFrame = 0;
  }

  int get animationFrame => _animationFrame;

  set animationFrame(int value) {
    _animationFrame = value;
  }

  int get lastFrameTimestamp => _lastFrameTimestamp;

  set lastFrameTimestamp(int value) {
    _lastFrameTimestamp = value;
  }

  int get lastPhysicsTimestamp => _lastPhysicsTimestamp;

  set lastPhysicsTimestamp(int value) {
    _lastPhysicsTimestamp = value;
  }

  FacingDirection get facingDirection => _facingDirection;

  set facingDirection(FacingDirection value) {
    _facingDirection = value;
  }

  double get playerSpeedY => _playerSpeedY;

  set playerSpeedY(double value) {
    _playerSpeedY = value;
  }

  double get playerSpeedX => _playerSpeedX;

  set playerSpeedX(double value) {
    _playerSpeedX = value;
  }

  double get playerY => _playerY;

  set playerY(double value) {
    _playerY = value;
  }

  double get playerX => _playerX;

  set playerX(double value) {
    _playerX = value;
  }

  Pet? get pet => _pet;


  bool get isGrounded => _isGrounded;

  set isGrounded(bool value) {
    _isGrounded = value;
  }

  void continuouslyMovePlayer(FacingDirection direction) {
    if (playerState != PlayerState.idle) return;
    facingDirection = direction;
    playerState = PlayerState.moving;
    if (facingDirection == FacingDirection.left) {
      playerSpeedX = -0.0005;
    } else {
      playerSpeedX = 0.0005;
    }
  }

  void stopPlayerMovement() {
    if (playerState != PlayerState.moving) return;
    playerState = PlayerState.idle;
    playerSpeedX = 0.0;
  }

  void jump() {
    if (!isGrounded) return;
    isGrounded = false;
    if (facingDirection == FacingDirection.left) {
      playerSpeedX = -0.0005;
    } else {
      playerSpeedX = 0.0005;
    }
    playerState = PlayerState.jumping;
    jumpingUpVelocity = 1.5;
  }

  void movePlayer(int timeElapsed) {
    num dt = (timeElapsed - lastFrameTimestamp).clamp(0.0, 150.0);
    num physicsDt = (timeElapsed - lastPhysicsTimestamp).clamp(0.0, 33.0);
    lastPhysicsTimestamp = timeElapsed;

    // Vertical physics
    num dtSeconds = (physicsDt / 1000.0);
    if (!isGrounded) {
      jumpingUpVelocity += gravity * dtSeconds;
      playerY -= jumpingUpVelocity * dtSeconds;

      if (playerY >= 0.98) {
        playerY = 0.98;
        playerSpeedX = 0.0;
        jumpingUpVelocity = 1.5;
        isGrounded = true;

        playerState = PlayerState.idle;
      }
    }

    switch (playerState) {
      case PlayerState.idle:
        if (dt >= 100) {
          animationFrame =
              (animationFrame + 1) % AppAssets.ninja_standing.length;
          lastFrameTimestamp = timeElapsed;
        }
        image = "assets/images/ninja/ninjastand$animationFrame.png";
        break;
      case PlayerState.moving:
        if (dt >= 100) {
          playerX += (playerSpeedX * dt);
          animationFrame =
              (animationFrame + 1) % AppAssets.ninja_running.length;
          lastFrameTimestamp = timeElapsed;
        }
        image = "assets/images/ninja/ninjarunning$animationFrame.png";
        break;
      case PlayerState.jumping:
        if (dt >= 10) {
          playerX += playerSpeedX * dt;
          lastFrameTimestamp = timeElapsed;
        }

        image = "assets/images/ninja/ninjajump1.png";
        break;
      case PlayerState.attacking:
        if (dt >= 200) {
          lastFrameTimestamp = timeElapsed;
          playerState = PlayerState.idle;
        }
        image = "assets/images/ninja/ninjathrow1.png";
        break;
      default:
        animationFrame = 0;
        image = "";
        break;
    }

    // Move pet
    pet!.movePet(timeElapsed, playerX, playerSpeedX, facingDirection);
  }
}
