class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float   lifespan;
  
  float curX;     //New
  float curY;     //New
  int   curState; //New 

  boolean seed = false;

  float hu;

  Particle(float x, float y, float h, float x2, float y2, int s) {
    hu = h;

    acceleration = new PVector(0, 0);
    velocity = new PVector(0, random(-16, -5)); //Modifie la puissance. Entre ca et ca
    location =  new PVector(x, y);
    seed = true;
    lifespan = 255.0;
    
    curX = x2;    //new
    curY = y2;    //new
    curState = s; //new
  }

  Particle(PVector l, float h, float x2, float y2, int s) {
    hu = h;
    acceleration = new PVector(0, 0);
    velocity = PVector.random2D();
    velocity.mult(random(4, 8));
    location = l.copy();
    lifespan = 255.0;
    
    curX = x2;    //New
    curY = y2;    //New
    curState = s; //New
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void run() {
    update();
    display();
  }

  boolean explode() {
    if (seed && velocity.y > 0) {
      lifespan = 0;
      return true;
    }
    return false;
  }
 
  void update() {

    velocity.add(acceleration);
    location.add(velocity);
    if (!seed) {
      lifespan -= 5.0;
      velocity.mult(0.95);
    }
    acceleration.mult(0);
  }
  
  void display() 
  {      
    stroke(hu, 255, 255, lifespan); 
    
    if ((curState == BUBBLE_STATE_NORMAL) | (curState == BUBBLE_STATE_MOUSEOVER))
    {       
        if (seed) 
          strokeWeight(3);             
        else 
          strokeWeight(1);             
          
        point(map(location.x, 0, width, curX - 50, curX + 50), map(location.y, 0, height, curY - 50, curY + 50));
    }
    else //curState = BUBBLE_STATE_ZOOMED
    {
        if (seed) 
          strokeWeight(4);             
        else 
          strokeWeight(2);             
          
        point(map(location.x, 0, width, curX - 100, curX + 100), map(location.y, 0, height, curY - 100, curY + 100));
    }    
  }

  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
