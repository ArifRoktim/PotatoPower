// functions similar to patches in netlogo
class Tile implements Drawable {
  
  TileType _type; // can be either PATH or GRASS
  int _xPos, _yPos, _value; // x and y coordinates
  Drawable _tower;
  final int dim = 40;
  ImageStorage img;
  
  // allows access to dim by outside classes (don't delete
  Tile(){
  }
  
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
        image(img.grass(), _xPos*dim, _yPos*dim);
         text(String.valueOf(_value), _xPos*dim + (.5 * dim), _yPos*dim + ( .5 * dim));
        break;
      case PATH:
        image(img.path(),  _xPos*dim, _yPos*dim);
         text(String.valueOf(_value), _xPos*dim + (.5 * dim), _yPos*dim + ( .5 * dim));
        break;
    }
  }
  
  public ImageStorage getImg() {
    return img;
  }
  
  void setType(TileType t) {
    _type = t;
  }
  
  void addTower( Tower tower ) {
    _tower = tower;
  }
  
  Drawable getTower() {
    return _tower;
  }

  boolean towerPlaceable(){
    return _type == TileType.GRASS && getTower() == null;
  }
  
  int getX() {
    return _xPos;
  }
  
  int getY() {
    return _yPos;
  }

}