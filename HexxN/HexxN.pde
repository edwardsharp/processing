Flock flock;

//audio

import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
String waveType;    
boolean filtered=false;

void setup() {
  
  int sketch_width = displayWidth;
  int sketch_height = displayHeight;
  //for processingJS
//  sketch_width = screen.width;
//  sketch_height = screen.height;
  //iPhone is 480x320
  
  //orientation(LANDSCAPE);
  
  size(sketch_width, sketch_height);
  
  //audio
  minim = new Minim( this );
  
  //size($(window).width(), $(window).height());
  flock = new Flock();
  // Add an initial set of boids into the system
//  for (int i = 0; i < 1; i++) {
//    flock.addBoid(new Boid(width/2,height/2, false, '0'));
//  }
  
}

void draw() {
  background(0);
//  stroke( 255 );
//  // draw the waveforms
//  for( int i = 0; i < out.bufferSize() - 1; i++ )
//  {
//    // find the x position of each buffer value
//    float x1  =  map( i, 0, out.bufferSize(), 0, width );
//    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
//    // draw a line from one buffer position to the next for both channels
//    //line( x1, 50 + out.left.get(i)*50, x2, 50 + out.left.get(i+1)*50);
//    line( x1, height/2 + out.right.get(i)*50, x2, 150 + out.right.get(i+1)*50);
//  }
  
  
  fill(#ff6600);
  flock.run();
  
  //dragg'r
  noStroke();
    
}

void mousePressed(){
   //new boiiiiid!
   //need to account for 
   
   if( mouseButton == LEFT ) {
     flock.addBoid(new Boid(constrain(mouseX,30,width-30), constrain(mouseY, 30, height-30), true, false, "0",(mouseX+mouseY) ));
   } else if( mouseButton == RIGHT ){
      try{
        Boid b = flock.getBoid(0);
        flock.rmBoid(b);
      }catch(Exception e){
        //ZOMG!
      }
     
   }

}

void keyPressed() {
  String k="false";
  if(key==' '){
    k="0";
  }else if(key=='1'){
    k="1";
  }else if(key=='2'){
    k="2";
  }else if(key=='3'){
    k="3";
  }else if(key=='4'){
    k="4";
  }else if(key=='5'){
    k="5";
  }else if(key=='6'){
    filtered=true;
    k="1";
  }else if(key=='7'){
    filtered=true;
    k="2";
  }else if(key=='8'){
    filtered=true;
    k="3";
  }else if(key=='9'){
    filtered=true;
    k="4";
  }else if(key=='0'){
    filtered=true;
    k="5";
  }
  
  if(key=='f'){
    //gonna filter it!
    filtered=true;
    k="0";
    //k=Float.toString(random(0,4));
  } else {
    filtered=false;
  }

  if(k!="false"){
    flock.addBoid(new Boid(constrain(random(0,width),30,width-30), constrain(random(0,height), 30, height-30), true, filtered, k, random(20,500)));
  }
}
