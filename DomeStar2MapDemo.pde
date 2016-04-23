float f = 0;

DomeStar2Map map;
LEDDisplay dome;

void setup() {
  size(400,400);

  dome = new LEDDisplay(this, 40, 160, true, "localhost", 58082);
  map = new DomeStar2Map();
}

void draw() {
  background(0);
  fill(255,0,0);
  noStroke();
  fill(255,0,0);
  
  PImage image = loadImage("test.jpg");
  image(image,0,0,width,height);

  rect(0,(frameCount+width/2)%width,width,40);
  rect((frameCount+width/2)%width,0,40,width);
  
  dome.sendData(map.applyMap());
  
  if (frameCount % 1000 == 0) println(frameRate); 
}