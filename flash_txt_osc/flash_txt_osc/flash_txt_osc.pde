/**
 * flash_txt_osc
 * a hacky smorgishborg.
 * osc, text, phew.
 * does not work with processing 3 (2.1 is good)
 * 3dwardsharp
 */
 
//OSC
import oscP5.*;
import netP5.*;
OscP5 oscP5;

int timeStamp;
int timeStampMots;
int valR = 0;
int dutyCycleMod = 10;
int dutyCycleCount = 0;
boolean enableGlitch = false;
int whichStrArr = 0;
int randStringArr = 1;
int whichSubMot = 1;

boolean nextTextDraw = false;
boolean randTextDraw = false;

String[] getStrArr(int which, int sub){
  
  
  if(which == 0) {
    return tMots0;
  }else if(which == 1){
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
    if(sub == 1){
      return tMots2A;
    }else if(sub == 2){
      return tMots2B;
    }else if(sub == 3){
      return tMots2C;
    }else if(sub == 4){
      return tMots2D;
    }else{
      return tMots2A;
    }
  }else if(which == 3){
    if(sub == 1){
      return tMots3A;
    }else if(sub == 2){
      return tMots3B;
    }else if(sub == 3){
      return tMots3C;
    }else if(sub == 4){
      return tMots3D;
    }else{
      return tMots3A;
    }  
  }else if(which == 4){
    if(sub == 1){
      return tMots4A;
    }else if(sub == 2){
      return tMots4B;
    }else if(sub == 3){
      return tMots4C;
    }else if(sub == 4){
      return tMots4D;
    }else{
      return tMots4A;
    }  
  }else if(which == 5){
    if(sub == 1){
      return tMots5A;
    }else if(sub == 2){
      return tMots5B;
    }else if(sub == 3){
      return tMots5C;
    }else if(sub == 4){
      return tMots5D;
    }else{
      return tMots5A;
    }  
  }else if(which == 6){
    if(sub == 1){
      return tMots6A;
    }else if(sub == 2){
      return tMots6B;
    }else if(sub == 3){
      return tMots6C;
    }else if(sub == 4){
      return tMots6D;
    }else{
      return tMots6A;
    }  
  }else if(which == 7){
    if(sub == 1){
      return tMots7A;
    }else if(sub == 2){
      return tMots7B;
    }else if(sub == 3){
      return tMots7C;
    }else if(sub == 4){
      return tMots7D;
    }else{
      return tMots7A;
    }  
  }else if(which == 8){
    if(sub == 1){
      return tMots8A;
    }else if(sub == 2){
      return tMots8B;
    }else if(sub == 3){
      return tMots8C;
    }else if(sub == 4){
      return tMots8D;
    }else{
      return tMots8A;
    }  
  }else{
     return tMots1A;
  }
}


void setup() {
  //1024, 768
  //size(1280,1024);
  fullScreen();
  smooth();
  background(0);
  timeStamp = millis();
  timeStampMots = millis();
  
  //eeeeee.local
  oscP5 = new OscP5(this, 11000);
  //oscP5 = new OscP5(this, "127.0.0.1", 22000, OscP5.UDP);
  //oscP5 = new OscP5(this, 11000, OscP5.TCP);
}

void draw() {
//  background(255);
  noStroke();

  int tempsEcoule = millis() - timeStamp;
  int tempsEcouleMots = millis() - timeStampMots;
  int tempsRand = int(random(0,333));
  int timeX = 0;
  
  try{
    timeX = (getStrArr(whichStrArr,whichSubMot)[valR].length() * 44);
  }catch(ArrayIndexOutOfBoundsException exception){
    //o noz! 
  }

    tempsRand = tempsRand + timeX;
  
  if (tempsEcouleMots >= tempsRand/2) {
    background(0);
  }
  
  if (nextTextDraw) { nextText(); }
  if (randTextDraw) { randText(); }
  
}

void keyPressed(){
  
  switch(key) {
    case('0'): whichStrArr = 0; valR = 0; break;
    case('1'): whichStrArr = 1; valR = 0; break;
    case('2'): whichStrArr = 2; valR = 0; break;
    case('3'): whichStrArr = 3; valR = 0; break;
    case('4'): whichStrArr = 4; valR = 0; break;
    case('5'): whichStrArr = 5; valR = 0; break;
    case('6'): whichStrArr = 6; valR = 0; break;
    case('7'): whichStrArr = 7; valR = 0; break;
    case('8'): whichStrArr = 8; valR = 0; break;
    case('!'): whichSubMot = 1; valR = 0; break;
    case('@'): whichSubMot = 2; valR = 0; break;
    case('#'): whichSubMot = 3; valR = 0; break;
    case('$'): whichSubMot = 4; valR = 0; break;
    case('g'): enableGlitch = !enableGlitch; break;
    case('n'): nextText(); break;
    case(' '): nextText(); break;
    case('r'): randText(); break;
  }
  

}

void nextText(){
    nextTextDraw = false;
    //println("nextText whichStrArr:"+whichStrArr+"whichSubMot: "+whichSubMot);
    background(0);
    fill(255);
    textSize(125);
    int x = 50;//int(random(0, width-75));
    int y = 350;//266;//int(random(30, height-30));
    
    //if(dutyCycleCount % dutyCycleMod == 0){
    //  valR = int(random(0, getStrArr(whichStrArr,whichSubMot).length));
    //  dutyCycleMod = int(random(22,44));
    //  text(getStrArr(whichStrArr,whichSubMot)[valR], x, y);
//  //    println("NEW valR "+valR+" dutyCycleMod "+dutyCycleMod);
    //}else{
      valR++;
      if(valR > getStrArr(whichStrArr,whichSubMot).length - 1){
        valR = 0;
      }
      text(getStrArr(whichStrArr,whichSubMot)[valR], x, y);
    //}
    //dutyCycleCount++;
    //if(dutyCycleCount>999999){
    //  dutyCycleCount = 0;
    //}
    
    
    timeStampMots = millis();

}

void randText(){
    randTextDraw = false;
  //println("randText whichStrArr: "+whichStrArr+" whichSubMot: "+whichSubMot);
//    background(0);
    fill(255);
    textSize(66);
    int xx = int(random(0, width-200));//300;//
    int yy = int(random(66, height-100));//266;//
    
    if(dutyCycleCount % dutyCycleMod == 0){
      valR = int(random(0, getStrArr(randStringArr,whichSubMot).length));
      dutyCycleMod = int(random(22,44));
      text(getStrArr(randStringArr,whichSubMot)[valR], xx, yy);
//      println("NEW valR "+valR+" dutyCycleMod "+dutyCycleMod);
    }else{
      valR++;
      if(valR > getStrArr(randStringArr,whichSubMot).length - 1){
        valR = 0;
      }
      text(getStrArr(randStringArr,whichSubMot)[valR], xx, yy);
    }
    dutyCycleCount++;
    if(dutyCycleCount>999999){
      dutyCycleCount = 0;
    }
    
    
    timeStampMots = millis();

}


void oscEvent(OscMessage theOscMessage) {

    String addr = theOscMessage.addrPattern();
    ////.floatValue()
    int  val  = theOscMessage.get(0).intValue();
    
    //println("GOT ADDR:"+addr+" GOT VAL:"+val);
    
//    nextText();
    if(addr.equals("/nextText")){ nextTextDraw = true; }
    else if(addr.equals("/randText")){ randTextDraw = true; }
    else if (addr.equals("/sel1/")){ whichStrArr=val; valR=0; } 
    else if (addr.equals("/sel2/")){ whichSubMot=val; valR=0;} 
}

void mousePressed(){
  randText();
}