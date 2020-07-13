import geomerative.*;


class SwampMap {

  RShape shp;


  SwampMap() {
    //shp = RG.loadShape("test_map.svg");
    shp = RG.loadShape("Biotope_map_out.svg");
   // shp = RG.loadShape("Biotope_map_all.svg");
    
    shp = RG.centerIn(shp, g);
  }

  void draw() {

    noFill();
    stroke(0);
    pushMatrix();
    translate(500, 350);
    scale(0.9, 0.9);

    float t = constrain(map(mouseX, 10, width-10, 0, 1), 0, 1);

    RShape[] splittedGroups = RG.split(shp, 1); 
    splittedGroups[0].draw();
    
    popMatrix();
  }

  void update() {
  }
}
