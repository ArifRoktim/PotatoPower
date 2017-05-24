import java.awt.Rectangle;
import java.util.List;
import java.util.ArrayList;

public class QuadTree{

  int _maxObjects;
  int _maxLevels;
  int _level;
  List _objects;
  Rectangle _bounds;
  QuadTree[] _nodes;
  QuadTree _parent;

  QuadTree( int level, Rectangle bounds ){
    _level = level;
    _objects = new ArrayList();
    _bounds = bounds;
    _nodes = new QuadTree[4];
  }

  public void clear(){
    _objects.clear();

    for( int i = 0; i < _nodes.length; i++ ){
      if( _nodes[i] != null ){
        _nodes[i].clear();
        _nodes[i] = null;
      }
    }
    
  }


}
