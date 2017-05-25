/* classes that implement "Collideable" will be able to collide with other objects
  that also implement "Collideable"
*/
interface Collideable extends Drawable {
  // when a projectile collides with another
  public void collide( Collideable other);

  public void collide(); //needed?

  // movement for the projectiles
  public void move();

  public int getX();
  public int getY();

  public int getWidth();
  public int getHeight();
}
