import geomerative.*;


class SwampMap {

  RShape shp;

  //shape
  float startX = 0;
  float startY = 0;

  float endX = 0;
  float endY = 0;

  RPoint[][] pointPaths;

  float initX = random(0, 300);
  float initY = random(0, 300);

  float shpWidth;
  float shpHeight;


  float maxX = 0;
  float maxY = 0;
  float minX = 9999;
  float minY = 9999;

  SwampMap() {
    //shp = RG.loadShape("test_map.svg");
    shp = RG.loadShape("A01.svg");
    shp = RG.centerIn(shp, g);
    shp.scale(0.2, 0.2, 0.2);

    shpWidth = shp.width;
    shpHeight = shp.height;
    //shp.translate(shp.width/2.0, shp.height/2.0);
    //shp.scale(0.8, 0.8, 0.8);
    // shp = RG.loadShape("Biotope_map_all.svg");

    println("size "+shp.width+" "+shp.height);
    pointPaths = shp.getPointsInPaths();

    int endI = pointPaths.length -1;
    int endJ = pointPaths[endI].length - 1;

    startX = pointPaths[0][0].x;
    startY = pointPaths[0][0].y;

    endX  = pointPaths[endI][endJ].x;
    endY  = pointPaths[endI][endJ].y;


    for (int i = 0; i < endI; i++) {
      for (int j = 0; j < pointPaths[i].length -1; j++) {
        if ( maxX < pointPaths[i][j].x) {
          maxX = pointPaths[i][j].x;
        }
        if ( maxY < pointPaths[i][j].y) {
          maxY = pointPaths[i][j].y;
        }

        if ( minX > pointPaths[i][j].x) {
          minX = pointPaths[i][j].x;
        }

        if ( minY > pointPaths[i][j].y) {
          minY = pointPaths[i][j].y;
        }
      }
    }

    println(maxX);
    println(maxY);
    println(minX);
    println(minY);
  }

  void draw() {

    pushMatrix();
    translate(width/2.0, height/2.0);
    ellipse(shp.width/2.0, shp.height/2.0, 2, 2);
    popMatrix();

    noFill();
    stroke(0);
    pushMatrix();

    translate(width/2.0, height/2.0);



    //translate(mouseX + initX, mouseY + initY);

    noFill();
    stroke(0, 255, 0);
    rect(0, 0, shpWidth, shpHeight);

    noStroke();
    fill(255, 0, 0);
    ellipse(startX, startY, 5, 5);



    fill(0, 0, 255);
    ellipse(endX, endY, 5, 5);

    noFill();
    stroke(0);
    float t = constrain(map(mouseX, 10, width-10, 0, 1), 0, 1);
    
    RPoint[] pts = shp.getBoundsPoints();
    
    for(int i = 0; i<4; i++){
      ellipse(pts[i].x, pts[i].y, 10, 10);
    }
    RPoint center = shp.getCenter();
     ellipse(center.x, center.y, 10, 10);

    RShape[] splittedGroups = RG.split(shp, 1); 
    splittedGroups[0].draw();

    popMatrix();
  }

  void update() {
  }
}
