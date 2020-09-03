class Bkg {

  float alphaLimit;
  float alpha  = 255;
  float dir    = -1;
  float inc;

  boolean activate;

  Bkg(float alphaLimit) {
    this.alphaLimit = alphaLimit;
    inc = 0.7;
    activate  = true;
  }

  void update() {
    if (activate) {
      if (alpha > alphaLimit) {
        alpha = inc * dir;
        //println(alpha);
      } else {
        alpha = alphaLimit;
        activate = false;
      }
    }
  }


  void reset() {
    
  }
  
}
