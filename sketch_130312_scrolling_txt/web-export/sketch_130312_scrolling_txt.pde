// An array of news headlines
String[] headlines = {
  "PERMISSION IS A FIRE",
  "", 
  "FILL IT WITH DESIRE",
  "",
  };
 
PFont f;  // Global font variable
float x;  // horizontal location of headline
int index = 0;
 
void setup() {
  size(800,600);
  //f = createFont("Jokerman",72,true); 
   //#TODO: use createFont
  //font = loadFont("SansSerif-100.vlw");
  //textFont(font, 100);
  
  //String[] fontList = PFont.list(); //print out a list of useable fonts
  //println(fontList);
  font = createFont("SansSerif", 500);
  textFont(font);
  
  
  // Initialize headline offscreen to the right
  x = width;
}
 
void draw() {
  background(255);
  fill(4);
 
  // Display headline at x  location
  textFont(font,500);       
  textAlign(LEFT);
  text(headlines[index],x,500);
 
  // Decrement x
  x = x - 3;
 
  // If x is less than the negative width,
  // then it is off the screen
  float w = textWidth(headlines[index]);
  if (x < -w) {
    x = width;
    index = (index + 1) % headlines.length;
  }
}

