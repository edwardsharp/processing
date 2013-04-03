import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class soloz_with_drozz_CMG_3_12_2013 extends PApplet {

// An array of news strArr
String[] strArr = {
  "A  COGNATE  BROADCASTING  HANDSIGNALS.",
  "||",
  };
 
float x;
PFont font;
int index = 0;
 
public void setup() {
  //size(800,600);
  size(displayWidth, displayHeight);
  //String[] fontList = PFont.list(); //print out a list of useable fonts
  //println(fontList);
  font = createFont("SansSerif", 500);
  textFont(font);

  // init text offscreen to the right
  x = width;
}
 
public void draw() {
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--hide-stop", "soloz_with_drozz_CMG_3_12_2013" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
