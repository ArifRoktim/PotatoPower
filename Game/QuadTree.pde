// Main reference and credit: https://gamedevelopment.tutsplus.com/tutorials/quick-tip-use-quadtrees-to-detect-likely-collisions-in-2d-space--gamedev-374

public class QuadTree{

  int _maxObjects;
  int _maxLevels;
  int _level;
  List<Collideable> _objects;
  Rectangle _bounds;
  QuadTree[] _nodes;
  QuadTree _parent;

  QuadTree( int level, Rectangle bounds ){
    _level = level;
    _objects = new ArrayList();
    _bounds = bounds;
    _nodes = new QuadTree[4];
  }

  // Clears QuadTree
  public void clear(){
    _objects.clear();
    for( int i = 0; i < _nodes.length; i++ ){
      if( _nodes[i] != null ){
        _nodes[i].clear();
        _nodes[i] = null;
      }
    }
  }

  // Splits node into 4 subnodes
  private void split() {
    int subWidth = (int)(_bounds.getWidth() / 2);
    int subHeight = (int)(_bounds.getHeight() / 2);
    int x = (int)_bounds.getX();
    int y = (int)_bounds.getY();
    _nodes[0] = new QuadTree(_level+1, new Rectangle(x + subWidth, y, subWidth, subHeight));
    _nodes[1] = new QuadTree(_level+1, new Rectangle(x, y, subWidth, subHeight));
    _nodes[2] = new QuadTree(_level+1, new Rectangle(x, y + subHeight, subWidth, subHeight));
    _nodes[3] = new QuadTree(_level+1, new Rectangle(x + subWidth, y + subHeight, subWidth, subHeight));
  }

/*
 * Determine which node the object belongs to. -1 means
 * object cannot completely fit within a child node and is part
 * of the parent node
 */
  private int getIndex(Collideable object) {
    int index = -1;
    double verticalMidpoint = _bounds.getX() + (_bounds.getWidth() / 2);
    double horizontalMidpoint = _bounds.getY() + (_bounds.getHeight() / 2);

    // Object can completely fit within the top quadrants
    boolean topQuadrant = (object.getY() < horizontalMidpoint && object.getY() + object.getHeight() < horizontalMidpoint);
    // Object can completely fit within the bottom quadrants
    boolean bottomQuadrant = (object.getY() > horizontalMidpoint);

    // Object can completely fit within the left quadrants
    if (object.getX() < verticalMidpoint && object.getX() + object.getWidth() < verticalMidpoint) {
       if (topQuadrant) {
         index = 1;
       }
       else if (bottomQuadrant) {
         index = 2;
       }
     }
     // Object can completely fit within the right quadrants
     else if (object.getX() > verticalMidpoint) {
      if (topQuadrant) {
        index = 0;
      }
      else if (bottomQuadrant) {
        index = 3;
      }
    }

    return index;
  }

 /*
  * Insert the object into the quadtree. If the node
  * exceeds the capacity, it will split and add all
  * objects to their corresponding nodes.
  */
  public void insert(Collideable object) {
    if (_nodes[0] != null) {
      int index = getIndex(object);

      if (index != -1) {
        _nodes[index].insert(object);

        return;
      }
    }

    _objects.add(object);

    if (_objects.size() > _maxObjects && _level < _maxLevels){
       if (_nodes[0] == null) {
          split();
       }

      int i = 0;
      while (i < _objects.size()) {
        int index = getIndex(_objects.get(i));
        if (index != -1) {
          _nodes[index].insert(_objects.remove(i));
        }
        else {
          i++;
        }
      }
    }
  }

 /*
  * Return all objects that could collide with the given object
  */
  public List<Collideable> retrieve(List<Collideable> returnObjects, Collideable object) {
    int index = getIndex(object);
    if (index != -1 && _nodes[0] != null) {
      _nodes[index].retrieve(returnObjects, object);
    }

    returnObjects.addAll(_objects);

    return returnObjects;
  }

}
