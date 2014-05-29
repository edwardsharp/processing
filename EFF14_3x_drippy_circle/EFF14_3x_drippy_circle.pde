float resolution = 50; // how many points in the circle
float rad = 215;
float x = 1;
float y = 1;
//float prevX;
//float prevY;
 
float t = 0; // time passed
float tChange = .0009; // how quick time flies
 
float nVal; // noise value
float nInt = 2; // noise intensity
float nAmp = 7; // noise amplitude
 
boolean filled = false;
 
 
void setup() {
  size(1280, 320);
  noiseDetail(8);
  noCursor();
}
 
void draw() {
  background(0);
  
  translate(rad, height/2);
  
  drawWiggleCircle();
  
  translate(width/3, 0);
  drawWiggleCircle();
  
  translate(width/3, 0);
  drawWiggleCircle();
  
}
 
void mouseClicked() {
  filled = !filled; // toggle fill by click
}

void drawWiggleCircle(){
  if (filled) {
    noStroke();
    fill(255);
  }
  else {
    noFill();
    stroke(255);
    strokeWeight(1);
  }
  nInt = map(0, 0, width, 0.1, 30); // map mouseX to noise intensity
  nAmp = map(0, 0, height, 0.0, 1.0); // map mouseY to noise amplitude
 
  beginShape();
  for (float a=0; a<=TWO_PI; a+=TWO_PI/resolution) {
 
    nVal = map(noise( cos(a)*nInt+1, sin(a)*nInt+1, t ), 0.0, 1.0, nAmp, 1.0); // map noise value to match the amplitude
 
    x = cos(a)*rad *nVal;
    y = sin(a)*rad *nVal;
 
    //    x = map(a, 0,TWO_PI, 0,width);
    //    y = sin(a)*rad *nVal +height/2;
 
//    vertex(prevX, prevY);
    vertex(x, y);
 
        line(x,y,x,height);
 
//    prevX = x;
//    prevY = y;
     
    }
  endShape(CLOSE);
 
  t += tChange;
}
