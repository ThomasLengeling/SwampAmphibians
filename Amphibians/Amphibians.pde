/*

 */

import geomerative.*;

AmphibianManager ampList;

int ampListInc = 0;

boolean ignoringStyles = true;
boolean drawIndividuals = false;

void setup() {
  size(1024, 768);
  smooth(16);

  RG.init(this);
  RG.ignoreStyles(ignoringStyles);

  //amphibians
  ampList = new AmphibianManager();

  //fill Amphibians
  ampList.loadAll();
}

void draw() {

  background(255);

  //ampList.draw();

  if (drawIndividuals) {
    ampList.draw(ampListInc);
    ampList.update(ampListInc);
  }
  
  if(!drawIndividuals){
    ampList.draw();
    ampList.update();
  }
  
  
}


void keyPressed() {

  if (key == '1') {
    ampListInc++;
    println(ampListInc);
  }

  if (key == '2') {
    ampListInc--;
    println(ampListInc);
  }
}
