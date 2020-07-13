class Creatures {

  RShape shp;
  String fileName;
  String idName;
  int id;

  //animatio
  float animTime = 0;
  float animeInc = 0.001;

  boolean lockAnim = false;

  float posX = 0;
  float posY = 0;

  float scX = 1.0;
  float scY = 1.0;

  //contructor
  Creatures(String file) {
    fileName = file;
    println("loading "+fileName);

    shp = RG.loadShape(fileName);
    shp = RG.centerIn(shp, g, 100);

    animeInc += random(0.001, 0.01);
  }

  ///set id
  void setId(int index) {
    id = index;
  }

  //set id Name based on the file name
  void idName(String ids) {
    idName = ids;
  }

  void setPos(float posx, float posy) {
    posX = posx;
    posY = posy;
  }

  void setScale(float sx, float sy) {
    scX = sx;
    scY = sy;
  }

  //draw Amphibian at the center
  void drawCenter() {
    pushMatrix();

    translate(500, 500);
    scale(scX, scY);
    noFill();

    stroke(0, 200);

    float t = constrain(map(mouseX, 10, width-10, 0, 1), 0, 1);
    float w = constrain(map(mouseY, 10, height-10, 1, 15), 1, 15);

    strokeWeight(w);

    RShape[] splittedGroups = RG.split(shp, animTime); 
    splittedGroups[0].draw();

    popMatrix();
  }

  //draw in a specific location
  void draw() {

    pushMatrix();

    translate(posX + 200, posY + 200);
    scale(scX, scY);

    //scale(2.0 - animTime*5, 2.0 - animTime*5);
    //rotate(animTime*10);
    noFill();

    stroke(0, 200-animTime*5);

    float t = constrain(map(mouseX, 10, width-10, 0, 1), 0, 1);
    float w = constrain(map(mouseY, 10, height-10, 1, 15), 1, 15);

    strokeWeight(w);

    RShape[] splittedGroups = RG.split(shp, animTime); 
    splittedGroups[0].draw();

    popMatrix();
  }

  //update vales
  void update() {
    animate();
  }

  //animate creation of the Amphibian
  void animate() {
    animTime  += animeInc;
    if (animTime >= 1.0) {
      lockAnim = true;
      animTime = 1.0;
    }
  }
}
