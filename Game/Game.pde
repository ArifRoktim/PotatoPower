import java.util.ArrayList; //for queue implementation
// the "driver" file


void setup() {
  
}

void draw() {
  
}

// any class that implements "Drawable" will be able to be displayed in Processing
interface Drawable {
   void drawObj();
}

/* classes that implement "Collideable" will be able to collide with other objects
  that also implement "Collideable"
*/
interface Collideable extends Drawable {
  // when a projectile collides with another
  void collide( Collideable other);
 
  void collide(); //needed?
  
  // movement for the projectiles
  void move();
}


public class Queue<T>{ //ArrayList queue
    private ArrayList<T> _queue;
    int pointer;

    public Queue() { 
        _queue = new ArrayList();
    }

    public void enqueue( T x ) {
        _queue.add(x);
    }//O(1)
    
    
    public T dequeue() { //retrieves removes head of _queue 
        T temp = _queue.get(0);
        _queue.remove(0);
        return temp;
    }//O(n)


    // means of "peeking" at the front item
    public T peekFront() {
       return  _queue.get(0);
    }//O(1) 

    // means of checking to see if collection is empty
    public boolean isEmpty()  {
       if (_queue.size() == 0) 
         return true;
       return false;
    }//O(1)


    public String toString() {
       String retVal = "";
       for (int i = 0; i < _queue.size(); i++) {
           retVal += _queue.get(_queue.size() - i - 1) + "----> ";
       }
       retVal += "null";
       return retVal;
    }//O(n) 
}