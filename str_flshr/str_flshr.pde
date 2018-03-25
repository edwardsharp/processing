int timeStamp;
int timeStampMots;
int valR = 0;
int dutyCycleMod = 10;
int dutyCycleCount = 0;
boolean enableGlitch = true;
 

void setup() {
  size(800, 600);
  smooth();
  background(0);
  timeStamp = millis();
  timeStampMots = millis();

}

void draw() {
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
    background(0);
  }
  
  if (tempsEcouleMots >= tempsRand) {
    background(0);
    fill(255);
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
      
//      println("NEW valR "+valR+" dutyCycleMod "+dutyCycleMod);
    }else{
      valR++;
      if(valR > tMots.length - 1){
        valR = 0;
      }
      text(tMots[valR], x, y);
    }
    dutyCycleCount++;
    if(dutyCycleCount>999999){
      dutyCycleCount = 0;
    }
    
    
    timeStampMots = millis();
  }
}

void keyPressed(){
  
  if (key == 'g' || key == 'G') {
    enableGlitch = !enableGlitch;
  } 
}