class Enemy implements Collideable {
  int _hp;
  int _xPos, yPos; // x and y coordinates
  
  Enemy() {
    _hp = 100; 
  }

  boolean isAlive() {
    if (_hp > 0) 
      return true;
    return false;
  }
  
  void drawObj(){
    
  }
  
  void move(){
    
  }
  
  void collide(){
    
  }
  
  void collide(Collideable other) {
    
  }
  
}
