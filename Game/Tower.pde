class Tower implements Collideable {
  
  int _range;// maximum range to detect and shoot at an enemy
  int _xPos, _yPos, _width, _height; // x-y coordinates, and dimensions for the hitbox
  int _reloadTime;// seconds between successive shots
  Queue<Enemy> _enemies; // enemies that towers will target 
  float _angle; // angle that projectile will be launched
  float _speed;
  ImageStorage img;
  final int dim = 40;
  
  public Tower ( int x, int y, ImageStorage nimg ) {
    _range = 5;
    _xPos = x;
    _yPos = y;
    _width = _height = 40;
    _reloadTime = 1;
    _speed = 5;
    _enemies = new LinkedList<Enemy>();
    _angle = 0;
    img = nimg;
  }
  
  public void drawObj() {
    image(img.tower(), _xPos*dim, _yPos*dim, dim, dim);
    pushMatrix();
    translate(_xPos*dim + dim/2, _yPos*dim + dim/2);
    rotate(_angle);
    image(img.turret(), -dim/2, -dim/2, dim, dim);
    popMatrix();
  }
  
  // checks queue to see if enemy at head is dead or out of range
  void cheque() {
    Enemy front = _enemies.peek();
    if (! front.isAlive()) 
      _enemies.remove();
    
    while (isColliding(front)) { //enemy is out of range
      _enemies.remove();
      front = _enemies.peek();
    }
  }
  
  // makes towers launch projectile
  Projectile shoot() {
    if (_enemies.isEmpty())
      return null;
    //System.out.println("TOWER SHOOTS");
    Enemy target = _enemies.peek();
    float deltaX = target.getX();
    float deltaY = target.getY();
    _angle = acos(deltaX/deltaY);
    return new Projectile (_xPos + 0.5, _yPos + 0.5, _speed, _angle, img);
  }
  
  /* detects and adds nearby enemies within range to queue 
   * works by giving towers a large hitbox and detecting if an enemy collides with this hitbox
   * If so, the enemy is added to the tower's queue of enemies
   */
  void detect() {
    // List storing Collideables that could collide with a given Collideable
    List<Collideable> possible = new LinkedList<Collideable>();

    for ( Tower tower : _towers ) {
      // Populate list with all Collideables that tower can collide with
      possible.clear();
      _qTree.retrieve( possible, (Collideable) tower );

      // Run actual collision detection algorithm
      for ( Collideable i : possible ) {
        if( tower.isColliding( i ) ){
          //
        }
      }
    }

  }
  
  public ImageStorage getImg() {
    return img;
  }
  
  public boolean isColliding( Collideable other ) {
    float x1 = _xPos*40;
    float y1 = _xPos*40;
    float x2 = other.getX()*40;
    float y2 = other.getY()*40;
    float r1 = _width/2;
    float r2 = other.getWidth()/2;
    return dist(x1, y1, x2, y2) <= r1 + r2;
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