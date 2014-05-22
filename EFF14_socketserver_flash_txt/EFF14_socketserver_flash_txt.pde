/**
 * EFF14
 * a hacky smorgishborg.
 * phew.
 */
import muthesius.net.*;
import org.webbitserver.*;

//OSC
import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;
WebSocketP5 socket1;
WebSocketP5 socket2;
WebSocketP5 socket3;
WebSocketP5 socket4;

//end OSC

int timeStamp;
int timeStampMots;
int valR = 0;
boolean enableDutyCycle = false;
//generate a new random see ever n-lines
int dutyCycleMod = 10;
int dutyCycleCount = 0;
boolean isRunning = false;
boolean enableGlitch = false;
int whichStrArr = 1;

String[] getStrArr(int which, int sub){
  if(which == 1){
    if(sub == 1){
      return tMots1A;
    }else if(sub == 2){
      return tMots1B;
    }else if(sub == 3){
      return tMots1C;
    }else if(sub == 4){
      return tMots1D;
    }else{
      return tMots1A;
    }
  }else if(which == 2){
    return tMots2;
  }else if(which == 3){
    return tMots3;  
  }else{
     return tMots1A;
  }
}

void setup() {
  socket1 = new WebSocketP5(this,8001,"socket1");
  socket2 = new WebSocketP5(this,8002,"socket2");
  socket3 = new WebSocketP5(this,8003,"socket3");
  socket4 = new WebSocketP5(this,8004,"socket4");
  size(800, 600);
  smooth();
  background(255);
  timeStamp = millis();
  timeStampMots = millis();
  
  /* start oscP5, listening for incoming messages at port 5000 */
  //239.0.0.1
  oscP5 = new OscP5(this,"eeeeee.local",5000);
  
  myRemoteLocation = new NetAddress("e.local",9000);

}

void draw() {
  if(isRunning){
  //  background(255);
    noStroke();
  
    int tempsEcoule = millis() - timeStamp;
    int tempsEcouleMots = millis() - timeStampMots;
    int tempsRand = int(random(0,333));
    
    //this probably doesn't ned to be calculated every frame...
    int timeX = (getStrArr(whichStrArr, 1)[valR].length() * 100);
  //    println(timeX);
      tempsRand = tempsRand + timeX;
    
    if (tempsEcouleMots >= tempsRand/2) {
//      background(255);
//     socket1.broadcast(" ");
//     socket2.broadcast(" ");
//     socket3.broadcast(" ");
//     socket4.broadcast(" ");
    }
    
    if (tempsEcouleMots >= tempsRand) {
      background(255);
      fill(0);
      textSize(66);
      int x = 300;//int(random(0, width-75));
      int y = 266;//int(random(30, height-30));
      
      if(enableDutyCycle){
        if(dutyCycleCount % dutyCycleMod == 0){
          valR = int(random(0, getStrArr(whichStrArr,1).length));
          dutyCycleMod = int(random(22,44));
          //background(0);
          //fill(#666666);
          if(enableGlitch){
            for (int i = 0; i < random(2,5); i = i+1) {
              int r=int(random(50));
              if(random(2,10) % 2 == 0){
                if(random(2,10) % 2 == 0){
                  text(getStrArr(whichStrArr,1)[valR], x, y-r-i);
                }else{
                  if(random(2,10) % 2 == 0){
                    text(getStrArr(whichStrArr,1)[valR], x, y+r+i);
                  }else{
                    text(getStrArr(whichStrArr,1)[valR], x, y-r-i);
                  }
                }
              }else{
                text(getStrArr(whichStrArr,1)[valR], x+r+i, y);
              }
            }
          } //enableGlitch
    
          text(getStrArr(whichStrArr,1)[valR], x, y);
          socket1.broadcast(getStrArr(whichStrArr,1)[valR]);
          socket2.broadcast(getStrArr(whichStrArr,2)[valR]);
          socket3.broadcast(getStrArr(whichStrArr,3)[valR]);
          socket4.broadcast(getStrArr(whichStrArr,4)[valR]);
          sendMessage(getStrArr(whichStrArr,1)[valR]);
          
    //      println("NEW valR "+valR+" dutyCycleMod "+dutyCycleMod);
        }else{
          valR++;
          if(valR > getStrArr(whichStrArr,1).length - 1){
            valR = 0;
          }
          text(getStrArr(whichStrArr,1)[valR], x, y);
          socket1.broadcast(getStrArr(whichStrArr,1)[valR]);
          socket2.broadcast(getStrArr(whichStrArr,2)[valR]);
          socket3.broadcast(getStrArr(whichStrArr,3)[valR]);
          socket4.broadcast(getStrArr(whichStrArr,4)[valR]);
          sendMessage(getStrArr(whichStrArr,1)[valR]);
        }
        dutyCycleCount++;
        if(dutyCycleCount>999999){
          dutyCycleCount = 0;
        }
      }else{
        //sort of lazy duplication here...
        valR++;
        if(valR > getStrArr(whichStrArr,1).length - 1){
          valR = 0;
        }
        text(getStrArr(whichStrArr,1)[valR], x, y);
        socket1.broadcast(getStrArr(whichStrArr,1)[valR]);
        socket2.broadcast(getStrArr(whichStrArr,2)[valR]);
        socket3.broadcast(getStrArr(whichStrArr,3)[valR]);
        socket4.broadcast(getStrArr(whichStrArr,4)[valR]);
        sendMessage(getStrArr(whichStrArr,1)[valR]);
      }
      
      
      timeStampMots = millis();
    }
  } //isRunning
}

