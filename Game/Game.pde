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
GameState status;
int lives, money,kills;
boolean running;
PImage menu;
PImage loss;
PImage win;
Button playBtn, atkBtn, reloadBtn, rangeBtn, speedBtn;
Button confirmBtn, cancelBtn;
int tutorialSlide;
boolean showUpgrades, confirmTower;

void setup() {
  size(600, 600); //15x15 tiles
  status = GameState.TITLE;
  menu = loadImage("title.jpg");
  loss = loadImage("loser.jpg");
  win = loadImage("sun.jpg");
  image(menu,0,0,width,height);
  titleScreen();
  tutorialSlide = 0;
  _qTree = new QuadTree( 0, new Rectangle( 0, 0, width, height) );
  _img = new ImageStorage();
  _map = new Map(_img);
  _map.mapOne();
  _enemies = new LinkedList();
  _projectiles = new LinkedList();
  _towers = new LinkedList();
  lives = 30;
  kills = 0;
  money = 100;
  _enemyQueue = new ArrayDeque<Enemy>();
  for (int i = 0; i < 50; i++)
    _enemyQueue.add(new Enemy(_map, _img));
  textSize(24);
  fill(255, 0, 0);
  noStroke();
  playBtn = new Button(520, 40, ButtonType.PLAY, null, _img);
  atkBtn = new Button(0, 0, ButtonType.ATTACK, null, _img);
  reloadBtn = new Button(0, 0, ButtonType.RELOAD, null, _img);
  rangeBtn = new Button(0, 0, ButtonType.RANGE, null, _img);
  speedBtn = new Button(0, 0, ButtonType.SPEED, null, _img);
  confirmBtn = new Button(0, 0, ButtonType.OK, null, _img);
  cancelBtn = new Button(0, 0, ButtonType.CANCEL, null, _img);
  showUpgrades = false;
  confirmTower = false;
  //speedup for development
  //frameRate(120);
}

