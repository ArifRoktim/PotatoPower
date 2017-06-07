class Button implements Drawable {
  PImage _btnImg;
  ImageStorage img;
  ButtonType _type;
  Tower targetTower;
  float x, y;

  Button(float nx, float ny, ButtonType type, Tower target, ImageStorage nimg) {
    img = nimg;
    _type = type;
    x = nx;
    y = ny;
    targetTower = target;
  }

  void setType(ButtonType t) {
    _type = t;
  }

  void setTarget(Tower t) {
    if( t == null )
      return;
    targetTower = t;
    float tx = t.getX()*40;
    float ty = t.getY()*40;
    switch (_type) {
      case ATTACK:
        x = tx - 45;
        y = ty - 40;
        break;
      case RANGE:
        x = tx + 5;
        y = ty - 40;
        break;
      case RELOAD:
        x = tx - 20;
        y = ty + 5;
        break;
      case OK:
        x = tx - 45;
        y = ty - 20;
        break;
      case CANCEL:
        x = tx + 5;
        y = ty - 20;
        break;
    }
    t.setShowRange(true);
  }

  void setX(float nx) {
    x = nx;
  }

  void setY(float ny) {
    y = ny;
  }

  public void drawObj() {
    tint(255, 150);
    switch (_type) {
      case PLAY:
        image(img.play(), x, y, 40, 40 );
        break;
      case FASTFORWARD_ON:
        image(img.fast(), x, y, 40, 40 );
        break;
      case FASTFORWARD_OFF:
        image(img.slow(), x, y, 40, 40 );
        break;
      case ATTACK:
        image(img.attack(), x, y);
        textSize(9);
        text(getTarget().atkUpgradeCost,x+20,y+32);
        break;
      case RANGE:
        image(img.range(), x, y);
        textSize(9);
        text(getTarget().rangeUpgradeCost,x+20,y+32);
        break;
      case RELOAD:
        image(img.reload(), x, y);
        textSize(9);
        text(getTarget().reloadUpgradeCost,x+20,y+40);
        break;
      case OK:
        image(img.ok(), x, y);
        break;
      case CANCEL:
        image(img.cancel(), x, y);
        break;
    }
    noTint();
  }

  void action() {
    switch (_type) {
      case PLAY:
        status = GameState.GAMEPLAY;
        setType(ButtonType.FASTFORWARD_ON);
        break;
      case FASTFORWARD_ON:
        frameRate(120);
        setType(ButtonType.FASTFORWARD_OFF);
        break;
      case FASTFORWARD_OFF:
        frameRate(60);
        setType(ButtonType.FASTFORWARD_ON);      
        break;
      case ATTACK:
        if (money >= targetTower.getAtkCost()) {
          money -= targetTower.getAtkCost();
          targetTower.increaseAttack();
        }
        break;
      case RANGE:
        if (money >= targetTower.getRangeCost()) {
          money -= targetTower.getRangeCost();
          targetTower.increaseRange();
        }
        break;
      case RELOAD:
        if (money >= targetTower.getReloadCost()) {
          money -= targetTower.getReloadCost();
          targetTower.increaseReload();
        }
        break;
      case OK:
        targetTower.active = true;
        targetTower.setShowRange(false);
        money -= 20;
        break;
      case CANCEL:
        for( Tile[] row: _map._map ){
          for( Tile tile: row ){
            if( tile._tower == targetTower ){
              tile._tower = null;
              break;
            }
          }
        }
        _towers.remove( targetTower );
        break;
    }
  }

  public ImageStorage getImg() {
    return img;
  }

  Tower getTarget() {
    return targetTower;
  }

  boolean hovering() {
    return mouseX > x && mouseX < x + 40 && mouseY > y && mouseY < y + 40;
  }
}
