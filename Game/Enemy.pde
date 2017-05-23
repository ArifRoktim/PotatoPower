class Enemy implements Collideable {
  int _hp;
  int _xPos, yPos; // x and y coordinates
  
  Enemy() {
    _hp = 100; 
    // the initial _xPos and _yPos are dependant on the Map
    // Gotta make the Map class first
  }

  boolean isAlive() {
    if (_hp > 0) 
      return true;
    return false;
  }
  
  public void drawObj(){
    
  }
  
  public void move(){
    
  }
  
  public void collide(){
    
  }
  
  public void collide(Collideable other) {
    
  }
  
}