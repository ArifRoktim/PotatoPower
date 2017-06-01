// the "driver" file
import java.util.LinkedList;
import java.util.Queue;
import java.awt.Rectangle;
import java.util.List;
import java.util.ArrayList;
import java.util.ArrayDeque;
import java.util.Deque;

Map _map;
ImageStorage _img;
List<Enemy> _enemies;
List<Projectile> _projectiles;
List<Tower> _towers;
QuadTree _qTree;
Deque<Enemy> _enemyQueue;
int lives;

void setup() {
  size(600, 600); //15x15 tiles
  _qTree = new QuadTree( 0, new Rectangle( 0, 0, width, height) );
  _img = new ImageStorage();
  _map = new Map(_img);
  _map.mapOne();
  _enemies = new LinkedList();
  _projectiles = new LinkedList();
  _towers = new LinkedList();
  lives = 10;
  _enemyQueue = new ArrayDeque<Enemy>();
  for (int i = 0; i < 10; i++)
    _enemyQueue.add(new Enemy(_map, _img));
  textSize(24);
  fill(255, 0, 0);
  noStroke();
}

void draw() {
  spawn();
  
  // COMMENTED OUT TEMPORARILY
 // doCollisions();
  
  for ( Enemy e : _enemies ) {
    e.move();
  }
  for (Projectile p : _projectiles) {
    p.move();
  }
  //TODO: if enemy reaches end, decrease lives
  if (!_enemies.isEmpty()) {
    Enemy first = _enemies.get(0);
    if (dist(first.getX()*40, first.getY()*40, _map.getEnd().getX()*40, _map.getEnd().getY()*40) < 5) { //if enemy have reached end
      _enemies.remove(first);
      lives--;
    }
  }
  
  // PROJECTILE SHOT EVERY RELOAD TIME
  for (Tower x: _towers) {
    if ((frameCount%(x._reloadTime*60)) == 0) {
      Projectile p = x.shoot();
      if (p != null)
        _projectiles.add(p);
    }
  }
  // TO DO: remove _projectiles out of range, center _projectiles at time of launch
  render();
}

// Clear screen and redraw every Drawable
void render() {
  background( 0 );
  _map.drawObj();
  for ( Enemy e : _enemies ) {
    e.drawObj();
  }
  for ( Projectile p : _projectiles ) {
    p.drawObj();
  }
  for ( Tower t: _towers) {
    t.drawObj();
  }
  text("Lives: " + lives, 20, 40);
}

// Spawn enemy at the starting coordinates
void spawn() {
  // Spawn enemy every 2 seconds
  if (frameCount % (2 * 60) == 0 && !_enemyQueue.isEmpty()) {
    //System.out.println( frameCount );
    _enemies.add( _enemyQueue.remove() );
  }
}

void doCollisions() {
  // Clear and repopulate QuadTree
  _qTree.clear();
  _qTree.insertCollideables( _enemies );
  _qTree.insertCollideables( _projectiles );

  List<Collideable> possible = new LinkedList<Collideable>();
  // Do collisions for projectiles
  for ( Projectile projectile : _projectiles ) {
    // Populate list with all Collideables projectile can collide with
    possible.clear();
    _qTree.retrieve( possible, (Collideable) projectile );

    // Run actual collision detection algorithm for projectiles
    for ( Collideable i : possible ) {
      if( projectile.isColliding( i ) ){
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
    Tower newTower = new Tower( x, y, _img );
    _towers.add(newTower);
    _map.getTile( x, y ).addTower( newTower );
    println("Added tower");
  }
}