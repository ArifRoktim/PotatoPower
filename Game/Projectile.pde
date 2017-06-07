class Projectile implements Collideable {
  float damage;
  float _xPos, _yPos; // x and y coordinates
  int _rad = 4;
  double _dx, _dy; // change in x and y
  float _speed, _angle;
  ImageStorage img;

  // shoots depending on angle given by tower
  Projectile( float x, float y, double _speed, float dmg, float _angle, ImageStorage nimg) {
    _xPos = x;
    _yPos = y;
    _dx = cos(_angle) * _speed;
    _dy = sin(_angle) * _speed;
    img = nimg;
    damage = dmg;
  }

  public void drawObj(){
    //diagnostics:
    //System.out.println("xpos = " + _xPos + " ypos = " + _yPos);

    fill (0);
    ellipseMode(CENTER);
    ellipse( _xPos*40 , _yPos*40, _rad * 2, _rad * 2 );
  }

  public void move(){
    _xPos += _dx;
    _yPos += _dy;
  }

  //unused
  public boolean isColliding( Collideable other ){
    return false;
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
    return _rad * 2;
  }
  public int getWidth(){
    return _rad * 2;
  }
  public boolean outOfBounds() {
    return _xPos < 0 || _xPos > 15 || _xPos < 0 || _xPos > 15;
  }
}
