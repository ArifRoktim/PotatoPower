class Enemy implements Collideable {
  int _hp;
  int _xPos, _yPos; // x and y coordinates
  int _width, _height;
  ImageStorage img;

  Enemy(ImageStorage nimg) {
    _hp = 100;
    img = nimg;
    // the initial _xPos and _yPos are dependant on the Map
    // Gotta make the Map class first
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
    return _width;
  }
  public int getHeight(){
    return _height;
  }
}
