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
  spawn();
  for( Drawable i: _drawables ){
    if( i instanceof Enemy ){
      ((Enemy) i).move();
    }
  }
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
    //System.out.println( frameCount );
    _drawables.add( new Enemy( _map, img ) );
  }
}

void doCollisions(){
  // Clear and repopulate QuadTree
  _qTree.clear();
  _qTree.insertCollideables( _drawables );
  List<Collideable> collideables = new LinkedList<Collideable>();
  // Do collisions from the perspective of the enemy
  for( Drawable i: _drawables ){
    if( i instanceof Enemy ){
      // Populate collideables with every Collideable that Enemy i could collide with
      collideables.clear();
      _qTree.retrieve( collideables, (Collideable) i );

      // Run actual collision detection algorithm between Enemy i and the collideables
      for( Collideable j: collideables ){
        //
      }

    }
  }
}

void mouseClicked() {
  int x = mouseX / 40;
  int y = mouseY / 40;
  if ( _map.getTile(x, y).towerPlaceable() ) {
    // TODO: Make tile take a tower object as an arguement
    // so that we can add the tower object to _drawables
    Tower newTower = new Tower( x * 40, y * 40, img );
    _map.getTile( x, y ).addTower( newTower );
    _drawables.add( newTower );
    println("Added tower");
  }
}
