// The Boid class

class Boid {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  boolean sweeper;
  String waveType;
  //audio
  Oscil fm;
  AudioOutput out;
  //filter
  IIRFilter filt;
  Constant cutoff;
  float seed; 
  boolean filtered;
  float freq;
  
  Boid(float x, float y, boolean s, boolean f, String w, float fq) {
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-1,1),random(-1,1));
    location = new PVector(x,y);
    //#TODO: external config.
    float maxr = random(0.9, 1.5);
    r = maxr;
    maxspeed = maxr;
    maxforce = random(0.01, 0.06);
    sweeper=s;
    filtered=f;
    waveType=w;
    freq=fq;
    seed=random(25,100);
    //audio 
   // initialize the minim and out objects
    
    out   = minim.getLineOut();
  
    // make the Oscil we will hear.
    // arguments are frequency, amplitude, and waveform
    Oscil wave = new Oscil( freq, 0.8, Waves.TRIANGLE );
    
    //filter
    // uncoment one of the filters to hear it's effect
    //filt = new LowPassSP(400, out.sampleRate());
    //filt = new LowPassFS(400, out.sampleRate());
    filt = new BandPass(400, 100, out.sampleRate());
    //filt = new HighPassSP(400, out.sampleRate());
    //filt = new NotchFilter(400, 100, out.sampleRate());
    
    // make the Oscil we will use to modulate the frequency of wave.
    // the frequency of this Oscil will determine how quickly the
    // frequency of wave changes and the amplitude determines how much.
    // since we are using the output of fm directly to set the frequency 
    // of wave, you can think of the amplitude as being expressed in Hz.
    //Waves.SINE,Waves.TRIANGLE,Waves.PHASOR,Waves.SAW,Waves.SQUARE,Waves.QUARTERPULSE
    if(waveType=="0"){
      fm   = new Oscil( freq, 2, Waves.SINE );
    }else if(waveType=="1"){
      fm   = new Oscil( freq, 2, Waves.SAW );
    }else if(waveType=="2"){
      fm   = new Oscil( freq, 2, Waves.PHASOR );
    }else if(waveType=="3"){
      fm   = new Oscil( freq, 2, Waves.SAW );
    }else if(waveType=="4"){
      fm   = new Oscil( freq, 2, Waves.SQUARE );
    }else if(waveType=="5"){
      fm   = new Oscil( freq, 2, Waves.QUARTERPULSE );
    }

    
    
    // set the offset of fm so that it generates values centered around 200 Hz
    fm.offset.setLastValue( random(100,500) );
    // patch it to the frequency of wave so it controls it
    // patch the oscil to the cutoff frequency of the filter
    fm.patch(filt.cutoff);
    
    fm.patch( wave.frequency );
    // and patch wave to the output
    wave.patch( out );
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Boid> boids) {
    PVector sep = separate(boids);   // Separation
    PVector ali = align(boids);      // Alignment
    PVector coh = cohesion(boids);   // Cohesion
    // Arbitrarily weight these forces
    //#TODO: external config.
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }

  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }
  
  void render() {
    // Draw a hexagon rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    fill(#ff6600);
    stroke(#ff6600);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    
    strokeWeight(6);
    strokeJoin(ROUND);
    strokeCap(ROUND);
    //noFill();
    stroke(255,102,0);
    beginShape();
    int rad = 20;
     for (int rr=90; rr<=450; rr+=60) {
        vertex (rad*cos(radians(rr)),rad*sin(radians(rr)));
      }
    endShape();
    popMatrix();
  }

  // Wraparound?
  // bounce.
  void borders() {
//    if (location.x < -r) location.x = width+r;
//    if (location.y < -r) location.y = height+r;
//    if (location.x > width+r) location.x = -r;
//    if (location.y > height+r) location.y = -r;
    //acceleration.mult(0.9);
    
//    if (location.x < -r) {velocity.mult(random(-1, -0.5)); }
//    if (location.y < -r) {velocity.mult(random(-1, -0.5));}
//    if (location.x > width+r){ velocity.mult(random(-1, -0.5));}
//    if (location.y > height+r){ velocity.mult(random(-1, -0.5));}
    int buff = 30;
    if (location.x < buff) {velocity.mult(random(-1, -1.5)); playSound("x",location.x); }
    if (location.y < buff ) {velocity.mult(random(-1, -1.5)); playSound("y",location.y);}
    if (location.x > width-buff){ velocity.mult(random(-1, -1.5)); playSound("x",location.x);}
    if (location.y > height-buff){ velocity.mult(random(-1, -1.5)); playSound("y",location.y);}   
    
    if(filtered){
      filt = new BandPass((location.x+location.y), seed, out.sampleRate());
      fm.patch(filt.cutoff);
    }
    
    if(sweeper){
      fm.frequency.setLastValue( location.x );
      fm.amplitude.setLastValue( location.y );
    }
    
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Boid> boids) {
    //#TODO: external config.
    float desiredseparation = 55.0f;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Boid other : boids) {
      float d = PVector.dist(location,other.location);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(location,other.location);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector align (ArrayList<Boid> boids) {
    float neighbordist = 150;
    PVector sum = new PVector(0,0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location,other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum,velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0,0);
    }
  }

  // Cohesion
  // For the average location (i.e. center) of all nearby boids, calculate steering vector towards that location
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 150;
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all locations
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(location,other.location);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.location); // Add location
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the location
    } else {
      return new PVector(0,0);
    }
  }
  
  void playSound(String axis, float pos){
    if(axis=="x"){
      fm.frequency.setLastValue( pos );
    }else{
      fm.amplitude.setLastValue( pos );
    }
     
     
  }
  
  
  void stopSound()
  {

    // always stop Minim before exiting
    //minim.stop();
    out.close();
  }
    
}


