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

  float randSize = 0.1;

  float randTrans = 0;

  //contructor
  Creatures(String file) {
    fileName = file;
    println("loading "+fileName);

    animeInc = random(0.0003, 0.01);
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

    randSize = random(0.04, 0.35);
    randTrans = random(0, 1);
  }

  void resetValues() {
    randSize = random(0.04, 0.35);
    randTrans = random(0, 1);
    animeInc = random(0.0003, 0.01);
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

    if (randTrans> 0.6) {
      scale(-1, 1);
    }
    if (randTrans > 0.3 && randTrans< 0.6) {
       scale(1, -1);
    }

   if (randTrans > 0.0 && randTrans< 0.3) {
       scale(-1, -1);
    }
    
    if (dirInc >= 0) {
      scale(1.0 - abs(animTime*randSize), 1.0 - abs(animTime*randSize));
    } else {
      scale(1.0 - abs(1.0*randSize), 1.0 - abs(1.0*randSize));
    }

    if (randTrans > 0.3) {
      if (dirInc >= 0){
        rotate(animTime*1.2);
      }else{
        rotate(abs(1.0*animTime*1.2));
      }
      //else {
       // rotate(1.0*0.2);
      //}
    }

    noFill();

    stroke(255, 10);//200-animTime*5);

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
