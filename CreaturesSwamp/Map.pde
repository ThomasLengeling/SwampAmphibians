/*

*/
class SwampMap {

  RShape shp;


  SwampMap() {
    shp = RG.loadShape("Biotope_Map_REAL-SIZE.svg");
    //shp = RG.loadShape("Biotope_map_in.svg");
    shp = RG.centerIn(shp, g);
  }

  void draw() {

    noFill();
    stroke(0);
    pushMatrix();
    translate(width/2.0, height/2.0);
    scale(1.0, 1.0);
    
    RShape[] splittedGroups = RG.split(shp, 1.0); 
    splittedGroups[0].draw();
    
    popMatrix();
  }

  void update() {
  }
  
}
