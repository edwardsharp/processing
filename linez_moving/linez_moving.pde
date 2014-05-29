int a=1280; //sketch size
float s=50; //length of line
float x, y; //start of line
int j = 0; //first "wipe"
int k = 100; //second "wipe"
 
 
void setup() {
  background(20);
  noCursor();
  size(1280,320);
  noStroke();
  frameRate(20);
  
  
}
 
void draw() {
// First attempt: draw "real" noise pixel by pixel.
// Turns out the sketch slows down to 2fps or so.
 
//  for (int i=0;i<=a;i++) {
//    for (int j=0;j<=a;j++) {
//      stroke(random(0,255));
//      point(i,j);
//    }
//  }
   
//   rotate(100);
    for (int i=0;i<=a;i++) {
      stroke(random(0,255));
      strokeWeight(random(0,50));
      x = random(0,a);
      y = random(0,a);
      
//      line(x,y,x+random(0,s),y);
  }
  strokeCap(PROJECT);
  line(0,j,a,j);
  j++;
  if (j>a) {
    j=0;
  }
  strokeWeight(random(0,50));
  strokeCap(PROJECT);
  line(k,0,k,a);
  k++;
  if (k>a) {
    k=int(random(-200,300));
  }
}

