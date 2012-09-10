/*
  cam_synth
  an interactive video project performed @ DISJECTA 
  by FUTURE DEATH TOLL
  2012
  CC share-alike
  
  most of the best code here was provided by the 
  flob tracking
  library
 */
 
import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

import promidi.*;

import oscP5.*;
import netP5.*;

Capture video;
Flob flob; 

int tresh = 30;
int fade = 25;
int om = 0;
int videores=128;
int videotex=0;//3
boolean drawimg=true;
boolean showsettings=true;
String info="";
float fps = 6;
PFont font = createFont("monaco",30);

ArrayList blobs;

//MIDI
MidiIO midiIO;
MidiOut midiOut;
Note note;
int midiChan=1;

int blob_size;
int velocity=0;
//int throttle=0;
OscP5 oscP5;
NetAddress myRemoteLocation;
int pushVal, slideVal;

boolean settingsText=false;
String[] linez;
int linezLength;

//TIMER
int startingTime;
int seconds;

//try to send the timer ctrl once per sec.
int lastTime = 0;

void setup(){
  try { quicktime.QTSession.open(); } 
  catch (quicktime.QTException qte) { qte.printStackTrace(); }

  size(800,600);

  frameRate(fps);
  rectMode(CENTER);
  video = new Capture(this, 640,480, 6);  
  flob = new Flob(this, video, width, height);
  flob.setOm(om);
  //  flob.setMirror(true,false); 
  flob.setThresh(tresh);
  flob.setSrcImage(videotex);
    flob.settrackedBlobLifeTime(5);  
  textFont(font);
  
  //MIDI get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  //print a list with all available devices
  midiIO.printDevices();
  //open an midiout using the first device and the first channel
  midiOut = midiIO.getMidiOut(2,2);
  
  //OSC
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  
  //TXT
  linez = loadStrings("stringz.txt");
  linezLength = linez.length;
  println("THERE ARR " + linezLength + " LINEZ");
  
  //TIMER
  startingTime = millis();
}

// overriding PApplet.init() to add a hack of our own
void init() {
 
  // trick to make it possible to change the frame properties
  frame.removeNotify(); 
 
  // comment this out to turn OS chrome back on
  frame.setUndecorated(true); 
 
  // comment this out to not have the window "float"
  frame.setAlwaysOnTop(true); 
 
  //frame.setResizable(true);  
  frame.addNotify(); 
 
  // making sure to call PApplet.init() so that things 
  // get  properly set up.
  super.init();
}

void draw(){
  
  //TIMER
  seconds = (millis() - startingTime) / 1000;
  //int minutes = seconds / 60;
  
  if( millis() - lastTime >= 1000){
    timerActions(true, seconds);
    lastTime = millis();
  }
  
  
  if(video.available()) {
    video.read();
    blobs = flob.track(  flob.binarize(video) );    
  }
  image(flob.getSrcImage(), 0, 0, width, height);
  
  //BLOB OUTLINE
  fill(255,102,0);
  stroke(255,102,0);
  rectMode(CENTER);

  for(int i = 0; i < blobs.size(); i++) {
    //if(i<40){break;}
    trackedBlob tb = flob.getTrackedBlob(i);
      
    int pt = tb.presencetime;
    velocity = pt + 60;
    String txt="";
    if (settingsText) 
    { 
      try 
      {
        if (tb.id < linezLength) 
        {
          //String txt = " ["+tb.id+"]\n"+pt+" ";
          //int z = tb.id;
          //print ("LLL"+linez.length+"LLL");
          //print(linez[tb.id]);
          txt = linez[tb.id];
        }
      } catch (NullPointerException e) 
      {
        //TODO: do something meaningful.
        print("e");
      }
    }
    float velmultiplier = 100.0f;
    fill(255,102,0,100);
    rect(tb.cx,tb.cy,tb.dimx,tb.dimy);
    fill(255,102,0,200);
    rect(tb.cx,tb.cy, 5, 5); 
    fill(0);
    line(tb.cx, tb.cy, tb.cx + tb.velx * velmultiplier ,tb.cy + tb.vely * velmultiplier ); 
    text(txt,tb.cx -tb.dimx*0.10f, tb.cy + 5f);   
      
  }



  // stats
  blob_size = blobs.size();
  fill(255,205,0);
  rectMode(CORNER);
  rect(5,5,flob.getPresencef()*width,10);
  //String stats = ""+frameRate+"\nflob.numblobs: "+blobs.size()+"\nflob.thresh:"+tresh+
  //               " <t/T>"+"\nflob.fade:"+fade+"   <f/F>"+"\nflob.om:"+flob.getOm()+
  //               "\nflob.image:"+videotex+"\nflob.presence:"+flob.getPresencef();
  
  if (showsettings) 
  {
    String stats = "flob.numblobs: " + blob_size
                 + "\nflob.presence:"+flob.getPresencef()
                 +"\nflob.thresh:"+tresh+ " <t/T>"
                 + "\nflob.fade:"+fade+"   <f/F>"
                 + "\nflob.om:"+flob.getOm() + "      <o>"
                 + "\nflob.image:"+videotex + "   <i>"
                 + "\nmidiChan:"+midiChan + "     <m/M>"
                 + "\ntxt:"+settingsText + "      <z>"
                 + "\nreset blobz:" + "<space>"
                 + "\nsec:"+seconds + "      <x>";
                 
    fill(255,205,0);
    text(stats,15,55);
  }
  //MIDI
  if (blob_size>0) 
  {
    playNote();
  } 
  
}

