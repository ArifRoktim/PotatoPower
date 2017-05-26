// the "driver" file
import java.util.LinkedList;
import java.util.Queue;
import java.awt.Rectangle;
import java.util.List;
import java.util.ArrayList;

Map _map;
ImageStorage img;
List<Drawable> _drawables;
QuadTree _qTree;

void setup() {
  size(600, 600); //15x15 tiles
  _qTree = new QuadTree( 0, new Rectangle( 0, 0, width, height) );
  img = new ImageStorage();
  _map = new Map(img);
  _map.mapOne();
  _drawables = new LinkedList();
  _drawables.add( _map );
}

void draw() {
  render();
  doCollisions();
  //spawn(); // need to implement Enemy.drawObj() first
}

// Clear screen and redraw every Drawable
void render(){
  background( 0 );
  for( Drawable i: _drawables ){
    i.drawObj();
  }
}

// Spawn enemy at the starting coordinates
void spawn(){
  // Spawn enemy every 5 seconds
  if (frameCount % (5 * 60) == 0){
    _drawables.add( new Enemy( _map, img ) );
  }
}

void doCollisions(){
  // Clear and repopulate QuadTree
  _qTree.clear();
  _qTree.insertCollideables( _drawables );
  List<Collideable> collideables = new LinkedList<Collideable>();
  for( Drawable i: _drawables ){
    // Do collisions from the perspective of the enemy
    if( i instanceof Enemy ){
      collideables.clear();
      _qTree.retrieve( collideables, (Collideable) i );

      for( Collideable j: collideables ){
        // run actual collision detection algorithm
      }

    }
  }
}

void mouseClicked() {
  int x = mouseX / 40;
  int y = mouseY / 40;
  if (_map.getTile(x, y).getTower() == null) {
    _map.addTower(x, y);
    print("Added tower");
  }
}