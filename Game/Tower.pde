class Tower implements Drawable {
  
  int _range;// maximum range to detect and shoot at an enemy
  int _xPos, _yPos; // x and y coordinates
  int _reloadTime;// seconds between successive shoys
  Queue<Enemy> _enemies; // enemies that towers will target 
  int _angle; // angle that projectile will be launched
  ImageStorage img;
  
  public Tower( int x, int y, ImageStorage nimg ) {
    _range = 5;
    _xPos = x;
    _yPos = y;
    _reloadTime = 1;
    _enemies = new LinkedList<Enemy>();
    _angle = 0;
    img = nimg;
  }
  
  public void drawObj() {
    
  }
  
  // checks queue to see if enemy at head is dead or out of range
  void cheque() {
    Enemy front = _enemies.peek();
    if (! front.isAlive()) 
      _enemies.remove();     
    /* ================== TODO ==================
      ADD CHECK TO SEE IF ENEMY IS OUT OF RANGE
    */
  }
  
  // detects and adds nearby enemies within range to queue
  void detect() {
  }
  
  // damages enemy at the head of the queue 
  void shoot() {
  }
  
  public ImageStorage getImg() {
    return img;
  }

}