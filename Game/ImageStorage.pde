public class ImageStorage {
  final PImage grass = loadImage("grass_texture.png");
  final PImage tower = loadImage("tower.png");
  final PImage path = loadImage("path.png");
  final PImage turret = loadImage("turret.png");
  final PImage play = loadImage("play.png");
  final PImage fast = loadImage("fastForward_on.png");
  final PImage slow = loadImage("fastForward_off.png");
  
  public PImage grass() {
    return grass;
  }
  
  public PImage tower() {
    return tower;
  }
  
  public PImage path() {
    return path;
  }
  
  public PImage turret() {
    return turret;
  }
  
  public PImage play() {
    return play;
  }
  
  public PImage fast() {
    return fast;
  }
  
  public PImage slow() {
    return slow;
  }
}