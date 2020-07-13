/* --------Inputs-------- */

import geomerative.*;

boolean   ignoringStyles = true;

//AMDO: what language is this??
ArrayList<Particle> particles = new ArrayList<Particle>();

int particleNum = 1;

float magnetRadius = 100;
float rippleRadius = 0;
float equatorRadius = 400;
float domeRadius = 450;

float noiseOndulation = 200;
float noiseVariation = 1000;
float noiseInterval = 250;
float noiseResistance = 1000;

int maxTrembleTime = 20;
int particleSpiral = 0;

Boolean ripple = false;
Boolean rotating = false;
Boolean initializing = false;

boolean stopParticle = false;

ArrayList<PVector> emitters = new ArrayList<PVector>();

//creatures
AmphibianManager ampList;

int ampListInc =0;

//AM: I think each sketch calls this once on init..
void setup() {
  size(1200, 1200); 
  smooth(16);

  RG.init(this);
  RG.ignoreStyles(ignoringStyles);

  ampList = new AmphibianManager();
  //fill Amphibians
  ampList.loadAll();

  for (int i=0; i<particleNum; i++) {
    particles.add(new Particle(domeRadius * cos(0) + width/2, domeRadius * sin(0) + height/2, random(0.5, 2), random(0.05, 0.1), i));
  }

  for (Particle p : particles) {
    p.stopped = false;
    p.pos.x = random(width);
    p.pos.y = random(height);
  }

  background(255);
}

//AM: called many times per second...
void draw() {

  noStroke();
  fill(255, 255);
  rect(0, 0, width, height);

  if (stopParticle) {
    ampList.draw(ampListInc);
    //ampList.drawCenter(ampListInc);
    ampList.update(ampListInc);
  }

  for (PVector e : emitters) {
    particles.add(new Particle(e.x, e.y, random(2, 5), random(0.1, 0.5), frameCount));
  }

  for (Particle p : particles) {
    //if (p.attracting || p.repelling) p.magnet(mouseX, mouseY, magnetRadius, 10);
    if (p.flowing) p.flow();

    if (initializing && particleSpiral > particleNum - 10) {
      initializing = false;
      p.flowing = true;
    } 

    if (millis()%((p.index*5)+1)==0 && !p.start) {
      p.start = true;
    }

    if (rotating) {
      p.flowing = false;
      p.circleRotation(p.distanceFromCenter);
    } else {
      p.flowing = true;
    }

    if (ripple) {
      p.ripple();
    } else {
      p.rippling = false;
      p.ripplingSize = 0;
    }


    if (initializing) {
      p.run();
      initializing = false;
    }
    p.run();
  }

  if (ripple) {
    rippleRadius += 5;
    if (rippleRadius > domeRadius) ripple = false;
  }
}

//AMDO: where is event registered?
void mousePressed() {
  for (Particle p : particles) {
    p.stopped = false;
    p.pos.x = random(width);
    p.pos.y = random(height);
  }

  println(mouseX+" "+mouseY);
}

void keyPressed() {

  if (key == 'w' || key == 'W') {
    ripple = true;
    rippleRadius = 10;
  } 

  if (key == 'C' || key == 'c') {
    rotating = !rotating;
    if (rotating) {
      for (Particle p : particles) {
        p.distanceFromCenter = dist(width/2, height/2, p.pos.x, p.pos.y);
        p.angle = atan2(p.pos.y - height/2, p.pos.x - width/2);
        p.angleIncrement = random(0.005, 0.05);
      }
    }
  }

  if ( key == 'c') {
    stopParticle = true;
    println("stop particle and draw creature");

    float posX = 0;
    float posY = 0;
    
    

    for (Particle p : particles) {
      p.stopped = true;
      posX = p.pos.x;
      posY = p.pos.y;
    }

    ampList.getCreature(ampListInc).setPos(posX, posY);

    // ampList.getCreature(ampListInc).shp.translate(posX, posY);
  }

  //
  if ( key == 'x') {
    stopParticle = false;
    println("start particle and draw creature");

    for (Particle p : particles) {
      p.stopped = false;


      p.pos.x = ampList.getCreature(ampListInc).getEnd().x;
      p.pos.y = ampList.getCreature(ampListInc).getEnd().y;
    }
  }


  if (key == 'r') {
    ampList.reset();
  }

  //
  if (key == 's' || key == 'S') {
    initializing = false;
    for (Particle p : particles) {
      p.flowing = true;
    }
  }
}

class Particle {

  PVector pos;
  PVector vel;
  PVector acc;
  float size;
  float maxforce;   
  float maxspeed;
  float angle;
  float angleIncrement;

  Boolean flowing = true;

  Boolean stopped = false;
  Boolean rippling = false;
  Boolean start = false;

  float ripplingSize = 0;
  float distanceFromCenter = 0;
  float startDistance = domeRadius;
  int trembleTime = 0;
  int index;

  PVector previous = new PVector();
  float radius = random(50, 200);
  float dec = (200 - radius) * 0.000014;
  //float tilt = random(-60,60);
  float turnVelocity;


  Particle (float _x, float _y, float _maxspeed, float _maxforce, int _index) {
    pos = new PVector(_x, _y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    size = 2;
    angle = 0;
    angleIncrement = random(0.005, 0.05);
    maxforce = _maxforce;
    maxspeed = _maxspeed;
    index = _index;
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
   * Maps the particle size according to the distance between its position and the ripple radius
   */
  void ripple() {
    float distance = abs(dist(pos.x, pos.y, width/2, height/2) - rippleRadius);

    if (distance < 50) { 
      rippling = true;
      ripplingSize = map(distance, 50, 0, 0, 7);

      magnet(width/2, height/2, rippleRadius + 25, 10);
    } else {
      rippling = false;
    }
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
   * Particle falls to the closest border of the dome to end the sequence
   */
  void fall() {
    flowing = false;
    magnet(width/2, height/2, domeRadius, 1500);
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
    /* --------Color fill-------- */
    //fill(map(pos.x, width/2 - domeRadius, width/2 + domeRadius, 250, 360), 100, 100);    
    /* --------White fill-------- */
    fill(0);

    noStroke();
    ellipse(pos.x, pos.y, size+ripplingSize, size+ripplingSize);
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
    float distance = dist(pos.x, pos.y, width/2, height/2);    
    if (distance > domeRadius) {
      /* --------Warp particles to a random location-------- */
      //position();

      /* --------Warp particles to opposite side-------- */
      float theta = atan2(pos.y - height/2, pos.x - width/2);
      pos.x = (width/2 + (domeRadius * cos(theta + PI)));
      pos.y = (height/2 + (domeRadius * sin(theta + PI)));
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
