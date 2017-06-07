class Tower implements Collideable {

  float _range;// maximum range to detect and shoot at an enemy
  float _xPos, _yPos;
  int _width, _height; // x-y coordinates, and dimensions for the hitbox
  float _reloadTime;// seconds between successive shots
  Queue<Enemy> _enemies; // enemies that towers will target 
  float _angle; // angle that projectile will be launched
  double _speed;
  float _atk;
  boolean showRange;
  ImageStorage img;
  int atkUpgradeCost, rangeUpgradeCost, reloadUpgradeCost;
  final int dim = 40;
  boolean active;

  public Tower ( float x, float y, ImageStorage nimg ) {
    _range = 3;
    _xPos = x;
    _yPos = y;
    _width = _height = 40;
    _reloadTime = 1;
    _speed = 0.2;
    _enemies = new LinkedList<Enemy>();
    _angle = 0;
    _atk = 5;
    img = nimg;
    showRange = false;
    active = false;
    atkUpgradeCost = rangeUpgradeCost = reloadUpgradeCost = 10;
  }

  public void drawObj() {
    image(img.tower(), _xPos*dim - 20, _yPos*dim - 20, dim, dim);
    pushMatrix();
    translate(_xPos*dim, _yPos*dim );
    rotate(_angle);
    image(img.turret(), -dim/2, -dim/2, dim, dim);
    popMatrix();
    Enemy t = _enemies.peek();

    //draw range
    fill( 0, 0, 0, 50 );
    ellipseMode( CENTER );
    if (showRange) {
      ellipse( _xPos*40, _yPos*40, _range*40*2, _range*40*2);
    }
  }

  // checks queue to see if enemy at head is dead or out of range
  void cheque() {
    if (_enemies.isEmpty()) {
      //println("no enemies to check");
      return;
    }
    //println("checking");
    Enemy front = _enemies.peek();
    while (front != null && (!isColliding(front) || !front.isAlive())) { //enemy is out of range
      _enemies.remove();
      front = _enemies.peek();
    }
  }

  // makes towers launch projectile
  Projectile shoot() {
    if (_enemies.isEmpty())
      return null;
    aim();
    return new Projectile (_xPos, _yPos, _speed, _atk, _angle, img);
  }

  void aim() {
    cheque();
    if (_enemies.isEmpty())
      return;
    //System.out.println("TOWER SHOOTS");
    Enemy target = _enemies.peek();
    float deltaX = target.getX() - _xPos;
    float deltaY = target.getY() - _yPos;
    if (deltaX > 0 && deltaY > 0) { //first quadrant
      _angle = atan(deltaY/deltaX);
    } else if (deltaX < 0 && deltaY > 0) { //second quadrant
      _angle = atan(deltaY/deltaX) + PI;
    } else if (deltaX < 0 && deltaY < 0) { //third quadrant
      _angle = atan(deltaY/deltaX) + PI;
    } else if (deltaX > 0 && deltaY < 0) { //fourth quadrant
      _angle = atan(deltaY/deltaX);
    }

    if (_angle < 0) {
      _angle += 2*PI;
    }
    //println("angle: " + _angle);
  }

  /* detects and adds nearby enemies within range to queue 
   * works by giving towers a large hitbox and detecting if an enemy collides with this hitbox
   * If so, the enemy is added to the tower's queue of enemies
   */
  void detect() {
    // List storing Collideables that could collide with a given Collideable
    List<Collideable> possible = new LinkedList<Collideable>();
    _qTree.retrieve( possible, this );

    for (Collideable e : possible) {
      if (e instanceof Enemy && !_enemies.contains(e) && isColliding(e)) {
        _enemies.add( (Enemy) e);
      }
    }
    //if (mousePressed)
    //println(possible + " " + _enemies);

    /*
    // Run actual collision detection algorithm
    for ( Collideable i : possible ) {
    if( isColliding( i ) ){
    System.out.println( i );
    }
    }
     */

  }

  public ImageStorage getImg() {
    return img;
  }

  public boolean isColliding( Collideable other ) {
    float x1 = _xPos*40;
    float y1 = _yPos*40;
    float x2 = other.getX()*40;
    float y2 = other.getY()*40;
    float r1 = _range*40;
    float r2 = other.getWidth()/2;
    return dist(x1, y1, x2, y2) <= r1 + r2;
  }

  void increaseAttack() {
    _atk += 2;
    atkUpgradeCost += 10;
  }

  void increaseRange() {
    _range += 0.5;
    rangeUpgradeCost += 10;
  }

  void increaseReload() {
    if (_reloadTime > 0.1) {
      _reloadTime -= 0.1;
      reloadUpgradeCost += 10;
    }
  }

  int getAtkCost() {
    return atkUpgradeCost;
  }

  int getRangeCost() {
    return rangeUpgradeCost;
  }

  int getReloadCost() {
    return reloadUpgradeCost;
  }

  public void collide( Collideable other){

  }

  public void collide(){ //needed?

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

  public float getRange() {
    return _range;
  }

  public void setShowRange(boolean s) {
    showRange = s;
  }
}
