// the "driver" file
import java.util.LinkedList;

void setup() {
  
}

void draw() {
  
}

// any class that implements "Drawable" will be able to be displayed in Processing
interface Drawable {
   void drawObj();
}

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


