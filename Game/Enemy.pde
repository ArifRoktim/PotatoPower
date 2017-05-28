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
    _rad = 20; // TODO: replace 20 with half the width/height of a Tile
    img = nimg;
    // the initial _xPos and _yPos are dependant on the Map
    _xPos = theMap._xStart;
    _yPos = theMap._yStart;
    _map = theMap;
    _d = .1;
  }

  boolean isAlive() {
    return _hp > 0;
  }

  public void drawObj(){ 
    ellipseMode(CORNER);
    ellipse( _xPos * 40, _yPos * 40, _rad * 2, _rad * 2 );
    //System.out.println( _xPos + " " + _yPos + " " + _rad * 2 );
  }

  public void move(){
    if( _target == null ){
      _dx = _dy = 0;
      System.out.println( "Info Update:\nTarget is null" );
      System.out.println(printInfo());
      int myValue = _map.getTile( (int) _xPos, (int) _yPos )._value; // value of tile that im on
      List<Tile> tiles = new ArrayList<Tile>(4);
      // Add tiles that have greater value than current tile to list
      if( (int) _xPos + 1 > _map._width &&
          _map.getTile( (int) _xPos + 1, (int) _yPos )._value > myValue )
        tiles.add( _map.getTile( (int) _xPos + 1, (int) _yPos ) );
      if( (int) _xPos - 1 > 0 &&
          _map.getTile( (int) _xPos - 1, (int) _yPos )._value > myValue )
        tiles.add( _map.getTile( (int) _xPos - 1, (int) _yPos ) );
      if( (int) _yPos + 1 > _map._height &&
          _map.getTile( (int) _yPos + 1, (int) _yPos )._value > myValue )
        tiles.add( _map.getTile( (int) _yPos + 1, (int) _yPos ) );
      if( (int) _yPos - 1 > 0 &&
          _map.getTile( (int) _yPos - 1, (int) _yPos )._value > myValue )
        tiles.add( _map.getTile( (int) _yPos - 1, (int) _yPos ) );
      // TODO: Case where dead end is reached
      if( tiles.size() == 0 ){
        delay( 15000 );
        exit();
        return;
      }
      // Choose a random target
      _target = tiles.get( (int) (Math.random() * tiles.size()) );
      // Set speeds
      _dx = _d *  Math.signum( _target._xPos / 40 - _xPos );
      _dy = _d *  Math.signum( _target._yPos / 40 - _yPos );
      System.out.println( "_xPos, _yPos: " + _xPos + ", " + _yPos );
      System.out.println( "_dx, _dy: " + _dx + ", " + _dy );
    } else {
      /*
      System.out.println();
      System.out.println( "Target: " + _target._value );
      System.out.println( "My tile: " + _map.getTile( (int) _xPos, (int) _yPos )._value );
      */
      // Move accordingly
      /*
      System.out.println( "_xPos, _yPos: " + _xPos + ", " + _yPos );
      System.out.println( "_dx, _dy: " + _dx + ", " + _dy );
      */
      _xPos += _dx; _yPos += _dy;
      if( (int) _xPos == _target._xPos / 40 && (int) _yPos == _target._yPos / 40 ){
        _target = null;
        // Round off x and y pos
        //_xPos = (int) _xPos;
        //_yPos = (int) _yPos;
      }
    }

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
    return retVal;
  }
}