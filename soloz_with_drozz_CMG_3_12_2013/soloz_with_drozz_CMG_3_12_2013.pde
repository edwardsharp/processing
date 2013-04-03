// An array of news strArr
String[] strArr = {
  "A  COGNATE  BROADCASTING  HANDSIGNALS.",
  "||",
  };
 
float x;
PFont font;
int index = 0;
 
void setup() {
  //size(800,600);
  size(displayWidth, displayHeight);
  //String[] fontList = PFont.list(); //print out a list of useable fonts
  //println(fontList);
  font = createFont("SansSerif", 500);
  textFont(font);

  // init text offscreen to the right
  x = width;
}
 
void draw() {
  background(255);
  fill(0);

  textFont(font,836);       
  textAlign(LEFT);
  text(strArr[index],x,600);

  x = x - 50;
 
  // if x is less than the negative width, then it is off the screen
  float w = textWidth(strArr[index]);
  if (x < -w) {
    x = width;
    //mod index stepper
    index = (index + 1) % strArr.length;
  }
}
