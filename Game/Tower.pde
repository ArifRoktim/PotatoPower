import java.util.Queue;
class Tower implements Drawable {
  
  int _range;// maximum range to detect and shoot at an enemy
  int _reloadTime = 1;// seconds between successive shoys
  Queue<Enemy> _enemies; // enemies that towers will target 
  int angle; // angle that projectile will be launched
  
  // constructor
  public Tower() {
    _enemies = new LinkedList<Enemy>();
  }
  
  void drawObj() {
  }
  
  // checks queue to see if enemy at head is dead or out of range
  void cheque() {
    Enemy front = _enemies.peek();
    if (! front.isAlive()) 
      _enemies.remove();     
  }
  
  // detects and adds nearby enemies within range to queue
  void detect() {
  }
  
  // damages enemy at the head of the queue 
  void shoot() {
  }

}
