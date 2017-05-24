class Projectile implements Collideable {
  int damage;
  int _xPos, _yPos; // x and y coordinates
  int _dx, _dy; // change in x and y
  ImageStorage img;
  
  Projectile( int x, int y, int dx, int dy, ImageStorage nimg) {
    _xPos = x;
    _yPos = y;
    _dx = dx;
    _dy = dy;
    img = nimg;
  }
  
  public void drawObj(){
    
  }
  
  public void move(){
    _xPos += _dx;
    _yPos += _dy;
  }
  
  public void collide(){
    
  }
  
  public void collide(Collideable other) {
    
  }
  
  public ImageStorage getImg() {
    return img;
  }
}