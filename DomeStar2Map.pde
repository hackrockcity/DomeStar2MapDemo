class DomeStar2Map {
  int size = width;
  int half_size = size / 2;
  int strips = 40;
  int leds = 160;
  int buffer = 20;

  class MapEntry {
    int x;
    int y;
    int strip;
    int led;
    
    public MapEntry(int x, int y, int strip, int led) {
      this.x = x;
      this.y = y;
      this.strip = strip;
      this.led = led;
    }
  };
    
  MapEntry[] lookup;
  color[] pixelBuffer;
    
  public DomeStar2Map() {
    lookup = new MapEntry[leds * strips];
    pixelBuffer = new color[leds * strips];
    this.buildMap();
  }
    
  public void buildMap() {
    for (int strip = 0; strip < strips; strip++) {
      for (int led = 0; led < leds; led++) {
        float rotation = (float)strip / strips * TWO_PI;
        float magnitude = (buffer + (float)led / leds * (half_size - buffer));
        
        if (led > 16) {
          rotation += PI/6 * ((float)led / (leds - 16));
        }
        else {
          rotation += PI/6;
        }
        
        int x = int(width / 2 + sin(rotation) * magnitude);
        int y = int(width / 2 + cos(rotation) * magnitude);
        
        lookup[led * strips + strip] = new MapEntry(x, y, strip, led);
        //point(x,y);
      }
    }      
  }
  
  public color[] applyMap() {
    PImage image = get();
    image.loadPixels();
    
    for (MapEntry entry : lookup) {
      pixelBuffer[entry.led * strips + entry.strip] = image.pixels[entry.y * width + entry.x];
    }
     
    return pixelBuffer;
  }
}