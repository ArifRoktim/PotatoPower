// Collideables all have circles as hitboxes
class Enemy implements Collideable {
  int _hp;
  float _xPos, _yPos; // x and y coordinates; is the top left corner of the sprite
  int _rad; // radius of the circular hitbox
  ImageStorage img;
  int _targetX, _targetY;
  int _dx, _dy;
  Map _map;

  Enemy( Map theMap, ImageStorage nimg) {
    _hp = 100;
    _rad = 20; // TODO: replace 20 with half the width/height of a Tile
    img = nimg;
    // the initial _xPos and _yPos are dependant on the Map
    _xPos = theMap._xStart;
    _yPos = theMap._yStart;
    _map = theMap;
    _dx = _dy = 10;
  }

  boolean isAlive() {
    if (_hp > 0)
      return true;
    return false;
  }

  public void drawObj(){ 
    ellipseMode(CORNER);
    ellipse( _xPos * 40, _yPos * 40, _rad * 2, _rad * 2 );
    System.out.println( _xPos + " " + _yPos + " " + _rad * 2 );
  }

  public void move(){
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
}
