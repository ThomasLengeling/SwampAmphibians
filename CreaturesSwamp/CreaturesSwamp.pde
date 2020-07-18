/*

 */

import geomerative.*;

CreaturesManager ampList;
CreaturesManager birdList;
CreaturesManager insecList;
CreaturesManager mammalsList;
CreaturesManager plantsList;

SwampMap         swampMap;

CreaturesParticle  creatureParticle;

int       ampListInc = 0;
boolean   ignoringStyles = true;
boolean   drawIndividuals = true;
boolean   drawMap = false;

void setup() {
  size(1280, 720);
  smooth(16);

  RG.init(this);
  RG.ignoreStyles(ignoringStyles);

  //amphibians
  ampList = new CreaturesManager("SVG_Amphibians", 0.009, 0.009, 0.009);
  birdList = new CreaturesManager("SVG_Birds", 0.17, 0.17, 0.17);
  insecList = new CreaturesManager("SVG_Insects", 0.17, 0.17, 0.17);
  mammalsList = new CreaturesManager("SVG_Mammals", 0.17, 0.17, 0.17);
  plantsList = new CreaturesManager("SVG_Plants", 0.17, 0.17, 0.17);


  swampMap = new SwampMap();

  //clear background
  background(255);

  //create GUI
  setupGui();

  randomSeed(0);
  noiseSeed(0);
}

//Main draw
void draw() {

  noStroke();
  int alpha = (int)cp5.getController("alpha").getValue();
  fill(0, alpha);
  rect(0, 0, width, height);


  if (drawMap) {
    swampMap.draw();
  }

  if (drawIndividuals) {
    for (int i = 0; i < (int)cp5.getController("NumAmp").getValue(); i++) {
      ampList.draw(i);
    }
    for (int i = 0; i < (int)cp5.getController("NumBird").getValue(); i++) {
      birdList.draw(i);
    }
    for (int i = 0; i < (int)cp5.getController("NumInsec").getValue(); i++) {
      insecList.draw(i);
    }
    for (int i = 0; i < (int)cp5.getController("NumMammals").getValue(); i++) {
      mammalsList.draw(i);
    }
    for (int i = 0; i < (int)cp5.getController("NumPlants").getValue(); i++) {
      plantsList.draw(i);
    }
  }

  if (!drawIndividuals) {
    ampList.draw();
  };
  drawGui();
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

  if (key == 'c') {
    creatureParticle.createCreature();
  }
}
