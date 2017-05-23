// functions similar to patches in netlogo
class Tile implements Drawable{
  
  int _type; 
  int _xPos, _yPos; // x and y coordinates
  color _color;
  Drawable _tower;
  
  public Tile() {
    // generic terrain
    _type = 1;
    float r = 0;
    float g = 153;
    float b = 0;
    // sets color to green
    _color = color (r,g,b);
    _tower = null;
  }
  
  void drawObj(){
    
    
  }




}
