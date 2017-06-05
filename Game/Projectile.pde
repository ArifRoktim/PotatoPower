class Projectile implements Collideable {
  int damage;
  float _xPos, _yPos; // x and y coordinates
  int _rad = 4;
  float _dx, _dy; // change in x and y
  float _speed, _angle;
  ImageStorage img;

  // shoots depending on angle given by tower
  Projectile( float x, float y, float _speed, float _angle, ImageStorage nimg) {
    _xPos = x;
    _yPos = y;
    _dx = (float) Math.sin(_angle) * _speed;
    _dy = (float) Math.cos(_angle) * _speed;
    img = nimg;
  }

  public void drawObj(){
    // temporary image
    
    //diagnostics:
    //System.out.println("xpos = " + _xPos + " ypos = " + _yPos);
    
    ellipseMode(CORNER);
    ellipse( _xPos*40 , _yPos*40, _rad * 2, _rad * 2 );
    fill (255,0,0);
  }

  public void move(){
    _xPos += _dx;
    _yPos += _dy;
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

  public int getHeight(){
    return 0;
  }
  public int getWidth(){
    return 0;
  }
  public boolean outOfBounds() {
    if (_xPos<40 && _xPos>-1)
      if (_yPos<40 && _yPos>-1)
       return true;
    return false;
  }
}