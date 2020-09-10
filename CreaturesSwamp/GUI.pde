import controlP5.*;
ControlP5 cp5;


Slider sliderCount;

ControlTimer controlTimer;
Textlabel textTimer;
Textlabel textMaxCreatures;


void setupGui() {
  cp5 = new ControlP5(this);

  Group g1 = cp5.addGroup("g1")
    .setPosition(10, 20)
    .setBackgroundHeight(300)
    .setWidth(480)
    .setBackgroundColor(color(150, 150))
    ;

  ////
  cp5.addSlider("NumAmp")
    .setPosition(20, 30)
    .setValue(0)
    .setRange(0, 50)
    .setDecimalPrecision(1)
    .setGroup(g1)
    ;

  ///
  cp5.addSlider("NumBird")
    .setPosition(20, 50)
    .setValue(0)
    .setRange(0, 50)
    .setDecimalPrecision(1)
    .setGroup(g1)
    ;

  //- 
  cp5.addSlider("NumInsec")
    .setPosition(20, 70)
    .setValue(0)
    .setRange(0, 50)
    .setDecimalPrecision(1)
    .setGroup(g1)
    ;

  //
  cp5.addSlider("NumMammals")
    .setPosition(20, 90)
    .setDecimalPrecision(1)
    .setValue(0)
    .setRange(0, 50)
    .setGroup(g1)
    ;
  //
  cp5.addSlider("NumPlants")
    .setPosition(20, 110)
    .setValue(0)
    .setRange(0, 50)
    .setDecimalPrecision(1)
    .setGroup(g1)
    ;

  //
  cp5.addSlider("randomIncr")
    .setPosition(20, 130)
    .setValue(0)
    .setRange(0, 1)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addSlider("alpha")
    .setPosition(20, 150)
    .setValue(1.0)
    .setRange(0, 50)
    .setDecimalPrecision(1)
    .setGroup(g1)
    ;

  cp5.addSlider("strokeWeight")
    .setPosition(20, 170)
    .setValue(1.0)
    .setRange(0, 10)
    .setDecimalPrecision(1)
    .setGroup(g1)
    ;

  cp5.addSlider("strokeType")
    .setPosition(20, 190)
    .setValue(0)
    .setRange(0, 5)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addSlider("stepCounter")
    .setPosition(20, 210)
    .setValue(5)
    .setRange(0, 20)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addSlider("seconds")
    .setPosition(180, 30)
    .setDecimalPrecision(0)
    .setRange(0, 59)
    .setValue(50)
    .setGroup(g1)
    ;

  cp5.addSlider("minutes")
    .setPosition(180, 60)
    .setDecimalPrecision(0)
    .setRange(0, 5)
    .setValue(0)
    .setGroup(g1)
    ;

  //
  sliderCount  = cp5.addSlider("counter")
    .setPosition(20, 240)
    .setDecimalPrecision(0)
    .setRange(0, 10) // values can range from big to small as well
    .setValue(0)
    .setGroup(g1);

  cp5.addToggle("rotateC")
    .setPosition(200, 210)
    .setValue(false)
    .setSize(30, 30)
    .setGroup(g1)
    ;

  cp5.addToggle("shiftC")
    .setPosition(250, 210)
    .setValue(false)
    .setSize(30, 30)
    .setGroup(g1)
    ;

  cp5.addToggle("clean")
    .setPosition(300, 210)
    .setValue(false)
    .setSize(30, 30)
    .setGroup(g1)
    ;

  cp5.addToggle("BlackWhite")
    .setPosition(350, 210)
    .setValue(false)
    .setSize(30, 30)
    .setGroup(g1)
    ;

  cp5.addToggle("lines")
    .setPosition(400, 210)
    .setValue(false)
    .setSize(30, 30)
    .setGroup(g1)
    ;

  /*
  cp5.addRange("rangeAmp")
   .setPosition(180, 30)
   .setDecimalPrecision(0)
   .setRange(0, numAmp)
   .setRangeValues((int)4, (int)7)
   .setGroup(g1)
   ;
   cp5.addRange("rangeBird")
   .setPosition(180, 50)
   .setDecimalPrecision(0)
   .setRange(0, numBird)
   .setRangeValues((int)4, (int)7)
   .setGroup(g1)
   ;
   
   cp5.addRange("rangeInsec")
   .setPosition(180, 70)
   .setDecimalPrecision(0)
   .setRange(0, numInsc)
   .setRangeValues((int)4, (int)7)
   .setGroup(g1);
   
   cp5.addRange("rangePlants")
   .setPosition(180, 110)
   .setDecimalPrecision(0)
   .setRange(0, numPlants)
   .setRangeValues((int)4, (int)7)
   .setGroup(g1)
   ;
   cp5.addRange("rangeMammals")
   .setPosition(180, 90)
   .setDecimalPrecision(0)
   .setRange(0, numMammals)
   .setRangeValues((int)4, (int)7)
   .setGroup(g1);
   */

  //controllTimer
  controlTimer = new ControlTimer();
  textTimer = cp5.addTextlabel("--")
    .setPosition(20, 280)
    .setGroup(g1);

  controlTimer.setSpeedOfTime(1);

  textMaxCreatures  = cp5.addTextlabel("M")
    .setPosition(80, 270)
    .setGroup(g1);

  cp5.setAutoDraw(false);
}



void drawGui() {

  hint(DISABLE_DEPTH_TEST);
  cp5.draw();
  hint(ENABLE_DEPTH_TEST);
}

