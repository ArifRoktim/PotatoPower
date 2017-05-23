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
      image(img.path(), t._xPos, t._yPos, 40, 40);
}