import controlP5.*;
ControlP5 cp5;


Slider sliderCount;

ControlTimer controlTimer;
Textlabel textTimer;


void setupGui() {
  cp5 = new ControlP5(this);

  Group g1 = cp5.addGroup("g1")
    .setPosition(10, 20)
    .setBackgroundHeight(300)
    .setWidth(400)
    .setBackgroundColor(color(150, 50))
    ;

  ////
  cp5.addSlider("NumAmp")
    .setPosition(20, 30)
    .setValue(0)
    .setRange(0, numAmp)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addRange("rangeAmp")
    .setPosition(180, 30)
    .setDecimalPrecision(0)
    .setRange(0, numAmp)
    .setRangeValues((int)4, (int)7)
    .setGroup(g1)
    ;

  ///
  cp5.addSlider("NumBird")
    .setPosition(20, 50)
    .setValue(0)
    .setRange(0, numBird)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addRange("rangeBird")
    .setPosition(180, 50)
    .setDecimalPrecision(0)
    .setRange(0, numBird)
    .setRangeValues((int)4, (int)7)
    .setGroup(g1)
    ;

  //- 
  cp5.addSlider("NumInsec")
    .setPosition(20, 70)
    .setValue(0)
    .setRange(0, numInsc)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;
  cp5.addRange("rangeInsec")
    .setPosition(180, 70)
    .setDecimalPrecision(0)
    .setRange(0, numInsc)
    .setRangeValues((int)4, (int)7)
    .setGroup(g1)
    ;

  //
  cp5.addSlider("NumMammals")
    .setPosition(20, 90)
     .setDecimalPrecision(0)
    .setValue(0)
    .setRange(0, numMammals)
    .setGroup(g1)
    ;

  cp5.addRange("rangeMammals")
    .setPosition(180, 90)
    .setDecimalPrecision(0)
    .setRange(0, numMammals)
    .setRangeValues((int)4, (int)7)
    .setGroup(g1)
    ;
  //
  cp5.addSlider("NumPlants")
    .setPosition(20, 110)
    .setValue(0)
    .setRange(0, numPlants)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;
  cp5.addRange("rangePlants")
    .setPosition(180, 110)
    .setDecimalPrecision(0)
    .setRange(0, numPlants)
    .setRangeValues((int)4, (int)7)
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
    .setValue(6)
    .setRange(0, 255)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addSlider("strokeWeight")
    .setPosition(20, 170)
    .setValue(1.5)
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

  sliderCount  = cp5.addSlider("counter")
    .setPosition(20, 240)
    .setDecimalPrecision(0)
    .setRange(0, 10) // values can range from big to small as well
    .setValue(0)
    //.setNumberOfTickMarks(10)
    .setGroup(g1)

    //.setSliderMode(Slider.FLEXIBLE)
    ;


  //controllTimer
  controlTimer = new ControlTimer();
  textTimer = cp5.addTextlabel("--")
    .setPosition(20, 270)
    .setGroup(g1);

  controlTimer.setSpeedOfTime(1);



  cp5.setAutoDraw(false);
}


void drawGui() {

  hint(DISABLE_DEPTH_TEST);
  cp5.draw();
  hint(ENABLE_DEPTH_TEST);
}

void updateGUI() {
  //timer controll
  textTimer.setValue(controlTimer.toString());
  if (controlTimer.second() == 10 && controlTimer.minute() == 0) {


    //slider value 0
    if (sliderCount.getValue() <= 4) {
      int currId = (int)sliderCount.getValue();
      println("value "+sliderCount.getValue());

      cp5.getController("NumAmp").setValue(creatures[currId][0] + (int)random(2.01));
      cp5.getController("NumBird").setValue(creatures[currId][1]+ (int)random(2.01));
      cp5.getController("NumInsec").setValue(creatures[currId][2]+ (int)random(2.01));
      cp5.getController("NumMammals").setValue(creatures[currId][3]+ (int)random(2.01));
      cp5.getController("NumPlants").setValue(creatures[currId][4]+ (int)random(2.01));
      sliderCount.setValue(sliderCount.getValue() + 1);
    } else {
      sliderCount.setValue(0);
    }
    controlTimer.reset();
  }
}

void NumAmp(int value) {
  ampList = new CreaturesManager();
  ampList.loadAll("SVG_Amphibians", 0.009, 0.009, 0.009);

  //ampDraw.creaArray.clear();
  for (int i = 0; i < value; i++) {
    ampDraw.add( ampList.getCreature((int)random(0, ampList.numCreatures()-1)));
  }
}

void NumBird(int value) {
  birdList = new CreaturesManager();
  birdList.loadAll("SVG_Birds", 0.17, 0.17, 0.17);


  //birdDraw.creaArray.clear();
  for (int i = 0; i < value; i++) {
    birdDraw.add( birdList.getCreature((int)random(0, birdList.numCreatures()-1)));
 }
}

void NumInsec(int value) {

  insecList = new CreaturesManager();
  insecList.loadAll("SVG_Insects", 0.17, 0.17, 0.17);


  ////insecDraw.creaArray.clear();
  for (int i = 0; i < value; i++) {
    insecDraw.add( insecList.getCreature((int)random(0, insecList.numCreatures()-1)));
  }
}

void NumMammals(int value) {
  mammalsList = new CreaturesManager();
  mammalsList.loadAll("SVG_Mammals", 0.17, 0.17, 0.17);

  //mammalsDraw.creaArray.clear();
  for (int i = 0; i < value; i++) {
    mammalsDraw.add(mammalsList.getCreature((int)random(0, mammalsList.numCreatures()-1)));
  }
}

void NumPlants(int value) {
  plantsList = new CreaturesManager();
  plantsList.loadAll("SVG_Plants", 0.17, 0.17, 0.17);

  ////plantsDraw.creaArray.clear();
  for (int i = 0; i < value; i++) {
    plantsDraw.add(plantsList.getCreature((int)random(0, plantsList.numCreatures()-1)));
  }
  
}
