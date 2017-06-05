// Collideables all have circles as hitboxes
class Enemy implements Collideable {
  int _hp;
  float _xPos, _yPos; // x and y position on Map (i.e., the row and column in the 2d array of tiles)
  int _rad; // radius of the circular hitbox
  ImageStorage img;
  Tile _target; // The tile that Enemy should be moving toward
  float _d; // speed of Enemy
  /* _dx and _dy are the horizontal and vertical speed
   * they will be the product of _d and either -1 or 1 
   */
  float _dx, _dy;
  Map _map;

  Enemy( Map theMap, ImageStorage nimg) {
    _hp = 100;
    _rad = 18; // TODO: replace 20 with half the width/height of a Tile
    img = nimg;
    // the initial _xPos and _yPos are dependant on the Map
    _xPos = theMap.getStart().getX() + 0.5;
    _yPos = theMap.getStart().getY() + 0.5;
    _map = theMap;
    _d = .05;
    _target = _map.getTile((int)_xPos, (int)_yPos);
    setMovement();
  }

  boolean isAlive() {
    return _hp > 0;
  }

  public void drawObj(){ 
    ellipseMode(CORNER);
    fill(255, 0, 0);
    ellipse( _xPos * 40 - 20, _yPos * 40 - 20, _rad * 2, _rad * 2 );
    //System.out.println(printInfo());
    //System.out.println( _xPos + " " + _yPos + " " + _rad * 2 );
  }

  public void move() {
    //println("me: x:" + _xPos + " y:" + _yPos + " target: x:" + _target.getX() + " y:" + _target.getY());
    setMovement();
    _xPos += _dx;
    _yPos += _dy;
    
    if (dist(_xPos*40, _yPos*40, _target.getX()*40 + 20, _target.getY()*40 + 20) < 5) { //if you have reached target
      //print("reached target");
      
      _dx = _dy = 0;
      Tile up = _map.getUp(_target);
      Tile down = _map.getDown(_target);
      Tile left = _map.getLeft(_target);
      Tile right = _map.getRight(_target);
      
      if (up != null && up.getValue() > _target.getValue())
        _target = up;
      else if (down != null && down.getValue() > _target.getValue())
        _target = down;
      else if (left != null && left.getValue() > _target.getValue())
        _target = left;
      else if (right != null && right.getValue() > _target.getValue())
        _target = right;
    }
  }
  
  private void setMovement() {
    float deltaX = _target.getX() + 0.5 - _xPos;
    float deltaY = _target.getY() + 0.5 - _yPos;
    float h = sqrt(deltaX*deltaX + deltaY*deltaY);
    
    /*
    if (deltaX < 0.01) {
      _dy = _d*deltaY/abs(deltaY);
    }
    else if (deltaY < 0.01) {
      _dx = _d*deltaX/abs(deltaX);
    } else {
      _dx = deltaX*_d/h;
      _dy = deltaY*_d/h;
    }
    println("h: " + h);
    println("dx: " + _dx);
    println("dy: " + _dy);
    */
    
    
    if (_target.getX() + 0.5 < _xPos) {
      _dx = -1*_d;
    } else if (_target.getX() + 0.5 > _xPos) {
      _dx = _d;
    }
    if (_target.getY() + 0.5 < _yPos) {
      _dy = -1*_d;
    } else if (_target.getY() + 0.5 > _yPos) {
      _dy = _d;
    }
    
    if (_dx != 0 && _dy != 0) {
      if (deltaX > deltaY) {
        _dy = 0;
      } else {
        _dx = 0;
      }
    }
    
  }

  public boolean isColliding( Collideable other ){
    return false;
  }

  public void collide(){

  }

  public void collide(Collideable other) {

  }

  public ImageStorage getImg() {
    return img;
  }

  public float getX(){
    return _xPos;
  }
  public float getY(){
    return _yPos;
  }

  public int getWidth(){
    return _rad * 2;
  }
  public int getHeight(){
    return _rad * 2;
  }
  
  String toString() {
    String ret = "";
    ret += "X: " + _xPos;
    ret += " Y: " + _yPos;
    return ret;
  }
  
  // prints information about the surrounding tiles
   String printInfo() {
    String retVal="";
    if (_xPos+1<_map._width){
      Tile tile1= _map.getTile((int)_xPos+1 ,(int)_yPos);
      retVal+= "Right Tile- Value: " + tile1._value;
    }
    if (_xPos-1<_map._width){
      Tile tile2= _map.getTile((int)_xPos-1 ,(int)_yPos);
      retVal+= "\nLeft tile- Value: " + tile2._value;
    }
    if (_xPos+1<_map._width){
      Tile tile3= _map.getTile((int)_xPos ,(int)_yPos+1);
      retVal+= "\nBottom tile: " + tile3._value;
    }
    if (_yPos+1<_map._width){
      Tile tile4= _map.getTile((int)_xPos ,(int)_yPos-1);
      retVal+= "\nTop tile- Value: " + tile4._value;
    }
    return retVal + "\n";
  }
}