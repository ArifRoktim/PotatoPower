class Button implements Drawable {
  PImage _btnImg;
  ImageStorage img;
  ButtonType _type;
  float x, y;
  
  Button(float nx, float ny, ButtonType type, ImageStorage nimg) {
    img = nimg;
    _type = type;
    x = nx;
    y = ny;
    switch (type) {
      case PLAY:
        _btnImg = img.play();
        break;
      case FASTFORWARD_ON:
        _btnImg = img.fast();
        break;
      case FASTFORWARD_OFF:
        _btnImg = img.slow();
        break;
        //TODO: add atk/range/reloadSpeed buttons
    }
  }
  
  void setType(ButtonType t) {
    _type = t;
    switch (t) {
      case PLAY:
        _btnImg = img.play();
        break;
      case FASTFORWARD_ON:
        _btnImg = img.fast();
        break;
      case FASTFORWARD_OFF:
        _btnImg = img.slow();
        break;
    }
  }
  
  public void drawObj() {
    tint(255, 100);
    image(_btnImg, x, y);
    noTint();
  }
  
  public ImageStorage getImg() {
    return img;
  }
}