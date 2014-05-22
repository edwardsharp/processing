void setup() {
  size(window.innerWidth, window.innerHeight);
  smooth();
  background(255);
}

void draw() {
//  background(255);
//  frameRate(2);
}

void showTxt(String txt){
  noStroke();
  background(255);
  fill(0);
  textSize(66);
  int x = 0;//int(random(0, width-75));
  int y = 66;//int(random(30, height-30));
  text(txt, x, y);
}

void clearTxt(){
  background(255);
}

void mousePressed(){
  showTxt("ZOMG!");
}
void keyPressed(){
  clearTxt();
}

