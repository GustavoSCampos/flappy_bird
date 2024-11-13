import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

import 'ground.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  /*

  INIT BIRD

   */

  // initialize bird position & size
  Bird() : super(
      position: Vector2(birdStartX, birdStartY),
      size: Vector2(birdWidth, birdHeight)
  );

  // physical word properties
  double velocity = 0;

  /*

  LOAD

   */

  @override
  FutureOr<void> onLoad() async {
    // load bird sprite image
    sprite = await Sprite.load('bird.png');

    // add hit box
    add(RectangleHitbox());
  }

  /*

  JUMP / FLAP

   */

  void flap() {
    velocity = jumpStrength;
  }

  /*

  UPDATE -> every second

   */

  @override
  void update(double dt) {
    // aply gravity
    velocity += gravity * dt;

    // update bird's position based on current velocity
    position.y += velocity * dt;

  }

  /*

  COLLISION -> whit another object

   */

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // check if bird collides with ground
    if(other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }

    // check if bird collides with ground
    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }

}