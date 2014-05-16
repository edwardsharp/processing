int timeStamp;
int timeStampMots;
int valR = 0;
int dutyCycleMod = 10;
int dutyCycleCount = 0;
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
  size(1024,768);
  smooth();
  background(255);
  timeStamp = millis();
  timeStampMots = millis();

}

void draw() {
//  background(255);
  noStroke();

  int tempsEcoule = millis() - timeStamp;
  int tempsEcouleMots = millis() - timeStampMots;
  int tempsRand = int(random(66,1666));
  
  //this probably doesn't ned to be calculated every frame...
  int timeX = (tMots[valR].length() * 66);
//    println(timeX);
    tempsRand = tempsRand + timeX;
    
  if (tempsEcouleMots >= tempsRand) {
    background(255);
    fill(0);
    textSize(66);
    int x = 500;//int(random(0, width-75));
    int y = 266;//int(random(30, height-30));
    
    if(dutyCycleCount % dutyCycleMod == 0){
      valR = int(random(0, tMots.length));
      dutyCycleMod = int(random(8,22));
      println("NEW valR "+valR+" dutyCycleMod "+dutyCycleMod);
    }else{
      valR++;
      if(valR > tMots.length - 1){
        valR = 0;
      }
    }
    dutyCycleCount++;
    if(dutyCycleCount>999999){
      dutyCycleCount = 0;
    }
    text(tMots[valR], x, y);
    
    timeStampMots = millis();
  }
}