int i,x=0;
float y=0;
void setup() {
  size(800,600);
  frameRate(12);
  smooth();
}
void draw() {
  background(0);

//  for (int i = 0; i < 600; i = i+5) {
//    line(0, i, 800, i);
//  }
 y = (y + 0.001);
 
 if( y > 1) y=0;
 for (int i = 0; i < 800; i = i+5) {
   rotate(y);
    for (int j = 0; j < 600; j = j+5) {
      point(i, j);
    }
  }

  
  hexagon(120);
 
}
void hexagon(int rad) {
  
  translate (width/2, height/2);
  strokeJoin(ROUND);
  strokeCap(ROUND);
  noFill();
  stroke(255,102,0);
  beginShape();
  for (int r=90; r<=450; r+=60) {
    vertex (rad*cos(radians(r)),rad*sin(radians(r)));
  }
  endShape();
}

