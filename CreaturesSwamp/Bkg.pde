class Bkg {

  float alphaLimit;
  float alpha  = 255;
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
        alpha -= inc;
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
