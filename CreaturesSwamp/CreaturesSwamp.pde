/*

 */

import geomerative.*;

CreaturesManager ampList;
SwampMap         swampMap;
ParticleNoise    particleTest; 

int       ampListInc = 0;
boolean   ignoringStyles = true;
boolean   drawIndividuals = false;
boolean   drawMap = false;

void setup() {
  size(1024, 768);
  smooth(16);

  RG.init(this);
  RG.ignoreStyles(ignoringStyles);

  //amphibians
  ampList = new CreaturesManager();
  swampMap = new SwampMap();

  particleTest =  new ParticleNoise(300 * cos(0) + width/2, 300 * sin(0) + height/2, random(0.5, 2), random(0.05, 0.1), 0);
  particleTest.stopped = false;
  particleTest.pos.x = random(width);
  particleTest.pos.y = random(height);

  //fill Amphibians
  ampList.loadAll();
  
  //clear background
  background(255);
}

//Main draw
void draw() {

  noStroke();
  fill(255, 10);
  rect(0, 0, width, height);

  ampList.draw();

  if (drawMap) {
    swampMap.draw();
  }

  if (drawIndividuals) {
    ampList.draw(ampListInc);
    //ampList.drawCenter(ampListInc);
    ampList.update(ampListInc);
  }

  if (!drawIndividuals) {
    // ampList.draw();
    //  ampList.update();
  }
  
  particleUpade();
  
}

void particleUpade() {

  //if (p.attracting || p.repelling) p.magnet(mouseX, mouseY, magnetRadius, 10);
  if (particleTest.flowing) particleTest.flow();


  particleTest.run();
}


void keyPressed() {

  if (key == 'm') {
    drawMap = !drawMap;
  }

  if (key == '1') {
    ampListInc++;
    println(ampListInc);
  }

  if (key == '2') {
    ampListInc--;
    println(ampListInc);
  }

  if (key == 'a') {
    drawIndividuals = !drawIndividuals;
  }
}
