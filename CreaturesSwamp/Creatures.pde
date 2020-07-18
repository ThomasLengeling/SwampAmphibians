class Creatures {

  RShape shp;
  String fileName;
  String idName;
  int id;

  //animatio
  float animTime = 0;
  float animeInc = 0.001;
  float dirInc = 1;

  boolean lockAnim = false;

  float posX = 0;
  float posY = 0;

  float scX = 0.009;
  float scY = 0.009;
  float scZ = 0.009;

  //shape
  float startX = 0;
  float startY = 0;

  float endX = 0;
  float endY = 0;

  RPoint[][] pointPaths;

  //contructor
  Creatures(String file) {
    fileName = file;
    println("loading "+fileName);

    animeInc += random(0.001, 0.006);
  }

  void createCreature() {

    shp = RG.loadShape(fileName);
    shp.scale(scX, scY, scZ);

    println("size "+shp.width+" "+shp.height);
    pointPaths = shp.getPointsInPaths();

    int endI = pointPaths.length -1;
    int endJ = pointPaths[endI].length - 1;

    startX = pointPaths[0][0].x;
    startY = pointPaths[0][0].y;

    endX  = pointPaths[endI][endJ].x;
    endX  = pointPaths[endI][endJ].y;

    println("start pos");
    println(startX+" "+startY);
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

  void setScale(float sx, float sy, float sz) {
    scX = sx;
    scY = sy;
    scZ = sz;
  }

  //draw in a specific location
  void draw() {

    pushMatrix();

    translate(posX - startX, posY - startY);
    //scale(scX, scY);

    //scale(2.0 - animTime*5, 2.0 - animTime*5);
    //rotate(90 * dirInc);
    noFill();

    stroke(255, 200-animTime*5);

    float t = constrain(map(mouseX, 10, width-10, 0, 1), 0, 1);
    float w = constrain(map(mouseY, 10, height-10, 1, 15), 1, 15);

    strokeWeight((int)cp5.getController("strokeWeight").getValue());

    RShape[] splittedGroups = RG.split(shp, animTime); 
    splittedGroups[0].draw();

    popMatrix();
  }

  //update vales
  void update() {
    animate();
  }

  void reset() {
    lockAnim = false;
    dirInc = 1;
    animTime = 0.0;
  }

  boolean isDone() {
    if (animTime <= 0 && lockAnim == true) {
      return true;
    }
    return false;
  }

  //animate creation of the Amphibian
  void animate() {
    if (!lockAnim) {
      animTime  += animeInc * dirInc;
    }

    if (animTime >= 1.0) {
      animTime = 1.0;
      dirInc *= -1;
    }

    if (animTime <= 0.0) {
      lockAnim = true;
      animTime = 0.0;
      dirInc *= -1;
    }
  }
}
