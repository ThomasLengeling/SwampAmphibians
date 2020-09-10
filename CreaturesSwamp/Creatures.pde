class Creatures {

  RShape shp;
  String fileName;
  String creatureName;
  String idName;
  int id;

  //animatio
  float animTime = 0;
  float animeInc = 0.001;
  float dirInc = 1;

  boolean lockAnim = false;

  float posX = 0;
  float posY = 0;

  float scX = 0.05;
  float scY = 0.05;
  float scZ = 0.05;

  //shape
  float startX = 0;
  float startY = 0;

  float endX = 0;
  float endY = 0;

  RPoint[][] pointPaths;

  float randSize = 0.1;

  float randTrans = 0;

  float rotationDir = 0; 

  float lastDir = 0;
  float lastScale = 0;

  //contructor
  Creatures(String file) {
    fileName = file;
    println("loading "+fileName);

    animeInc = random(0.02, 0.1);
  }

  void createCreature() {

    shp = RG.loadShape(fileName);
    shp = RG.centerIn(shp, g);
    /// shp.translate(shp.width/2.0, shp.height/2.0);
    shp.scale(scX, scY, scZ);

    println("size "+shp.width+" "+shp.height);
    pointPaths = shp.getPointsInPaths();

    int endI = pointPaths.length -1;
    int endJ = pointPaths[endI].length - 1;

    startX = pointPaths[0][0].x;
    startY = pointPaths[0][0].y;

    endX  = pointPaths[endI][endJ].x;
    endY  = pointPaths[endI][endJ].y;

    println("start pos");
    println(startX+" "+startY);

    randSize = random(0.06, 0.8);
    randTrans = random(-PI, PI);
    rotationDir = random(-1.01, 1.01);
  }

  void getNewCreature() {

    String path = dataPath("")+"/"+creatureName+"/";
    String[] filenames = listFileNames(path);
    fileName =    path+"/"+filenames[(int)random(0, filenames.length-1)];
    
    shp = RG.loadShape(fileName);
    shp = RG.centerIn(shp, g);
    /// shp.translate(shp.width/2.0, shp.height/2.0);
    shp.scale(scX, scY, scZ);

    println("size "+shp.width+" "+shp.height);
    pointPaths = shp.getPointsInPaths();

    int endI = pointPaths.length -1;
    int endJ = pointPaths[endI].length - 1;

    startX = pointPaths[0][0].x;
    startY = pointPaths[0][0].y;

    endX  = pointPaths[endI][endJ].x;
    endY  = pointPaths[endI][endJ].y;

    println("start pos");
    println(startX+" "+startY);

    randSize = random(0.06, 0.8);
    randTrans = random(-PI, PI);
    rotationDir = random(-1.01, 1.01);
  }

  void resetValues() {
    randSize = random(0.06, 0.8);
    randTrans = random(-PI, PI);
    animeInc = random(0.02, 0.1);
    rotationDir = random(-1.01, 1.01);
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


    noFill();
    if (tooggleColor) {
      stroke(0);
    } else {
      stroke(255);
    }

    float t = constrain(map(mouseX, 10, width-10, 0, 1), 0, 1);
    float w = constrain(map(mouseY, 10, height-10, 1, 15), 1, 15);

    strokeWeight((int)cp5.getController("strokeWeight").getValue());

    /*
    RPoint[] pts = shp.getBoundsPoints();
     
     for (int i = 0; i<4; i++) {
     ellipse(pts[i].x, pts[i].y, 10, 10);
     }
     ellipse(center.x, center.y, 10, 10);
     */


    RPoint center = shp.getCenter();
    translate(center.x, center.y);

    rotate(randTrans);

    if (tooggleRotate) {
      if (randTrans > 0.3) {
        if (dirInc > 0) {
          lastDir = abs((animTime)/frameRate)*rotationDir;
          rotate(lastDir);
        } else {
          rotate(lastDir);
        }
      }
    }

    if (toogleShift) {
      if (dirInc > 0) {
        lastScale =  abs( ((animTime*randSize)/frameRate)*rotationDir);
        scale(1.0 - lastScale, 1.0 - lastScale);
      } else {
        scale(1.0 - lastScale, 1.0 - lastScale);
      }
    }

    RShape[] splittedGroups = RG.split(shp, constrain( (animTime)/frameRate, -1, 1)); 
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

    if (animTime >= 1.0*frameRate) {
      animTime = 1.0 *frameRate;
      dirInc *= -1;
    }

    if (animTime <= 0) {
      lockAnim = true;
      animTime = 0.0;
      dirInc *= -1;
    }
  }
}
