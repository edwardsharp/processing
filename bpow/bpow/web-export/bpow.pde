/**
 * http://bpow.org
 * THE BATTERY POWERED ORCHESTRA WORKSHOP
 * BPOW!
 * AUGUST 10 & 11
 * CYMASPACE
 *
 * author: edward sharp
 * year: 2013
 * license: creative commons
 */
 
int x=0;
int displayTxtItems=0;
float s=1;
float y=0;
Array displayTxt;
String txt="";
boolean doOnce=true;
boolean showHelp=true;
void setup(){
  size(1024, 768);
//  sketch_width = window.width;
//  sketch_height = window.height;
//  size(sketch_width, sketch_height);
  smooth();
  noFill();
  loadDisplayStrings();
}

void draw() {
  s=s*1.05;
  if(s>2 && doOnce){
    txt="CLICK!";
    doOnce=false;
    noLoop();
  }
  if(s>8) {
    showHelp=false;
    s=1;
    if(x>displayTxtItems){x=0;}else{x++;}
    txt = displayTxt[x];
  }
  rotate(-s/10);
  scale(s);
  star(9, 100, 145, 250, 150, y, 0.7, txt);
}


void star( int n, float cx, float cy, float w, float h, 
           float startAngle, float proportion, String txt){
  background(color(random(255),random(255),random(255)));
  if (n > 2) {
    float angle = TWO_PI/(2*n);
    float dw; 
    float dh; 
    
    w = w / 2.0;
    h = h / 2.0;
    
    beginShape();
    for (int i = 0; i < 2 * n; i++){
      dw = w;
      dh = h;
      if (i % 2 == 1) {
        // for odd vertices, use short radius
        dw = w * random(0.4, proportion);
        dh = h * random(0.4, proportion);
      }
      vertex(cx + dw * cos(startAngle + angle * i),
        cy + dh * sin(startAngle + angle * i));
    }
    endShape(CLOSE);
    
    fill(50);
    textAlign(CENTER, TOP);
    text(txt, 45, 117, 110, 80);
    fill(255);
    
  }
}

void mousePressed() {
  if(showHelp){
    txt="KEEP GOING!";
  }
  loop();
}
void mouseReleased() {
  noLoop();

}
//
//void keyPressed() {
//  loop();
//}
//void keyReleased() {
//  noLoop();
//}

void loadDisplayStrings() { 
  //zero-zero-based
  displayTxtItems = 10;
  displayTxt = new Array();
  displayTxt.push("REPEAT!");
  displayTxt.push("THE BATTERY\nPOWERED\nORCHESTRA\nWORKSHOP");
  displayTxt.push("BPOW!!!\nAugust 10 & 11\nCymaSpace\n11a - 10p"); 
  displayTxt.push("2-DAY\nELECTRONIC\nARTS\nFESTIVAL");
  displayTxt.push("CELEBRATING\nD.I.Y.\nELECTRONICS");
  displayTxt.push("WORKSHOPS!\nSOLDER!\nCODE! HACK!\nCIRCUIT BEND!"); 
  displayTxt.push("GROUP\nBATTERY\nPOWERED\n JAM SESSION!");
  displayTxt.push("KEYNOTES BY:\nMyles de Bastion &\nJeremy Rotszain");
  displayTxt.push("PERFORMANCES BY: DJ Michael Davis-Yates,");
  displayTxt.push("BomBeat,\nfuturedeathtoll,\nDan Green (4ms),\n");
  displayTxt.push("Catsynth,\nMike Todd,\nMechlo,\nJeph Nor,");
  displayTxt.push("Maps to the Stars,\nClaus Muzak,\nJMEJ, MSHR,\n& OTHERS!");
  displayTxt.push("TICKETS\n AVAILABLE ON\nKICKSTARTER\n(LINKED BELOW)");
}

