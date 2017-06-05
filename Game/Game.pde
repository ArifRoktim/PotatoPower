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
gameState status;
int lives;
boolean running;
PImage menu;
PImage loss;

void setup() {
  status = gameState.TITLE;
  delay(1000);
  size(600, 600); //15x15 tiles
  menu = loadImage("title.jpg");
  loss = loadImage("loser.jpg");
  image(menu,0,0,width,height);
  titleScreen();
  _qTree = new QuadTree( 0, new Rectangle( 0, 0, width, height) );
  _img = new ImageStorage();
  _map = new Map(_img);
  _map.mapOne();
  _enemies = new LinkedList();
  _projectiles = new LinkedList();
  _towers = new LinkedList();
  lives = 10;
  _enemyQueue = new ArrayDeque<Enemy>();
  for (int i = 0; i < 50; i++)
    _enemyQueue.add(new Enemy(_map, _img));
  textSize(24);
  fill(255, 0, 0);
  noStroke();
  //speedup for development
  frameRate(120);
}

void draw() {
  if (status == gameState.TITLE){
  }
  else if (status == gameState.GAMEPLAY) {
  spawn();
  
  for ( Enemy e : _enemies ) {
    e.move();
  }
  for (Projectile p : _projectiles) {
    p.move();
  }
  
  // Add all Collideables to the quadtree
  doCollisions();
  
  //if enemy reaches end, decrease lives
  if (!_enemies.isEmpty()) {
    Enemy first = _enemies.get(0);
    if (dist(first.getX()*40, first.getY()*40, _map.getEnd().getX()*40 + 20, _map.getEnd().getY()*40 + 20) < 5) {
      _enemies.remove(first);
      lives--;
    }
  }
  
  for (int i = _projectiles.size() - 1; i > -1; i--) {
     if (_projectiles.get(i).outOfBounds()){
       Projectile p = _projectiles.get(i);
       //println("removed projectile: " + p.getX() + ", " + p.getY());
       _projectiles.remove(i);
     }
  }
  
  // PROJECTILE SHOT EVERY RELOAD TIME
  for (Tower x: _towers) {
    x.detect();
    x.aim();
    if ((frameCount % (int)(x._reloadTime*60)) == 0) {
      Projectile p = x.shoot();
      if (p != null) {
        _projectiles.add(p);
        println("dx: " + p._dx + " dy: " + p._dy);
      }
    }
  }
  
  render();
  if (lives <= 0) {
    status = gameState.END;
  }
  }
  else if (status == gameState.END) {
    endScreen();
  }
}

// Clear screen and redraw every Drawable
void render() {
  background( 0 );
  _map.drawObj();
  for ( Enemy e : _enemies ) {
    e.drawObj();
  }
  for (Projectile p : _projectiles) {
    p.drawObj();
  }
  for (Tower t : _towers) {
    t.drawObj();
  }
  fill(0);
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

  /*
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
  */

}

void mouseClicked() {
  int x = mouseX / 40;
  int y = mouseY / 40;
  if ( _map.getTile(x, y).towerPlaceable() ) {
    // TODO: Make tile take a tower object as an arguement
    // so that we can add the tower object to _drawables
    Tower newTower = new Tower( x + .5, y + .5, _img );
    _towers.add(newTower);
    _map.getTile( x, y ).addTower( newTower );
    println("Added tower");
  }
}

void keyPressed() {
  if (key == 's' && status== gameState.TITLE) {
    status = gameState.GAMEPLAY;
  }
  else if (key == ' ') {
    if (running) {
      running = false;
      noLoop();
    } else {
      running = true;
      loop();
    }
  }
}

void titleScreen() {
  textSize(80);
  textAlign(CENTER);
  text("potatoPower",300,100);
  textSize(40);
  textAlign(RIGHT);
  text("the official game",400,200);
  textSize(20);
  textAlign(CENTER);
  text("Press s to start the game",400,300);
  keyPressed();
}

void endScreen() {
  image(loss,0,0,width,height);
  textSize(40);
  textAlign(RIGHT);
  text("YOU LOSE",400,200);
}
  