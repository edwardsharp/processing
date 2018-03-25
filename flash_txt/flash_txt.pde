/**
 * flash_txt
 * a hacky smorgishborg.
 * flash every word of a txt file in once or random placez.
 * 3dwardsharp
 * http://edwardsharp.net
**/

int timeStamp;
int timeStampMots;
int valR = 0;
int dutyCycleMod = 10;
int dutyCycleCount = 0;

boolean nextTextDraw = true;
boolean randTextDraw = false;

String[] txt_linez;
StringList txt_wordz;
int txt_lines_idx = 0;

void setup() {
  //1024, 768
  //size(1280,1024);
  fullScreen();
  smooth();
  background(0);
  timeStamp = millis();
  timeStampMots = millis();
  txt_linez = loadStrings("death.txt");
  txt_wordz = new StringList();
  
  while(txt_lines_idx < txt_linez.length) {
    String[] piecez = split(txt_linez[txt_lines_idx], ' ');
    for (int i = 0 ; i < piecez.length; i++) {
      txt_wordz.append(piecez[i]);
    }
    txt_lines_idx = txt_lines_idx + 1;
  }

}

void draw() {
  //background(255);
  noStroke();

  int tempsEcouleMots = millis() - timeStampMots;
  int tempsRand = int(random(1,333));
  
  //this probably doesn't ned to be calculated every frame...
  int timeX = (txt_wordz.get(valR).length() * 15);
  //println(timeX);
  tempsRand = tempsRand + timeX;
  
  if (tempsEcouleMots >= tempsRand/2) {
    background(0);
    if (nextTextDraw) { nextText(); }
    if (randTextDraw) { randText(); }
  }
  
}

void keyPressed(){
  
  switch(key) {
    case('n'): nextTextDraw=  !nextTextDraw; break;
    case(' '): nextText(); break;
    case('r'): randTextDraw = !randTextDraw; break;
  }

}

void mousePressed(){
  randText();
}

void nextText(){
    background(0);
    fill(255);
    textSize(150);
    textAlign(CENTER);
    int x = width/2;//100;//int(random(0, width-75));
    int y = height/2;//750;//400;//266;//int(random(30, height-30));
    
    valR++;
    if(valR > txt_wordz.size() - 1){
      valR = 0;
    }
    text(txt_wordz.get(valR), x, y);
    timeStampMots = millis();

}

void randText(){
    //background(0);
    fill(255);
    textSize(66);
    int xx = int(random(0, width-75));//300;//
    int yy = int(random(30, height-30));//266;//
    
    if(dutyCycleCount % dutyCycleMod == 0){
      valR = int(random(0, txt_wordz.size()));
      dutyCycleMod = int(random(22,44));
      text(txt_wordz.get(valR), xx, yy);
    }else{
      valR++;
      if(valR > txt_wordz.size() - 1){
        valR = 0;
      }
      text(txt_wordz.get(valR), xx, yy);
    }
    
    dutyCycleCount++;
    if(dutyCycleCount>999999){
      dutyCycleCount = 0;
    }
    
    timeStampMots = millis();

}