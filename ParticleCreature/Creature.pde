class Amphibian {

  RShape shp;
  String fileName;
  String idName;
  int id;

  //animatio
  float animTime = 1.0;
  float animeInc = 0.001;

  boolean lockAnim = false;

  float posX = 0;
  float posY = 0;

  float scX = 1.0;
  float scY = 1.0;

  //shape
  float startX = 0;
  float startY = 0;

  float endX = 0;
  float endY = 0;

  float shpWidth;
  float shpHeight;

  RPoint[][] pointPaths;

  //contructor
  Amphibian(String file) {
    fileName = file;
    println("loading "+fileName);

    shp = RG.loadShape(fileName);
    //shp = RG.centerIn(shp, g);

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

    //translate(500, 500);
    //scale(scX, scY);
    noFill();

    stroke(0, 200);

    float t = constrain(map(mouseX, 10, width-10, 0, 1), 0, 1);
    float w = constrain(map(mouseY, 10, height-10, 1, 15), 1, 15);

    strokeWeight(w);

    RShape[] splittedGroups = RG.split(shp, animTime); 
    splittedGroups[0].draw();

    popMatrix();
  }

  PVector getEnd() {
    return new PVector(posX - endX, posY - endY);
  }

  //draw in a specific location
  void draw() {

    fill(255, 0, 255);
    ellipse(posX, posY, 10, 10);

    fill(0, 255, 0);
    ellipse(endX, endY, 10, 10);

    pushMatrix();

    pointPaths = shp.getPointsInPaths();

    startX = pointPaths[0][0].x;
    startY = pointPaths[0][0].y;

    float dx = dist(startX, 0, posX, 0);
    float dy = dist(0, startY, 0, posY);


    translate(posX - startX, posY - startY);

    fill(255, 0, 0, 200);
    ellipse(0, 0, 10, 10);

    fill(255, 0, 0, 200);
    ellipse(endX, endY, 10, 10);


    //translate(dx, dy);

    //scale(scX, scY);
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

  void reset() {
    animTime = 0;
    lockAnim  = false;
  }

  //animate creation of the Amphibian
  void animate() {
    animTime  -= animeInc;
    if (animTime <= 0.0) {
      lockAnim = true;
      animTime = 0.0;
    } else {
      lockAnim =  false;
    }
  }
}
