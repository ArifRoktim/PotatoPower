// functions similar to patches in netlogo
class Tile implements Drawable{
  
  /* int _type: The type of tile
    0: Path tile for enemies to walk on
    1: Grass tile for tower placement
    ... etc ...
  */
  int _type; // Replace with enum later
  int _xPos, _yPos; // x and y coordinates
  color _color;
  Drawable _tower;
  final int dim = 40;
  
  public Tile( int x, int y ) {
    // generic terrain
    _type = 1;
    int r, g, b;
    if( _type == 0 ){ // set color to white for path tiles
      r = g = b = 256;
    } else if( _type == 1 ){ // set color to green for grass tiles
      r = 0;
      g = 153;
      b = 0;
    } else { // set color to black for tile of unknown type
      r = g = b = 0;
    }
    _color = color (r,g,b);
    _tower = null;
    _xPos = x;
    _yPos = y;
  }

  public void drawObj(){
    _tower.drawObj();
  }




}