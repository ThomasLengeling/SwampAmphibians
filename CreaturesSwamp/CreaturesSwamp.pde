/*

 */

import geomerative.*;

CreaturesManager ampDraw;
CreaturesManager birdDraw;
CreaturesManager insecDraw;
CreaturesManager mammalsDraw;
CreaturesManager plantsDraw;

CreaturesManager ampList;
CreaturesManager birdList;
CreaturesManager insecList;
CreaturesManager mammalsList;
CreaturesManager plantsList;

int numAmp;
int numBird;
int numInsc;
int numMammals;
int numPlants;

SwampMap         swampMap;

CreaturesParticle  creatureParticle;

int       ampListInc = 0;
boolean   ignoringStyles = true;

boolean   drawIndividuals = true;
boolean   drawMap = false;
boolean   drawGUI = false;

void setup() {
  fullScreen();
  //size(1280, 720);
  smooth(16);

  RG.init(this);
  RG.ignoreStyles(ignoringStyles);

  //amphibians
  ampList = new CreaturesManager();
  ampList.loadAll("SVG_Amphibians", 0.8, 0.8, 0.8);

  birdList = new CreaturesManager();
  birdList.loadAll("SVG_Birds", 0.17, 0.17, 0.17);

  insecList = new CreaturesManager();
  insecList.loadAll("SVG_Insects", 0.17, 0.17, 0.17);

  mammalsList = new CreaturesManager();
  mammalsList.loadAll("SVG_Mammals", 0.17, 0.17, 0.17);

  plantsList = new CreaturesManager();
  plantsList.loadAll("SVG_Plants", 0.17, 0.17, 0.17);

  numAmp = ampList.numCreatures();
  numBird = birdList.numCreatures();
  numInsc = insecList.numCreatures();
  numMammals = mammalsList.numCreatures();
  numPlants = plantsList.numCreatures();

  ampDraw = new CreaturesManager();
  birdDraw = new CreaturesManager();
  insecDraw = new CreaturesManager();
  mammalsDraw = new CreaturesManager();
  plantsDraw = new CreaturesManager();

  swampMap = new SwampMap();

  //clear background
  background(255);

  //create GUI
  setupGui();

  // randomSeed(0);
  // noiseSeed(0);
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

    for (int i = 0; i < ampDraw.numCreatures(); i++) {
      ampDraw.draw(i);
    }
    for (int i = 0; i < birdDraw.numCreatures(); i++) {
      birdDraw.draw(i);
    }
    for (int i = 0; i < insecDraw.numCreatures(); i++) {
      insecDraw.draw(i);
    }
    for (int i = 0; i < mammalsDraw.numCreatures(); i++) {
      mammalsDraw.draw(i);
    }
    for (int i = 0; i < plantsDraw.numCreatures(); i++) {
      plantsDraw.draw(i);
    }
  }

  if (!drawIndividuals) {
    ampList.draw();
  };

  //drawGUI
  if (drawGUI) {
    drawGui();
  }
  updateGUI();
}


void keyPressed() {
  if (key == 'g') {
    drawGUI = !drawGUI;
  }
  if (key == 'm') {
    drawMap = !drawMap;
  }

  if (key == '1') {
    ampListInc++;
    println(ampListInc);
  }
  if (key == '1') {
    cp5.getController("NumAmp").setValue(creatures[0][0] + (int)random(2.01));
    cp5.getController("NumBird").setValue(creatures[0][1]+ (int)random(2.01));
    cp5.getController("NumInsec").setValue(creatures[0][2]+ (int)random(2.01));
    cp5.getController("NumMammals").setValue(creatures[0][3]+ (int)random(2.01));
    cp5.getController("NumPlants").setValue(creatures[0][4]+ (int)random(2.01));
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
