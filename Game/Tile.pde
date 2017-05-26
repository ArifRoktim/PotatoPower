// functions similar to patches in netlogo
class Tile implements Drawable {
  
  /* int _type: The type of tile
    0: Path tile for enemies to walk on
    1: Grass tile for tower placement
    ... etc ...
  */
  TileType _type;
  int _xPos, _yPos,_value; // x and y coordinates
  Drawable _tower;
  final int dim = 40;
  ImageStorage img;
  
  Tile( int x, int y, int value, ImageStorage nimg) {
    // generic terrain
    _value = value;
    _type = TileType.GRASS;
    _tower = null;
    _xPos = x;
    _yPos = y;
    img = nimg;
  }
  
  int getValue() {
    return _value;
  }
  
  int setValue(int target) {
    _value = target;
    return _value;
  }

  public void drawObj(){
    switch(_type) {
      case GRASS:
        image(img.grass(), _xPos, _yPos);
        if (_tower != null)
          _tower.drawObj();
        break;
      case PATH:
        image(img.path(),  _xPos, _yPos);
        break;
    }
  }
  
  public ImageStorage getImg() {
    return img;
  }
  
  void setType(TileType t) {
    _type = t;
  }
  
  void addTower() {
    _tower = new Tower(_xPos, _yPos, img);
  }
  
  Drawable getTower() {
    return _tower;
  }

}