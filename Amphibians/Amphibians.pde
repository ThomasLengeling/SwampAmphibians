/*

 */

import geomerative.*;

AmphibianManager ampList;
SwampMap         swampMap;

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
  ampList = new AmphibianManager();
  swampMap = new SwampMap();

  //fill Amphibians
  ampList.loadAll();
}

void draw() {

  background(255);

  ampList.draw();
  
  if(drawMap){
    swampMap.draw();
  }
  
  if (drawIndividuals) {
    ampList.draw(ampListInc);
    //ampList.drawCenter(ampListInc);
    ampList.update(ampListInc);
  }
  
  if(!drawIndividuals){
   // ampList.draw();
  //  ampList.update();
  }
  

  
  
}


void keyPressed() {
  
  if(key == 'm'){
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
  
  if (key == 'a'){
    drawIndividuals = !drawIndividuals;
  }
}
