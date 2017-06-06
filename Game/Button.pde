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
        image(img.play(), x, y);
        break;
      case FASTFORWARD_ON:
        image(img.fast(), x, y);
        break;
      case FASTFORWARD_OFF:
        image(img.slow(), x, y);
        break;
      case ATTACK:
        image(img.attack(), x, y);
        break;
      case RANGE:
        image(img.range(), x, y);
        break;
      case RELOAD:
        image(img.reload(), x, y);
        break;
    }
    noTint();
  }
  
  void action() {
    switch (_type) {
      case PLAY:
      running = true;
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
      targetTower.increaseAttack();
      break;
      case RANGE:
      targetTower.increaseRange();
      break;
      case RELOAD:
      targetTower.increaseReload();
      break;
    }
  }
  
  public ImageStorage getImg() {
    return img;
  }
  
  Tower getTarget() {
    return targetTower;
  }
}