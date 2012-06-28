// * 
// * LIQUID CLOCK
// * EDWARD SHARP
// * licensed under a Creative Commons 
// * Attribution-NonCommercial-ShareAlike 3.0 Unported License
// * http://creativecommons.org/licenses/by-nc-sa/3.0/

// S/s - stop (pause) timing
// C/c - reset (clear) to zero

int startTime, displayTime, runningTime;  
boolean running = false;

PFont smallfont;

void draw() {
  touchDraw();
  background(36, 19, 25);
  int thisTime = millis();
  int dHours, dMins, dSecs, dDecimal;
  
  if (running == false) {
    startTime = millis();
    running = true;
  }
      
  if (keyPressed) {
    if ((key == 'c') || (key == 'C')) {
      // clear all the time varz and stop the clock
      runningTime= 0;
      displayTime = 0;
    }
    if ((key == 's') || (key == 'S')) {
      // stop running, but donot clear
      if (running == true) {
        println ("Stopped at " + thisTime);
        running = false;
        runningTime = runningTime + millis() - startTime;
      }
    }
  }
  if (running == true) {
    displayTime = runningTime + millis() - startTime;
  }

  dSecs = (displayTime / 1000) % 60;
  dMins = (displayTime / 1000 / 60) % 60;
  dHours = (displayTime / 1000 / 60/ 60);

  text(nf(dHours, 2) + ":" + nf(dMins, 2) + ":" + nf(dSecs, 2), 
  width/2, height/2 + 40);
}

void setup() {
  touchSetup();
  size(640, 360);
  smooth();
  frameRate(20);
  smallfont = loadFont("LiquidCrystal-128.vlw");
  textFont(smallfont);  
  textSize(128);
  textAlign(CENTER);
  fill(202, 35, 55);
}

