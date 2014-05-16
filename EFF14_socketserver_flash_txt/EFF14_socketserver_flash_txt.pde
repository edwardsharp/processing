import muthesius.net.*;
import org.webbitserver.*;

WebSocketP5 socket;

int timeStamp;
int timeStampMots;
int valR = 0;
int dutyCycleMod = 10;
int dutyCycleCount = 0;
boolean isRunning = false;
boolean enableGlitch = false;
String[] tMots = {
  "obscure", "root", "executable", "header", "the",
  "problem", "with", "universals", "anti-forensics",
  "embedded", "malware", "plastic", "pill", "jars",
  "slamming", "our", "doors", "trapped", "under",
  "the", "rubble", "pile", "the", "boundaries", "as", 
  "my", "own", "emotion", "rocks", "&", "dust", "on", 
  "my", "face", "and", "where", "i", "sleep", "at", 
  "night", "my", "own", "private", "achromatic", 
  "prison", "dark", "alleyways", "and", "elevators", 
  "used", "as", "negotiating", "spaces", "for", 
  "my", "self", "which", "is", "under", "realistic", 
  "scrutiny", "anyway", "personal", "property", 
  "architected", "on", "pleasure", "profit", 
  "principals", "do", "not", "give", "that", "guy",
  "money"
}; 

void setup() {
  socket = new WebSocketP5(this,8080);
  size(800, 600);
  smooth();
  background(255);
  timeStamp = millis();
  timeStampMots = millis();
  

}

void draw() {
  if(isRunning){
  //  background(255);
    noStroke();
  
    int tempsEcoule = millis() - timeStamp;
    int tempsEcouleMots = millis() - timeStampMots;
    int tempsRand = int(random(0,333));
    
    //this probably doesn't ned to be calculated every frame...
    int timeX = (tMots[valR].length() * 44);
  //    println(timeX);
      tempsRand = tempsRand + timeX;
    
    if (tempsEcouleMots >= tempsRand/2) {
      background(255);
     socket.broadcast(" ");
    }
    
    if (tempsEcouleMots >= tempsRand) {
      background(255);
      fill(0);
      textSize(66);
      int x = 300;//int(random(0, width-75));
      int y = 266;//int(random(30, height-30));
      
      if(dutyCycleCount % dutyCycleMod == 0){
        valR = int(random(0, tMots.length));
        dutyCycleMod = int(random(22,44));
        //background(0);
        //fill(#666666);
        if(enableGlitch){
          for (int i = 0; i < random(2,5); i = i+1) {
            int r=int(random(50));
            if(random(2,10) % 2 == 0){
              if(random(2,10) % 2 == 0){
                text(tMots[valR], x, y-r-i);
              }else{
                if(random(2,10) % 2 == 0){
                  text(tMots[valR], x, y+r+i);
                }else{
                  text(tMots[valR], x, y-r-i);
                }
              }
            }else{
              text(tMots[valR], x+r+i, y);
            }
          }
        } //enableGlitch
  
        text(tMots[valR], x, y);
        socket.broadcast(tMots[valR]);
        
  //      println("NEW valR "+valR+" dutyCycleMod "+dutyCycleMod);
      }else{
        valR++;
        if(valR > tMots.length - 1){
          valR = 0;
        }
        text(tMots[valR], x, y);
        socket.broadcast(tMots[valR]);
      }
      dutyCycleCount++;
      if(dutyCycleCount>999999){
        dutyCycleCount = 0;
      }
      
      
      timeStampMots = millis();
    }
  } //isRunning
}

void keyPressed(){
  
  if (key == 'g' || key == 'G') {
    enableGlitch = !enableGlitch;
  } 
}


void stop(){
  socket.stop();
}

void mousePressed(){
  isRunning = !isRunning;
  socket.broadcast(" ");
  println("PRESS");
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
