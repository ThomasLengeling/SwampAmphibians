/*
Creature with a particle 
 */


class CreaturesParticle {
  ParticleNoise    particle; 
  Creatures       creature;

  boolean drawCreature = false;

  //time for creation
  float creationTime =0.0;
  float creationInc;

  CreaturesParticle(String name) {
    //set up particle
    particle =  new ParticleNoise(300 * cos(0) + width/2, 300 * sin(0) + height/2, random(0.5, 2), random(0.05, 0.1), 0);
    particle.stopped = false;
    particle.pos.x = random(width);
    particle.pos.y = random(height);

    //create creature
    creature = new Creatures(name);
    
    creationTime  = 0.0;
    creationInc = 0.01;//random(0.0006, 0.0045);
  }
 

  void updateParticle() {
    if (particle.flowing) {
      particle.flow();
    }
    particle.run();
  }

  void draw() {

    if (drawCreature) {
      creature.draw();
      creature.update();
      if (creature.isDone()) {
        drawCreature = false;
        particle.historyPoints.clear();
        creature.resetValues();
      }
    } else {
      updateParticle();
      createCreature();
    }
  }

  void createCreature() {
    creationTime += creationInc;
    if (creationTime >= 1.0) {
      creationTime = 0;
      //particle.flowing = false;
      drawCreature = true;
      creature.reset();
      //particle.historyPoints.clear();
      creature.setPos(particle.pos.x, particle.pos.y);
    }
  }
}