void keyPressed(){
  if(key=='b')
    drawimg^=true;
  if (key=='S')
    saveFrame("monoflob-######.png");
  if (key=='s')
    showsettings=!showsettings;
  if (key=='i'){  
    videotex = (videotex+1)%4;
    flob.setImage(videotex);
  }
  if(key=='t'){
    tresh--;
    flob.setTresh(tresh);
  }
  if(key=='T'){
    tresh++;
    flob.setTresh(tresh);
  }   
  if(key=='f'){
    fade--;
    flob.setFade(fade);
  }
  if(key=='F'){
    fade++;
    flob.setFade(fade);
  }   
  if(key=='o'){
    om^=1;
    flob.setOm(om);
  }   
  if(key==' '){ //space clear flob.background
    flob.setBackground(video);
  }
  //MIDI
  if (key=='m'){
    if (midiChan<1) 
    {
      midiChan=1;
    } else 
    {
      midiChan--;
    }
     //get an instance of MidiIO
    midiIO = MidiIO.getInstance(this);
    //open an midiout using the first device and the first channel
    midiOut = midiIO.getMidiOut(midiChan,2); 
  }
  if (key=='M'){
    midiUp();
  }
  if (key=='z')
  {
    settingsText=!settingsText;
  }
  if (key=='x')
  {
    startingTime = millis();
  }

}

//MIDI
void midiUp() {
  
   if (midiChan>8) 
    {
      midiChan=1;
    } else 
    {
      midiChan++;
    }
    //grab the instance of MidiIO
    midiIO = MidiIO.getInstance(this);
    //open an midiout using the first device and the first channel
    midiOut = midiIO.getMidiOut(midiChan,2); 
    print("NEW MIDI CHAN:"+midiChan);
}
void playNote(){
  /* #TODO
   * localize velocity 
   * more passed arguments with blob info
   * settings to determine which value to switch with
   * BPM-ish control, perhpas just /x round divisions of the framerate?
   */
   
  try 
    {
      switch (blob_size) {
        case 1:  midiOut.sendNote(new Note(velocity,66,66)); break;
        case 2:  midiOut.sendNote(new Note(37,velocity,66)); break;
        case 3:  midiOut.sendNote(new Note(39,velocity,66)); break;
        case 4:  midiOut.sendNote(new Note(44,velocity,66)); break;
        case 5:  midiOut.sendNote(new Note(45,velocity,66)); break;
        case 6:  midiOut.sendNote(new Note(49,velocity,66)); break;
        case 7:  midiOut.sendNote(new Note(44,velocity,66)); break;
        case 8:  midiOut.sendNote(new Note(47,velocity,66)); break;
        case 9:  midiOut.sendNote(new Note(55,velocity,66)); break;
        case 10: midiOut.sendNote(new Note(59,velocity,66)); break;
        case 11: midiOut.sendNote(new Note(44,velocity,66)); break;
        case 12: midiOut.sendNote(new Note(37,velocity,66)); break;
        case 13: midiOut.sendNote(new Note(66,velocity,66)); break;
        case 14: midiOut.sendNote(new Note(77,velocity,66)); break;
        case 15: midiOut.sendNote(new Note(88,velocity,66)); break;
        case 16: midiOut.sendNote(new Note(99,velocity,66)); break;
        case 17: midiOut.sendNote(new Note(36,velocity,66)); break;
        case 18: midiOut.sendNote(new Note(37,velocity,66)); break;
        case 19: midiOut.sendNote(new Note(39,velocity,66)); break;
        case 20: midiOut.sendNote(new Note(40,velocity,66)); break;
        case 21: midiOut.sendNote(new Note(41,velocity,66)); break;
        case 22: midiOut.sendNote(new Note(44,velocity,66)); break;
        case 23: midiOut.sendNote(new Note(45,velocity,66)); break;
        case 24: midiOut.sendNote(new Note(46,velocity,66)); break;
        case 25: midiOut.sendNote(new Note(48,velocity,66)); break;
        case 26: midiOut.sendNote(new Note(49,velocity,66)); break;
        case 27: midiOut.sendNote(new Note(50,velocity,66)); break;
        case 28: midiOut.sendNote(new Note(51,velocity,66)); break;
        case 29: midiOut.sendNote(new Note(51,velocity,66)); break;
        case 30: midiOut.sendNote(new Note(54,velocity,66)); break;
        case 31: midiOut.sendNote(new Note(55,velocity,66)); break;
        case 32: midiOut.sendNote(new Note(57,velocity,66)); break;
        case 33: midiOut.sendNote(new Note(58,velocity,66)); break;
        case 34: midiOut.sendNote(new Note(59,velocity,66)); break;
        case 35: midiOut.sendNote(new Note(60,velocity,66)); break;
        case 36: midiOut.sendNote(new Note(67,velocity,66)); break;
        case 37: midiOut.sendNote(new Note(68,velocity,66)); break;
        case 38: midiOut.sendNote(new Note(69,velocity,66)); break;
        case 39: midiOut.sendNote(new Note(77,velocity,66)); break;
        case 40: midiOut.sendNote(new Note(88,velocity,66)); break;
        default: midiOut.sendNote(new Note(88,velocity,66)); break;
      }

      //print(velocity);
      //print("["+blob_size+"]");
      
    }
    catch (Exception e)
    {
      //#TODO: something meaningful 
      print("e");
    }
} //end playNote


