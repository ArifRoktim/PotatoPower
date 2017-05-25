// the "driver" file
import java.util.LinkedList;
import java.util.Queue;
import java.awt.Rectangle;
import java.util.List;
import java.util.ArrayList;

Map _map;
ImageStorage img;
List<Drawable> _drawables;

void setup() {
  size(600, 600); //15x15 tiles
  img = new ImageStorage();
  _map = new Map(img);
  _map.mapOne();
  _drawables = new LinkedList();
  _drawables.add( _map );
}

void draw() {
  render();
}

void render(){
  for( Drawable i: _drawables ){
    i.drawObj();
  }
}

