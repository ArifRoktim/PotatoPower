/* classes that implement "Collideable" will be able to collide with other objects
  that also implement "Collideable"
*/
interface Collideable extends Drawable {
  // when a projectile collides with another
  public void collide( Collideable other);

  public void collide(); //needed?

  public boolean isColliding( Collideable other );

  public float getX();
  public float getY();

  public int getWidth();
  public int getHeight();
}
