int i=0;
void setup() {
  size(400,400);
  frameRate(2);
  smooth();
}
void draw() {
  background(0);
  translate (width/2, height/2);
  hexagon(120);
}
void hexagon(int rad) {
  strokeWeight(6);
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

