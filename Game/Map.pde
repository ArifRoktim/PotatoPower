public class Map{ 
  Tile [][] _map;
  int _width;
  int _height;
  
 public Map(){
   _width = width;
   _height = height;
   int _gcf = this.gcf();
   for (int x= 0; x< _map.length; x++)
    for (int y = 0; y < _map.length; y++)
      _map[y][x] = new Tile(y*_gcf, x*_gcf,new ImageStorage());
 }
 
 public int gcf(){
 int a = _width;
 int b = _height;
 {
   while (a != 0 && b != 0)
   {
     if (a >= b)
       a = a - b;
     else
       b = b - a;
     if (a == 0) return b;
     else return a;
   }
 }
 return 0;
 }
}