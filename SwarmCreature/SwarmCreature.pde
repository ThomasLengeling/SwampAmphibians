/*
Generative Swarm program
 
 */
boolean ignoringStyles = true;

SwampMap swapMap;

void setup() {
  size(1024, 768);
  smooth(16);

  RG.init(this);
  RG.ignoreStyles(ignoringStyles);

  swapMap = new SwampMap();
}

void draw() {

  background(255);

  swapMap.draw();
  
}
