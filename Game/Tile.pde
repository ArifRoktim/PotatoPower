// functions similar to patches in netlogo
class Tile implements Drawable {
  
  /* int _type: The type of tile
    0: Path tile for enemies to walk on
    1: Grass tile for tower placement
    ... etc ...
  */
  TileType _type;
  int _xPos, _yPos; // x and y coordinates
  Drawable _tower;
  final int dim = 40;
  ImageStorage img;
  
  public Tile( int x, int y, ImageStorage nimg) {
    // generic terrain
    _type = TileType.GRASS;
    _tower = null;
    _xPos = x;
    _yPos = y;
    img = nimg;
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
  
  public void setType(TileType t) {
    _type = t;
  }

}