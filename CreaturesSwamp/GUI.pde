import controlP5.*;
ControlP5 cp5;

void setupGui() {
  cp5 = new ControlP5(this);

  Group g1 = cp5.addGroup("g1")
    .setPosition(10, 20)
    .setBackgroundHeight(250)
    .setWidth(200)
    .setBackgroundColor(color(150, 50))
    ;

  cp5.addSlider("NumAmp")
    .setPosition(20, 30)
    .setValue(0)
    .setRange(0, ampList.numCreatures())
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addSlider("NumBird")
    .setPosition(20, 50)
    .setValue(0)
    .setRange(0, birdList.numCreatures())
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;
  cp5.addSlider("NumInsec")
    .setPosition(20, 70)
    .setValue(0)
    .setRange(0, insecList.numCreatures())
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;
  cp5.addSlider("NumMammals")
    .setPosition(20, 90)
    .setValue(0)
    .setRange(0, mammalsList.numCreatures())
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addSlider("NumPlants")
    .setPosition(20, 110)
    .setValue(0)
    .setRange(0, plantsList.numCreatures())
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addSlider("randomIncr")
    .setPosition(20, 130)
    .setValue(0)
    .setRange(0, 1)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addSlider("alpha")
    .setPosition(20, 150)
    .setValue(10)
    .setRange(0, 255)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;

  cp5.addSlider("strokeWeight")
    .setPosition(20, 170)
    .setValue(2.5)
    .setRange(0, 10)
    .setDecimalPrecision(1)
    .setGroup(g1)
    ;

  cp5.addSlider("strokeType")
    .setPosition(20, 190)
    .setValue(1)
    .setRange(0, 5)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;
    
  cp5.addSlider("stepCounter")
    .setPosition(20, 210)
    .setValue(0)
    .setRange(0, 20)
    .setDecimalPrecision(0)
    .setGroup(g1)
    ;


  cp5.setAutoDraw(false);
}


void drawGui() {

  hint(DISABLE_DEPTH_TEST);
  cp5.draw();
  hint(ENABLE_DEPTH_TEST);
}