void keyPressed(){
  
  if(key == 'g' || key == 'G'){
    enableGlitch = !enableGlitch;
  }
  if(key == 'd' || key == 'D'){
    enableDutyCycle = !enableDutyCycle;
  }
  if(key == 't' || key == 'T'){
    sendMessage(millis()+"");
  }
}


void stop(){
  socket1.stop();
  socket2.stop();
  socket3.stop();
  socket4.stop();
}

void mousePressed(){
  handleStartStop();
}

void websocketOnMessage(WebSocketConnection con, String msg){
  println(msg);
}

void websocketOnOpen(WebSocketConnection con){
  println("GOT A JOIN! ");
}

void websocketOnClosed(WebSocketConnection con){
  println("LOST CLIENT! ");
}

void handleStartStop(){
  isRunning = !isRunning;
  socket1.broadcast(" ");
  socket2.broadcast(" ");
  socket3.broadcast(" ");
  socket4.broadcast(" ");
  sendMessage("");
}
// OSC STUFFZ

void handlePush(int p, int v){  
  if (v == 1){
    println("PUSH GOT:"+p+" VAL:"+v);
    whichStrArr = p;
    valR = 0;
  }     
}

void oscEvent(OscMessage theOscMessage) {

    String addr = theOscMessage.addrPattern();
    //.floatValue()
    float  val  = theOscMessage.get(0).floatValue();
    
//    println("GOT ADDR:"+addr+" GOT VAL:"+val);

    if(addr.equals("/1/pushStartStop"))           { if(val==0){handleStartStop();} }
    else if(addr.equals("/1/multitoggle1/1/1"))   { handlePush(1, int(val)); }
    else if(addr.equals("/1/multitoggle1/2/1"))   { handlePush(2, int(val)); }
    else if(addr.equals("/1/multitoggle1/3/1"))   { handlePush(3, int(val)); }
    else if(addr.equals("/1/multitoggle1/4/1"))   { handlePush(4, int(val)); }
    else if(addr.equals("/1/multitoggle1/1/2"))   { handlePush(5, int(val)); }
    else if(addr.equals("/1/multitoggle1/2/2"))   { handlePush(6, int(val)); }
    else if(addr.equals("/1/multitoggle1/3/2"))   { handlePush(7, int(val)); }
    else if(addr.equals("/1/multitoggle1/4/2"))   { handlePush(8, int(val)); }
    else if(addr.equals("/1/multitogglsse1/1/3"))   { handlePush(9, int(val)); }
    else if(addr.equals("/1/multitoggle1/2/3"))   { handlePush(10, int(val)); }
    else if(addr.equals("/1/multitoggle1/3/3"))   { handlePush(11, int(val)); }
    else if(addr.equals("/1/multitoggle1/4/3"))   { handlePush(12, int(val)); }
}


void sendMessage(String msg) {
//  /* create a new osc message object */
//  OscMessage myMessage = new OscMessage("/1/txt");
//
//  myMessage.add("y0!"); /* add a string to the osc message */
//
//  /* send the message */
//  oscP5.send(myMessage, myRemoteLocation); 
  
  /* create a new OscMessage with an address pattern, in this case /test. */
  OscMessage myOscMessage = new OscMessage("/1/txt");
  
  /* add a value (an integer) to the OscMessage */
  myOscMessage.add(msg);
  
  /* send the OscMessage to the remote location. 
   */
  OscP5.flush(myOscMessage,myRemoteLocation);
  
//  println("SENT MESSAGE!");
}
