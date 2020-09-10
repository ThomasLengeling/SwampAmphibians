/*
Noise particle 
 */
class ParticleNoise {

  PVector pos;
  PVector vel;
  PVector acc;
  float   size;
  float   maxforce;   
  float   maxspeed;
  float   angle;
  float   angleIncrement;

  Boolean flowing = true;

  Boolean stopped = false;
  Boolean start = false;

  float   distanceFromCenter = 0;
  int     trembleTime = 0;
  int     index;

  PVector previous = new PVector();
  float   radius   = random(50, 200);
  float   dec      = (200 - radius) * 0.000014;

  //float tilt = random(-60,60);
  float   turnVelocity;

  float   noiseOndulation = 200;
  float   noiseVariation  = 1000;
  float   noiseInterval   = 250;
  float   noiseResistance = 1000;
  float   domeRadius      = 450;

  ArrayList<PVector>   historyPoints;

  int maxHistoryPoints = 600;

  int skipSteps        = 3;
  int incStep = 1;
  int randomSkip = 1;

  ParticleNoise (float _x, float _y, float _maxspeed, float _maxforce, int _index) {
    pos = new PVector(_x, _y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    size   =  4;
    angle  =  0;
    angleIncrement = random(0.005, 0.05);
    maxforce = _maxforce;
    maxspeed = _maxspeed;
    index    = _index;
    // maxHistoryPoints = (int)random(350, 500);
    maxHistoryPoints = (int)random(300, 450);
    historyPoints = new ArrayList<PVector>();
    skipSteps     = (int)random(3, 10.01);

    incStep = (random(1) > 0.10) ? 1 :0;
    randomSkip = (random(1) > 0.90) ? 1 :0;
  }  

  /**
   * Calculates the noise angle in a given position
   * @param      _x      Current position on the x axis
   * @param      _y      Current position on the y axis
   * @return     Float   Noise angle
   */
  float getNoiseAngle(float _x, float _y) {
    return map(noise(_x/noiseOndulation + noiseVariation, _y/noiseOndulation + noiseVariation, frameCount/noiseInterval + noiseVariation), 0, 1, 0, TWO_PI*2);
  }

  /**
   * Sets acceleration to follow the noise flow
   */
  void flow() {
    float noiseAngle = getNoiseAngle(pos.x, pos.y);
    PVector desired = new PVector(cos(noiseAngle)*noiseResistance, sin(noiseAngle)*noiseResistance);
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxforce); 
    applyForce(steer);
  }


  /**
   * Rotates the particle from a given radius
   * @param      _radius    Distance from the center to rotate from
   */
  void circleRotation(float _radius) {
    angle += angleIncrement;
    if (angle >= TWO_PI) angle = 0;
    PVector target = new PVector(width/2 + (_radius * cos(angle)), height/2 + (_radius * sin(angle)));
    PVector desired = PVector.sub(target, pos);
    follow(desired);
  }

  /**
   * Sets the particle acceleration to follow a desired direction
   * @param      _desired    Vector to follow
   */
  void follow(PVector _desired) {
    _desired.normalize();
    _desired.mult(maxspeed);
    PVector steer = PVector.sub(_desired, vel);
    steer.limit(maxforce); 
    applyForce(steer);
  }
  /**
   * Repels or attracts the particles within a distance
   * @param      _x           X coordinate of the magnet center
   * @param      _y           Y coordinate of the magnet center
   * @param      _radius      Distance affected by the magnet effect
   * @param      _strength    Strength of the magnet force
   */
  void magnet(float _x, float _y, float _radius, float _strength) {
    float magnetRadius = _radius;
    PVector target = new PVector(_x, _y);
    PVector force = PVector.sub(target, pos);
    float distance = force.mag();

    if (distance < magnetRadius) {
      flowing = false;
      distance = constrain(distance, 5.0, 25.0);
      force.normalize();
      float strength = 0.00;
      force.mult(strength);        
      applyForce(force);
    } else {
      flowing = true;
    }
  }

  /**
   * Adds a vector to the current acceleration
   * @param      _force    Vector to add 
   */
  void applyForce(PVector _force) {
    acc.add(_force);
  }

  /**
   * Updates the acceleration, velocity and position vectors
   */
  void update() {
    if (!stopped) {
      vel.add(acc);
      vel.limit(maxspeed);
      pos.add(vel);
      acc.mult(0);
    }
  }

  /**
   * Displays the particle on the canvas
   */
  void display() {   

    //int incStep = (int)cp5.getController("stepCounter").getValue();
    if ( incStep != 0) {
      if ( frameCount % skipSteps == 0) { // incStep
        historyPoints.add(new PVector(pos.x, pos.y));
      }

      if (tooggleColor) {
        stroke(0);
      } else {
        stroke(255);
      }
       if(randomSkip == 1){
        skipSteps     = (int)random(3, 6); 
       }
      strokeWeight((int)cp5.getController("strokeWeight").getValue());
      for (int i = 0; i < historyPoints.size()/4.0 - 1; i++) {
        float x1 = historyPoints.get(i*4).x;
        float y1 = historyPoints.get(i*4).y;

        float x2 = historyPoints.get(i*4 + 1).x;
        float y2 = historyPoints.get(i*4 + 1).y;

        line(x1, y1, x2, y2);
        // stroke(0);
        // line(x, y, (int)cp5.getController("strokeWeight").getValue()*2, (int)cp5.getController("strokeWeight").getValue()*2);
      }
      
    } else {
      if (tooggleColor) {
        fill(0);
      } else {
        fill(255);
      }
      noStroke();
      ellipse(pos.x, pos.y, (int)cp5.getController("strokeWeight").getValue()*2, (int)cp5.getController("strokeWeight").getValue()*2);
    }


    if (historyPoints.size() >  maxHistoryPoints) {
      historyPoints.clear();
      println("clean history");
    }
  }

  /**
   * Recursive function that sets a random position to the particle within the dome area
   */
  void position() {
    pos.x = width/2 - ((domeRadius - 15) * cos(random(TWO_PI)));
    pos.y = height/2 - ((domeRadius - 15) * sin(random(TWO_PI)));

    float distance = dist(pos.x, pos.y, width/2, height/2);
    if (distance > domeRadius) position();
  }

  /**
   * Checks whether the particle is going out of bound and sets its position to the opposte side of the dome
   */
  void borders() {
    //float distance = dist(pos.x, pos.y, width/2, height/2);    
    if (pos.x < 0 ) {
      pos.x = width;
      historyPoints.clear();
    } else if (pos.x > width) {
      pos.x = 0;
      historyPoints.clear();
    } else if (pos.y < 0 ) {
      pos.y = height;
      historyPoints.clear();
    } else if (pos.y > height ) {
      pos.x = 0;
      historyPoints.clear();
    }
  }

  /**
   * Calls the functions that run every frame
   */
  void run() {
    update();
    borders();
    display();
  }
}