void updateGUI() {
  //timer controll
  if (toogleTimer) {
    textTimer.setValue(controlTimer.toString() +"      "+controlTimer.millis());

    //minutes
    if (controlTimer.second() == cp5.getController("seconds").getValue() &&
      controlTimer.minute() == cp5.getController("minutes").getValue() ) {

      //slider value 0
      if (sliderCount.getValue() <= 9) {
        int currId = (int)sliderCount.getValue();
        println("value "+sliderCount.getValue());

        for (int i = 0; i < creatures[currId][0]; i++) {
          ampDraw.add(ampList.getCreature((int)random(0, ampList.numCreatures()-1)));
        }

        for (int i = 0; i < creatures[currId][1]; i++) {
          birdDraw.add(birdList.getCreature((int)random(0, birdList.numCreatures()-1)));
        }

        for (int i = 0; i < creatures[currId][2]; i++) {
          insecDraw.add(insecList.getCreature((int)random(0, insecList.numCreatures()-1)));
        }

        for (int i = 0; i < creatures[currId][3]; i++) {
          mammalsDraw.add(mammalsList.getCreature((int)random(0, mammalsList.numCreatures()-1)));
        }

        for (int i = 0; i < creatures[currId][4]; i++) {
          plantsDraw.add(plantsList.getCreature((int)random(0, plantsList.numCreatures()-1)));
        }

        sliderCount.setValue(sliderCount.getValue() + 1);

        //clean bkg
        if (currId == 5) {
            bkg.toogleDirection();
        }
        
      } else {
        sliderCount.setValue(0);
        println("reset");
        bkg.toogleDirection();
      }
      controlTimer.reset();
    }
  }
}

void NumAmp(int value) {

  int numCurrent =  ampDraw.numCreatures();
  int numNewCreatures = int((value * (maxCreatrues))/100.0);

  ampList = new CreaturesManager();
  ampList.loadAll("SVG_Amphibians", 0.058, 0.058, 0.058); //75

  //
  println("num: "+numCurrent);
  println("new: "+numNewCreatures);
  while (numCurrent != numNewCreatures) {
    if (numCurrent >= numNewCreatures) {
      ampDraw.pop_back();
    }

    if (numCurrent < numNewCreatures) {
      ampDraw.add( ampList.getCreature((int)random(0, ampList.numCreatures()-1)));
    }
    numCurrent =  ampDraw.numCreatures();
  }
}

void NumBird(int value) {

  int numCurrent =  birdDraw.numCreatures();
  int numNewCreatures = int((value * (maxCreatrues))/100.0);

  birdList = new CreaturesManager();
  birdList.loadAll("SVG_Birds", 0.058, 0.058, 0.058); //75

  //
  println("num: "+numCurrent);
  println("new: "+numNewCreatures);
  while (numCurrent != numNewCreatures) {
    if (numCurrent >= numNewCreatures) {
      birdDraw.pop_back();
    }

    if (numCurrent < numNewCreatures) {
      birdDraw.add( birdList.getCreature((int)random(0, birdList.numCreatures()-1)));
    }
    numCurrent =  birdDraw.numCreatures();
  }
}

void NumInsec(int value) {

  int numCurrent =  insecDraw.numCreatures();
  int numNewCreatures = int((value * (maxCreatrues))/100.0);

  insecList = new CreaturesManager();
  insecList.loadAll("SVG_Insects", 0.056, 0.056, 0.056); //75

  //
  println("num: "+numCurrent);
  println("new: "+numNewCreatures);
  while (numCurrent != numNewCreatures) {
    if (numCurrent >= numNewCreatures) {
      insecDraw.pop_back();
    }

    if (numCurrent < numNewCreatures) {
      insecDraw.add( insecList.getCreature((int)random(0, insecList.numCreatures()-1)));
    }
    numCurrent =  insecDraw.numCreatures();
  }
}

void NumMammals(int value) {

  int numCurrent =  mammalsDraw.numCreatures();
  int numNewCreatures = int((value * (maxCreatrues))/100.0);

  mammalsList = new CreaturesManager();
  mammalsList.loadAll("SVG_Mammals", 0.056, 0.056, 0.056); //75

  //
  println("num: "+numCurrent);
  println("new: "+numNewCreatures);
  while (numCurrent != numNewCreatures) {
    if (numCurrent >= numNewCreatures) {
      mammalsDraw.pop_back();
    }

    if (numCurrent < numNewCreatures) {
      mammalsDraw.add( mammalsList.getCreature((int)random(0, mammalsList.numCreatures()-1)));
    }
    numCurrent =  mammalsDraw.numCreatures();
  }
}

void NumPlants(int value) {


  int numCurrent =  plantsDraw.numCreatures();
  int numNewCreatures = int((value * (maxCreatrues))/100.0);

  plantsList = new CreaturesManager();
  plantsList.loadAll("SVG_Plants", 0.056, 0.056, 0.056); //75

  //
  println("num: "+numCurrent);
  println("new: "+numNewCreatures);
  while (numCurrent != numNewCreatures) {
    if (numCurrent >= numNewCreatures) {
      plantsDraw.pop_back();
    }

    if (numCurrent < numNewCreatures) {
      plantsDraw.add( plantsList.getCreature((int)random(0, plantsList.numCreatures()-1)));
    }
    numCurrent =  plantsDraw.numCreatures();
  }
}

void  clean() {
  ampDraw.clear();
  birdDraw.clear();
  insecDraw.clear();
  mammalsDraw.clear();
  plantsDraw.clear();
}

//toogle buttons
boolean tooggleRotate = true;
boolean toogleShift = true;
boolean tooggleColor = true;

void rotateC() {
  tooggleRotate = !tooggleRotate;
}
void shiftC() {
  toogleShift =!toogleShift;
}
void BlackWhite() {
  tooggleColor = !tooggleColor;
}
void alpha(float val) {
  bkg.alpha = val;
}
