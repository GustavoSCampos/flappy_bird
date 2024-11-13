import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Ground extends SpriteComponent with HasGameRef<FlappyBirdGame>, CollisionCallbacks{
  // init
  Ground() : super();

  /*

  LOAD

   */

 @override
  FutureOr<void> onLoad() async {
   // set size & position (2x width for infinite scroll)
   size = Vector2(2 * gameRef.size.x, groundHeight);
   position = Vector2(0, gameRef.size.y - groundHeight);

   // load ground sprite image
   sprite = await Sprite.load('ground.png');

   // add collision box
  add(RectangleHitbox());
 }

 /*

 UPDATE -> every second

  */

 @override
 void update(double dt) {
  // move ground to left
  position.x -= groundScrollingSpeed * dt;

  // reset ground if it goes off screen for infinite scroll
  // if half of ground gas been passed, reset.
  if(position.x + size.x / 2 <= 0) {
   position.x = 0;
  }
 }

}