class Bkg {

  float alphaLimit;
  float alpha  = 255;
  float dir    = -1;
  float inc;

  boolean activate;
  boolean toogleLoop;

  Bkg(float alphaLimit) {
    this.alphaLimit = alphaLimit;
    inc = 2.0;
    activate  = true;
    toogleLoop = false;
  }

  //------------------------------
  void update() {
    if (activate) {
      if (alpha > alphaLimit) {
        alpha += inc * dir;
       // println(alpha);
      } else {

        alpha = alphaLimit;
        activate = false;
      }
    }

    if (toogleLoop) {
     // println("alpa: "+alpha);
      if (alpha < alphaLimit) {
        alpha += inc * dir;
      }

      if (alpha >= 100) {
        activate = true;
        alpha = 100;
        alphaLimit = 1;
        dir *=-1;
        toogleLoop = false;
        println("turn off alpha toggle");
      }
    }
  }


  void reset() {
    activate = true;
    alpha = 255;
  }

  void toogleDirection() {
    dir *=-1;
    inc = 0.5;
    alphaLimit = 100;
    toogleLoop = true;
  }
}
