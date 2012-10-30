import s373.cellularautomata.*;
import processing.opengl.*;

CA2d automata;

// trick to make it possible to change the frame properties
// comment this out to turn OS chrome back on
// comment this out to not have the window "float"
//frame.setResizable(true);  
// making sure to call PApplet.init() so that things 
// get  properly set up.
/*void init() {
  frame.removeNotify(); 
  frame.setUndecorated(true); 
  frame.setAlwaysOnTop(true); 
  frame.addNotify();   
  super.init();
}*/

void setup() { 
  
  frameRate(30);
  size(800,600,OPENGL);
  automata = new CA2d(width,height);
  automata.setRules();
}

void draw() {

  background(0);
  stroke(255,102,0);
  
  automata.update();
  
  for(int j = 0;j<height; j++) {
    for(int i=0; i<width;i++) {
      if(automata.getCell2D(i,j) > 0) {
        point(i,j);
        
      } 
    }
  }
}

void keyPressed(){
   automata.setRules();  
  if(key==' '){
     
   } 
 
}

void mousePressed(){
   automata.setRules(); 
}
