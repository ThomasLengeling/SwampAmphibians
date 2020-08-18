/*
Generative Swarm program
 
 */
boolean ignoringStyles = true;

SwampMap swapMap01;
SwampMap swapMap02;

void setup() {
  size(1024, 768);
  smooth(16);

  RG.init(this);
  RG.ignoreStyles(ignoringStyles);

  swapMap01 = new SwampMap();
  swapMap02  = new SwampMap();
}

void draw() {

  background(255);
  
  pushMatrix();
  

  swapMap01.draw();
  swapMap02.draw();
  popMatrix();
  
}
