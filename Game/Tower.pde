class Tower implements Collideable {
  
  int _range;// maximum range to detect and shoot at an enemy
  int _xPos, _yPos,_width,_height; // x-y coordinates, and dimensions for the hitbox
  int _reloadTime;// seconds between successive shots
  Queue<Enemy> _enemies; // enemies that towers will target 
  float _angle; // angle that projectile will be launched
  ImageStorage img;
  final int dim = 40;
  
  public Tower ( int x, int y, ImageStorage nimg ) {
    _range = 5;
    _xPos = x;
    _yPos = y;
    _reloadTime = 1;
    _enemies = new LinkedList<Enemy>();
    _angle = 0;
    img = nimg;
  }
  
  public void drawObj() {
    image(img.tower(), _xPos, _yPos, dim, dim);
    pushMatrix();
    translate(_xPos + dim/2, _yPos + dim/2);
    rotate(_angle);
    image(img.turret(), -dim/2, -dim/2, dim, dim);
    popMatrix();
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
  
  public void collide( Collideable other){
  
  }

  public void collide(){ //needed?

  }
  
  // movement for the projectiles
  public void move(){
    
  }

  public float getX(){
    return _xPos;
  }
  
  public float getY(){
    return _yPos;
  }

  public int getWidth(){ 
    return _width;
  }
  
  public int getHeight(){
    return _height;
  }

}
