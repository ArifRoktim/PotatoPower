// contorls display of Drawables in the processing window
// further details and application must still be worked out before changing Game to accommodate this class
public class Map implements Drawable {
  Tile [][] _map;
  int _width;
  int _height;
  ImageStorage img;
  Tile _start, _end;

  public Map(ImageStorage nimg) {
    img = nimg;
    int length = idealSquare();
      Tile example = new Tile();
    _width = width/example.dim; // number of columns
    _height = height/example.dim; // number of rows
    _map = new Tile [_height][_width];
    for (int x = 0; x < _map.length; x++)
      for (int y = 0; y < _map.length; y++)
        _map[y][x] = new Tile(x, y, -1,img);
    _start = _end = null;
  }

  // Maps: 
  void mapOne() {
    placePath(14, 7);
    placePath(13, 7);
    placePath(12, 7);
    placePath(11, 7);
    placePath(10, 7);
    placePath(9, 7);
    placePath(8, 7);
    placePath(7, 7);
    placePath(7, 8);
    placePath(7, 9);
    placePath(7, 10);
    placePath(7, 11);
    placePath(7, 12);
    placePath(7, 13);
    placePath(7, 14);
    _start = _map[7][14];
    setValues();
  }
  
  private void setValues() {
    int currentVal = 1;
    Tile currentTile = _start;
    while (currentTile != _end) {
      Tile up = getUp(currentTile);
      Tile down = getDown(currentTile);
      Tile left = getLeft(currentTile);
      Tile right = getRight(currentTile);
      
      if (up != null && up.getValue() == 0) {
        currentTile = up;
        currentTile.setValue(currentVal);
      } else if (down != null && down.getValue() == 0) {
        currentTile = down;
        currentTile.setValue(currentVal);
      } else if (left != null && left.getValue() == 0) {
        currentTile = left;
        currentTile.setValue(currentVal);
      } else if (right != null && right.getValue() == 0) {
        currentTile = right;
        currentTile.setValue(currentVal);
      }
      currentVal++;
    }
    _end.setValue(currentVal);
  }

  public void drawObj() {
    for (Tile[] row : _map)
      for (Tile t : row)
        t.drawObj();
  }

  // finds the dimensions of the largest square tile possible given the dimensions of the processing window
  int idealSquare() { 
    double product = width * height;
    int num;
    if (width > height)
      num = (width/2); // prevents return value from being too large
    else
      num = (height/2);
    boolean solved = false; // prevents return value from being too large
    while (!solved) {
      double divis = ((double)product/((double)(Math.pow(num, 2)))); // returns area divided squared number
      if (divis == Math.round(divis)) {
        return ((int) divis);
      }
      num--;
    }
    return 1;
  }

  // places path on the designated tile (row number, column number)
  void placePath(int x, int y) {
    _map[y][x].setType(TileType.PATH);
    _map[y][x].setValue(0);
    _end = _map[y][x];
  }

  // places grass on the designated tile (row number, column number)
  void placeGrass(int x, int y) {
    _map[y][x].setType(TileType.GRASS);
  }

  // places tower on the designated tile (row number, column number)
  void placeTower(int x, int y) {
    ImageStorage img = new ImageStorage();
    image(img.tower(), x*40, y*40, 40, 40);
  }
  
  public ImageStorage getImg() {
    return img;
  }
  
  Tile getTile(int x, int y) {
    return _map[y][x];
  }
  
  Tile getLeft(Tile t) {
    if (t.getX() - 1 < 0)
      return null;
    return _map[t.getY()][t.getX() - 1];
  }
  
  Tile getRight(Tile t) {
    if (t.getX() + 1 > 14)
      return null;
    return _map[t.getY()][t.getX() + 1];
  }
  
  Tile getUp(Tile t) {
    if (t.getY() - 1 < 0)
      return null;
    return _map[t.getY() - 1][t.getX()];
  }
  
  Tile getDown(Tile t) {
    if (t.getY() + 1 > 14)
      return null;
    return _map[t.getY() + 1][t.getX()];
  }
  
  Tile getStart() {
    return _start;
  }
  
  Tile getEnd() {
    return _end;
  }
}