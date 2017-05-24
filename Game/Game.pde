// the "driver" file
import java.util.LinkedList;
import java.util.Queue;

Tile[][] _map;

void setup() {
  size(600, 600); //15x15 tiles
  _map = new Tile[15][15];
  for (int i = 0; i < _map.length; i++)
    for (int j = 0; j < _map.length; j++)
      _map[j][i] = new Tile(j*40, i*40);
  
}

void draw() {
  ImageStorage img = new ImageStorage();
  for (Tile[] row : _map)
    for (Tile t : row)
      image(img.grass(), t._xPos, t._yPos, 40, 40);
  mapOne();
}

// harcoded default map; precursor to the implementation of a map class
void mapOne(){
  placePath(14,7);
  placePath(13,7);
  placePath(12,7);
  placePath(11,7);
  placePath(10,7);
  placePath(9,7);
  placePath(8,7);
  placePath(7,7);
  placePath(7,8);
  placePath(7,9);
  placePath(7,10);
  placePath(7,11);
  placePath(7,12);
  placePath(7,13);
  placePath(7,14);
}

// places path on the designated tile (row number, column number)
void placePath(int y, int x){
  ImageStorage img = new ImageStorage();
  image(img.path(),x*40,y*40,40,40);
}

// places grass on the designated tile (row number, column number)
void placeGrass(int y, int x){
  ImageStorage img = new ImageStorage();
  image(img.grass(),x*40,y*40,40,40);
}

// places tower on the designated tile (row number, column number)
void placeTower(int y, int x){
  ImageStorage img = new ImageStorage();
  image(img.tower(),x*40,y*40,40,40);
}