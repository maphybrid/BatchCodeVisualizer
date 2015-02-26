public class Particle {
  float dx1, dy1, dz;

  //a reference to the engine
  protected ParticleEngine engine;
  //a position
  public float x;
  public float y;
  // a velocity
  public float velocityX;
  public float velocityY;
  // a gravity
  protected float gravityX;
  protected float gravityY;
  // damping to simulate friction
  protected float damping;
  // color
  protected color col;
  //size
  protected float size;
  // variables to keep track of how long the particle is alive and how long it will live
  protected int life;
  protected int living;

  // flag to indicate whether or not the particle is destroyed
  public boolean destroyed;

  //flag to indicate the particle is being dragged
  public boolean dragged;

  public boolean pinned ;

  public String label; 

  color strk;

  //constructor, set initial variables
  public Particle(String label, float x, float y, float velocityX, float velocityY, int size, color strk) {
    engine = null;
    this.size = size;
    this.label = label; 
    this.x = x;
    this.y = y;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
    this.strk=strk;
    println(label+" is loaded into particle engine");
    gravityX = .2;
    gravityY = .2;
    damping = 0.5;


    //randomize the color
    col = color(242, 242, 242);
    //randomize the size
    size = 30;
    //set life to -1 to live forever
    life = -1;
    living = 0;

    //set flags
    destroyed = false;
    dragged = false;
    pinned = false;
  }

  public void setEngine(ParticleEngine engine) {
    this.engine = engine;
  }

  //a method to set the particles position and velocity
  public void setPos(float x, float y, float velocityX, float velocityY) {
    this.x = x;
    this.y = y;
    this.velocityX = velocityX;
    this.velocityY = velocityY;
  }

  //a method to update the particle (should be called avery frame
  public void update() {
    if (dragged) {
      x = mouseX;
      y = mouseY;
      velocityX =0;
      velocityY =0;
      return;
    }
    if (pinned) {
      velocityX =0;
      velocityY =0;
      return;
    }

    //  pColor(colorCheck);

    //apply gravity
    velocityX += gravityX;
    velocityY += gravityY;
    //apply damping
    velocityX *= damping;
    velocityY *= damping;
    //apply speed
    x += velocityX;
    y += velocityY;
    if (life>0) {
      life--;
      if (life<=0) destroyed = true;
    }
  } 

  public void draw() {
    if (destroyed) return;
    //draw the particle
    stroke(strk);
    strokeWeight(3);
    // use alpha to fade away when life gets low
    fill(col);
    ellipse(x, y, size, size);
    fill(0);
    text(label, x-textWidth(label)*0.5, y+5);
  }

  public void pin(float x, float y) {
    this.x = x;
    this.y = y;
    pinned = true;
  }
  public void pColor(boolean on) {
    if (on) {
      if (x>=100 && x<=300 && y>=50 && y<=250) {
        col=color1;
      } else if (x>300 && x<=500 && y>=50 && y<=250) {
        col=color2;
      } else if (x>100 && x<=300 && y<=451 && y>250) {
        col=color3;
      } else if (x>300 && x<=500 && y<=451 && y>250) {
        col=color4;
      } else {
        col=color(255, 255, 255);
      }
    } else {
      col=color(255);
    }
  }

  public void bound()
  {     
    this.x += dx1;
    this.y += dy1;

    if(x >= width-100) {x = width-100; if(gravityX < 0) {gravityX=abs(gravityX);}else{gravityX=gravityX*-1;}}
    if(x <= 100) {x = 100; if(gravityX < 0) {gravityX=abs(gravityX);}else{gravityX=gravityX*-1;}}
    if(y >= height-50) {y = height-50; if(gravityY < 0) {gravityX=abs(gravityY);}else{gravityY=gravityY*-1;}}
    if(y <= 50) {y = 50; if(gravityY < 0) {gravityY=abs(gravityY);}else{gravityY=gravityY*-1;}}
  }
}