void draw() {
  // Add all Collideables to the quadtree
  popQuadTree();

  if (status == GameState.TITLE || status == GameState.TUTORIAL){
  }
  else if (status == GameState.GAMEPLAY || status == GameState.WAITING ) {
    if( status == GameState.GAMEPLAY )
      spawn();

    for ( Enemy e : _enemies ) {
      e.move();
    }
    for (Projectile p : _projectiles) {
      p.move();
    }


    //if enemy reaches end, decrease lives
    if (!_enemies.isEmpty()) {
      Enemy first = _enemies.get(0);
      // check if enemy has reached end of map
      if ( _map.getTile( (int) first.getX(), (int) first.getY() ) == _map._end ) {
        // make sure that towers no longer target enemy by giving the enemy invalid coordinates
        first._xPos = first._yPos = -1;
        _enemies.remove(0);
        lives--;
      }
    }

    // Do enemy and projectile collisions
    List<Collideable> probable = new LinkedList<Collideable>();
    for( int i = _enemies.size() - 1; i >= 0; i-- ){
      _qTree.retrieve( probable, _enemies.get(i) );
      for(Collideable e: probable){
        if( _enemies.size() > 0 ){
          if( e instanceof Projectile && _enemies.get(i).isColliding(e) ){
            _enemies.get(i)._hp -= ( (Projectile) e ).damage;
            _projectiles.remove( e );
          }
          if( ! _enemies.get(i).isAlive() ){
            _enemies.remove(i);
            money += 2;
            kills++;
          }
        }
      }

    }

    // remove projectiles that go out of bounds
    for (int i = _projectiles.size() - 1; i > -1; i--) {
      if (_projectiles.get(i).outOfBounds()){
        Projectile p = _projectiles.get(i);
        //println("removed projectile: " + p.getX() + ", " + p.getY());
        _projectiles.remove(i);
      }
    }

    // PROJECTILE SHOT EVERY RELOAD TIME
    for (Tower x: _towers) {
      if( x.active ){
        x.detect();
        x.aim();
        if ((frameCount % (int)(x._reloadTime*60)) == 0) {
          Projectile p = x.shoot();
          if (p != null) {
            _projectiles.add(p);
            //println("dx: " + p._dx + " dy: " + p._dy);
          }
        }
      }
    }

    //update screen
    render();
    if (lives <= 0) {
      status = GameState.END;
    }
    else if (_enemyQueue.isEmpty()) {
      status = GameState.WIN;
    }
  }
  else if (status == GameState.END) {
    endScreen();
  }
  else if (status == GameState.WIN){
    winScreen();
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
  textSize(24);
  text("Lives: " + lives, 80, 40);
  text("Money: " + money, 80, 80);
  playBtn.drawObj();
  if (showUpgrades) {
    atkBtn.drawObj();
    reloadBtn.drawObj();
    rangeBtn.drawObj();
    speedBtn.drawObj();
  }
  if (confirmTower){
    confirmBtn.drawObj();
    cancelBtn.drawObj();
  }
}

// Spawn enemy at the starting coordinates
void spawn() {
  // Randomly spawn enemy every .5 seconds
  if (Math.random() > 0.5 && frameCount % (30) == 0 && !_enemyQueue.isEmpty()) {
    //System.out.println( frameCount );
    _enemies.add( _enemyQueue.remove() );
  }
}

void popQuadTree() {
  // Clear and repopulate QuadTree
  _qTree.clear();
  _qTree.insertCollideables( _enemies );
  _qTree.insertCollideables( _projectiles );

}

void tutorial() {
  switch (tutorialSlide) {
    case 0:
    _map.drawObj();
    break;
  }
}

void mouseClicked() {
  int x = mouseX / 40;
  int y = mouseY / 40;
  Tile atMouse = _map.getTile(x, y);
  if (status == GameState.TITLE) {
    status = GameState.WAITING;
    tutorial();
  } else if (status == GameState.TUTORIAL) {
    tutorialSlide++;
    if (tutorialSlide > 4)
      status = GameState.WAITING;
    else
      tutorial();
  }else if (playBtn.hovering()) {
    playBtn.action();
  }
  // shows the upgrade menu for towers
  else if (showUpgrades) {
    if (atkBtn.hovering()) {
      atkBtn.action();
      return;
    } else if (reloadBtn.hovering()) {
      reloadBtn.action();
      return;
    } else if (rangeBtn.hovering()) {
      rangeBtn.action();
      return;
    } else if (speedBtn.hovering()) {
      speedBtn.action();
      return;
    } else {
      showUpgrades = false;
      atkBtn.getTarget().setShowRange(false);
    }
  } 
  // shows confirmation menu for buying towers
  else if (confirmTower){
    if (confirmBtn.hovering()){
      confirmBtn.action();
    } else if (cancelBtn.hovering()){
      cancelBtn.action();
    } else {
      cancelBtn.action();
    }
    confirmTower = false;
  }
  // places a tower and asks user to confirm/cancel tower
  else if ( atMouse.towerPlaceable() ) {
    if( money >= 20 ){
      Tower newTower = new Tower( x + .5, y + .5, _img );
      _towers.add(newTower);
      atMouse.addTower( newTower );
      println("Added tower");
      // display confirmation menu
      confirmTower = true;
      newTower.setShowRange(true);
      confirmBtn.setTarget(atMouse.getTower());
      cancelBtn.setTarget(atMouse.getTower());

    } else {
      //print message about insufficient funds
    }
  }
  // close menu when you click outside of the menu
  else if ( _map.getTile(x, y).getType() == TileType.GRASS) {
    if (showUpgrades) {
      atkBtn.getTarget().setShowRange(false);
    }
    showUpgrades = true;
    atkBtn.setTarget(atMouse.getTower());
    rangeBtn.setTarget(atMouse.getTower());
    speedBtn.setTarget(atMouse.getTower());
    reloadBtn.setTarget(atMouse.getTower());
  }
}

void keyPressed() {
  if (key == 's' && status== GameState.TITLE) {
    status = GameState.TUTORIAL;
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
  text("PotatoPower",300,100);
  textSize(40);
  textAlign(RIGHT);
  text("the official game",400,200);
  textSize(20);
  textAlign(CENTER);
  text("Click to start the game",400,300);
  keyPressed();
}

void endScreen() {
  image(loss,0,0,width,height);
  textSize(40);
  textAlign(RIGHT);
  text("YOU LOSE",400,200);
  textSize(20);
  text("You killed " + kills + " enemies.",415,465); 
}

void winScreen() {
  image(win,0,0,width,height);
  textSize(40);
  textAlign(RIGHT);
  text("YOU WIN",395,240);
  textSize(20);
  text("You killed " + kills + " enemies.",415,410); 
}
