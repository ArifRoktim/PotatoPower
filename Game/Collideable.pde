/* classes that implement "Collideable" will be able to collide with other objects
  that also implement "Collideable"
*/
interface Collideable extends Drawable {
  // when a projectile collides with another
  void collide( Collideable other);

  void collide(); //needed?

  // movement for the projectiles
  void move();
}

