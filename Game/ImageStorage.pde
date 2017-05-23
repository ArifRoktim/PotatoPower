public class ImageStorage {
  final PImage grass = loadImage("grass_texture.png");
  final PImage tower = loadImage("tower.png");
  final PImage path = loadImage("path.png");
  
  public PImage grass() {
    return grass;
  }
  
  public PImage tower() {
    return tower;
  }
  
  public PImage path() {
    return path;
  }
}