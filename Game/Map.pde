// contorls display of Drawables in the processing window
// further details and application must still be worked out before changing Game to accommodate this class
public class Map implements Drawable {
  Tile [][] _map;
  int _width;
  int _height;
  int _xStart;
  int _yStart;
  int _xEnd;
  int _yEnd;
  ImageStorage img;

  public Map(ImageStorage nimg) {
    _width = width;
    _height = height;
    int length = idealSquare();
    img = nimg;
    _map = new Tile [_width/length][_height/length];
    for (int x = 0; x < _map.length; x++)
      for (int y = 0; y < _map.length; y++)
        _map[y][x] = new Tile(x*40, y*40,-1,img);
  }

  // Maps: 
  void mapOne() {
    placePath(14, 7, 1);
    placePath(13, 7, 2);
    placePath(12, 7, 3);
    placePath(11, 7, 4);
    placePath(10, 7, 5);
    placePath(9, 7, 6);
    placePath(8, 7, 7);
    placePath(7, 7, 8);
    placePath(7, 8, 9);
    placePath(7, 9, 10);
    placePath(7, 10, 11);
    placePath(7, 11, 12);
    placePath(7, 12, 13);
    placePath(7, 13, 14);
    placePath(7, 14, 15);
    _xStart = 7;
    _yStart = 14;
  }

  public void drawObj() {
    for (Tile[] row : _map)
      for (Tile t : row)
        t.drawObj();
  }

  // finds the dimensions of the largest square tile possible given the dimensions of the processing window
  int idealSquare() { 
    double product = _width * _height;
    int num;
    if (_width > _height)
      num = (_width/2); // prevents return value from being too large
    else
      num = (_height/2);
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
  void placePath(int x, int y, int val) {
    _map[y][x].setType(TileType.PATH);
    _map[y][x].setValue(val);
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
  
  void addTower(int x, int y) {
    _map[y][x].addTower();
  }
  
  Tile getTile(int x, int y) {
    return _map[x][y]; //same as addTower
  }
}
