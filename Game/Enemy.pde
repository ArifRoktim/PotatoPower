// Collideables all have circles as hitboxes
class Enemy implements Collideable {
  int _hp;
  int _xPos, _yPos; // x and y coordinates; is the top left corner of the sprite
  int _rad; // radius of the circular hitbox
  ImageStorage img;

  Enemy( Map theMap, ImageStorage nimg) {
    _hp = 100;
    img = nimg;
    // the initial _xPos and _yPos are dependant on the Map
    _xPos = theMap._xStart;
    _yPos = theMap._yStart;
  }

  boolean isAlive() {
    if (_hp > 0)
      return true;
    return false;
  }

  public void drawObj(){ 
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

  public int getX(){
    return _xPos;
  }
  public int getY(){
    return _yPos;
  }

  public int getWidth(){
    return _rad * 2;
  }
  public int getHeight(){
    return _rad * 2;
  }
}
