public class ParticleEngine {
  // alist to keep track of particles
  private ArrayList particles;
  private ArrayList springs;
  
  //the class constructor
  public ParticleEngine() {
    //create the list
    particles = new ArrayList();
    springs = new ArrayList();
  }
  
  public void addParticle(Particle particle) {
    //public function to add a particle
    particle.setEngine(this);
    particles.add(particle);
  }
  
  public void addSpring(Spring spring) {
    //public function to add a particle
    spring.setEngine(this);
    springs.add(spring);
  }
  
  //update function to update all springs and particles
  public void update() {
    //use a while loop to check all springs
    int i = 0;
    while (i<springs.size()) {
      //update it
      Spring s = (Spring) springs.get(i);
      s.update();
      if (!s.destroyed) {
        //if the particle is still alive, update it
        i++;
      } else {
        //if the particle is not remove it from the list
        springs.remove(i);
      }
    }
    
    i = 0;
    while (i<particles.size()) {
      //update it
      Particle p = (Particle) particles.get(i);
      p.update();
      p.bound();
      
      if (!p.destroyed) {
        //if the particle is still alive, update it
        i++;
      } else {
        //if the particle is not remove it from the list
        particles.remove(i);
      }
    }    
  }
  
  public void colorOn(boolean on){
      int k=0;
      while (k<particles.size()) {
        Particle p = (Particle) particles.get(k);
        if(on){
          p.pColor(true);
          //p.update();
          k++;
        }else{
          p.pColor(false);
         // p.update();
          k++;
      }
    }
  }
  public void unPin(boolean release){
    if(release){
      int k =0;
       while (k<particles.size()) {
        Particle p = (Particle) particles.get(k);
        p.pinned=false;
        p.update();
        k++;
       }
    }
  }
  
  //draw all particles
  public void draw() {
    for (int i=0; i<springs.size(); i++) {
      Spring s = (Spring) springs.get(i);
      s.draw();
    }
    for (int i=0; i<particles.size(); i++) {
      Particle p = (Particle) particles.get(i);
      p.draw();
    }
  }
  
  public Particle particleAt(float x, float y) {
    int i = particles.size();
    while(i>0) {
      i--;
      Particle p = (Particle) particles.get(i);
      float dx = p.x - x;
      float dy = p.y - y;
      if (dx * dx + dy * dy < p.size * p.size) {
        return p;
      }
    }
    return null;
  }
  
  public Particle findParticle(String label) {
    int i = particles.size();
    while(i>0) {
      i--;
      Particle p = (Particle) particles.get(i);
      if (p.label.toLowerCase().equals(label.toLowerCase())) {
        return p;
      }
    }
    return null;
  }
  
  public void connectParticles(String label1, String label2,color c) {
    Particle particle1 = findParticle(label1);
    Particle particle2 = findParticle(label2);
    if (particle1 != null && particle2 != null) {
      addSpring(new Spring(particle1, particle2, 60, 0.02,c));
    }
  } 
  
  
}
