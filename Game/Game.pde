// the "driver" file
import java.util.LinkedList;
import java.util.Queue;
import java.awt.Rectangle;
import java.util.List;
import java.util.ArrayList;
import java.util.ArrayDeque;
import java.util.Deque;

Map _map;
ImageStorage img;
List<Enemy> enemies;
List<Projectile> projectiles;
List<Tower> towers;
QuadTree _qTree;
Deque<Enemy> enemyQueue;
int lives;

void setup() {
  size(600, 600); //15x15 tiles
  _qTree = new QuadTree( 0, new Rectangle( 0, 0, width, height) );
  img = new ImageStorage();
  _map = new Map(img);
  _map.mapOne();
  enemies = new LinkedList();
  projectiles = new LinkedList();
  towers = new LinkedList();
  lives = 10;
  enemyQueue = new ArrayDeque<Enemy>();
  for (int i = 0; i < 10; i++)
    enemyQueue.add(new Enemy(_map, img));
  textSize(24);
  fill(255, 0, 0);
  noStroke();
}

void draw() {
  spawn();
  
  // COMMENTED OUT TEMPORARILY
 // doCollisions();
  
  for ( Enemy e : enemies ) {
    e.move();
  }
  for (Projectile p : projectiles) {
    p.move();
  }
  //TODO: if enemy reaches end, decrease lives
  if (!enemies.isEmpty()) {
    Enemy first = enemies.get(0);
    if (dist(first.getX()*40, first.getY()*40, _map.getEnd().getX()*40, _map.getEnd().getY()*40) < 5) { //if enemy have reached end
      enemies.remove(first);
      lives--;
    }
  }
  
  // PROJECTILE SHOT EVERY RELOAD TIME
  for (Tower x: towers) {
    if ((frameCount%(x._reloadTime*60)) == 0) {
      projectiles.add(x.shoot(.05,60));
    }
  }
  // TO DO: remove projectiles out of range, center projectiles at time of launch
  render();
}

// Clear screen and redraw every Drawable
void render() {
  background( 0 );
  _map.drawObj();
  for ( Enemy e : enemies ) {
    e.drawObj();
  }
  for ( Projectile p : projectiles ) {
    p.drawObj();
  }
  for ( Tower t: towers) {
    t.drawObj();
  }
  text("Lives: " + lives, 20, 40);
}

// Spawn enemy at the starting coordinates
void spawn() {
  // Spawn enemy every 2 seconds
  if (frameCount % (2 * 60) == 0 && !enemyQueue.isEmpty()) {
    //System.out.println( frameCount );
    enemies.add( enemyQueue.remove() );
  }
}

void doCollisions() {
  // Clear and repopulate QuadTree
  _qTree.clear();
  _qTree.insertCollideables( enemies );
  _qTree.insertCollideables( projectiles );
  List<Collideable> collideables = new LinkedList<Collideable>();
  // Do collisions from the perspective of the enemy
  for ( Enemy i : enemies ) {
    // Populate collideables with every Collideable that Enemy i could collide with
    collideables.clear();
    _qTree.retrieve( collideables, (Collideable) i );

    // Run actual collision detection algorithm between Enemy i and the collideables
    for ( Collideable j : collideables ) {
      //
    }
  }
}

void mouseClicked() {
  int x = mouseX / 40;
  int y = mouseY / 40;
  if ( _map.getTile(x, y).towerPlaceable() ) {
    // TODO: Make tile take a tower object as an arguement
    // so that we can add the tower object to _drawables
    Tower newTower = new Tower( x, y, img );
    towers.add(newTower);
    _map.getTile( x, y ).addTower( newTower );
    println("Added tower");
  }
}