void oscEvent(OscMessage theOscMessage) {
  //theOscMessage.print();
  print(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());

  String[] osc_list = split(theOscMessage.addrPattern(), '/');
  //osc_list[1] == mrmr
  //osc_list[2] == pushbutton  | slider | tactilezoneY | tactilezoneX | tactilezoneTouchDown  
  //osc_list[3] == 36 37 38 39 | horizontal | vertical | 44 | 
  //osc_list[4] == 40 41 42 43 
  //print("OSC_LIST: "+osc_list[2]);
  if(osc_list[1].equals("mrmr") || osc_list[1].equals("1")) 
  {
    print ("TRUE");
    if(osc_list[2].equals("pushbutton") || osc_list[2].equals("push1") ) 
    {
      if (osc_list[3].equals("36")) 
      {
        pushVal = theOscMessage.get(0).intValue();  
        println(" values: "+pushVal);
        if (pushVal>0)
        {
          videotex = (videotex+1)%4;
          flob.setImage(videotex);
        }
        return;
      } else if (osc_list[3].equals("37"))
      {
        pushVal = theOscMessage.get(0).intValue();  
        println(" values: "+pushVal);
        if (pushVal>0)
        {
          flob.setBackground(video);
        }
        return;
      }  else if (osc_list[3].equals("38"))
      {
        pushVal = theOscMessage.get(0).intValue();  
        println(" values: "+pushVal);
        if (pushVal>0) 
        {
          om^=1;
          flob.setOm(om);
        }
        return;
      } else if (osc_list[3].equals("39"))
      {
        pushVal = theOscMessage.get(0).intValue();  
        println(" values: "+pushVal);
        if(pushVal<0) 
        {
          showsettings=!showsettings;
          //println("SAVED!");
        }
        return;
      }
    } else if ( (osc_list[2].equals("slider") && osc_list[3].equals("horizontal"))  )
    {
      if (osc_list[4].equals("40")) 
      {
        slideVal = theOscMessage.get(0).intValue(); 
        println("s["+slideVal+"]");
        flob.setTresh(slideVal);
        return;
      } else if (osc_list[4].equals("41"))
      {
        slideVal = theOscMessage.get(0).intValue(); 
        println("s["+slideVal+"]");
        flob.setFade(slideVal);
      } else if (osc_list[4].equals("42"))
      {
        print("42");
      } else if (osc_list[4].equals("43"))
      {
        print("43");
      }
    } 
  } 
} //end oscEvent

void timerActions(boolean timerToggle, int seconds) {
  switch (seconds) {
    case 0: print("SEC****0");
      break;
    case 1: print("SEC****1");
      break;
    case 2: print("SEC****2");
      break;
    case 10: 
      print("**SEC_10*");
      showsettings=false;
      flob.setBackground(video);
      break;
    case 330: 
      print("**SEC_330*");
      settingsText=true;
      videotex = (videotex+1)%4;
      flob.setImage(videotex);
      flob.setFade(3);
      midiUp();
      break; 
    case 484: 
      print("**SEC_484*");
      settingsText=false;
      flob.setFade(15);
      videotex = (videotex+1)%4;
      flob.setImage(videotex);
      om^=1;
      flob.setOm(om);
      midiUp();
      break; 
    case 1140: 
      print("**SEC_1140*");
      settingsText=true;
      videotex = (videotex+1)%4;
      flob.setImage(videotex);
      flob.setFade(40);
      midiUp();
      break; 
    case 1200: 
      print("**SEC_1200*");
      settingsText=false;
      videotex = (videotex+1)%4;
      flob.setImage(videotex);
      flob.setFade(10);
      midiUp();
      break; 
    case 1470: 
      print("*SEC_1470**");
      settingsText=true;
      videotex = (videotex+1)%4;
      flob.setImage(videotex);
      flob.setFade(40);
      midiUp();
      break; 
    case 1825: 
      print("*SEC_1825**");
      settingsText=false;
      midiUp();
      break;
    default: break;
  } 
}
