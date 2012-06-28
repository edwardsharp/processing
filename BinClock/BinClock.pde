/**
 * A simple binary clock.
 * ...with a weird set of features
 * 
 * author: edward sharp
 */

Block blk1, blk2;

void setup() {
  size(640, 360);
  
  background(0);
  frameRate(3);
  // cons1ructor, no parameters
  blk1 = new Block();
  //cons1ructor, three parameters
  //blk2 = new Block(width*0.5, height*0.5, 120);
}

void draw() {
  blk1.display();
  //blk2.display();
}

class Block {
  //class varz
  int c_on, c_off;
  int strk = 0;
  int c_bg = 0;
  // defaults?
  
  // #TODO: constructor?
  Block() {
  }
  
  // with parameters
  /*Block(float xpos, float ypos, float r) {
    x = xpos;
    y = ypos;
    radius = r;
  }*/
  void display() {
    // mod 10 the current time into 6 columnz
    int s = second();
    int s0 = s % 10;
    int s1 = (s - s0)/10;
    int m = minute();
    int m0 = m % 10;
    int m1 = (m - m0)/10;
    int h = hour();
    int h0 = h % 10;
    int h1 = (h - h0)/10;
    
        
    
    c_on = #ff6600;
    //c_off = #EDEDED;
    c_off = #000000;
    int rectSize = 100; 
    int iOffset = 90;
    int yRect = 270;
    int xRect0 = 0;
    //#TODO: increment iterator
    //int xRectOffset = 10;
    int xRect1 = 100;
    int xRect2 = 200;
    int xRect3 = 300;
    int xRect4 = 450;
    int xRect5 = 550;
    
    int yBlock = 150;

    
    for (int i=3; i>=0; i--) {
        on (xRect0, yBlock, i);
        if (h1 >= pow(2,i))
            h1 -= pow(2,i);
        else
            fill(c_off);
            
        rect(xRect0,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect1, yBlock, i);
        if (h0 >= pow(2,i))
            h0 -= pow(2,i);
        else
            fill(c_off);
            
        rect(xRect1,yRect-(i*iOffset),rectSize, rectSize);
  
        on (xRect2, yBlock, i);
        if (m1 >= pow(2,i))
            m1 -= pow(2,i);
        else
            fill(c_off);
            
        rect(xRect2,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect3, yBlock, i);
        if (m0 >= pow(2,i))
            m0 -= pow(2,i);
        else
            fill(c_off);
        rect(xRect3,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect4, yBlock, i);
        if (s1 >= pow(2,i))
            s1 -= pow(2,i);
        else
            fill(c_off);
        rect(xRect4,yRect-(i*iOffset),rectSize, rectSize);
 
        on (xRect5, yBlock, i);
        if (s0 >= pow(2,i))
            s0 -= pow(2,i);
        else
            fill(c_off);
        rect(xRect5,yRect-(i*iOffset),rectSize, rectSize);
    }
  }
  
  void on (int xstart, int ystart, int abit) {
    //#TODO: fix 4th param...
    
    //strokeWeight(strk);
    noFill();
    //stroke(c_on);
    
    rect(xstart,ystart-(abit*50),24,24);
    noStroke();
    fill(c_on);
  }

}
