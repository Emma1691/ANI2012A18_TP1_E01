PVector gravity = new PVector(0, 0.2);


class Firework {

  ArrayList<Particle> particles;   
  Particle firework;
  float hu;

  Firework(float x, float y, int state) { 
    hu = random(255);
    firework = new Particle(random(width), height, hu, x, y, state); // New params de plus 
    particles = new ArrayList<Particle>();   
  }
  
  boolean done() {
    if (firework == null && particles.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }

  void run() { 
    if (firework != null) {
      fill(hu,255,255);
      firework.applyForce(gravity);
      firework.update();
      firework.display();

      if (firework.explode()) {
        for (int i = 0; i < 100; i++) {
          particles.add(new Particle(firework.location, hu, firework.curX, firework.curY, firework.curState)); // New params de plus 
        }
        firework = null;
      }
    }

    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.applyForce(gravity);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }
}
