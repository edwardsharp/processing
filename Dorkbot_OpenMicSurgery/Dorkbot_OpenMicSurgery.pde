/*
 * A simple sketch that draws bitwise calculations of midi note pitches
 * used in a demonstration for "Open Mic Surgery" for the DorkBotPDX meeting.
 *
 * author: edward sharp
 * git: https://github.com/edwardsharp/
 * license: creative-commons
 */
 
import promidi.*;
MidiIO midiIO;

int w=800, sx=0, x, y, z, pit;

void setup() {
  size(w, w, P2D);
  
  //get an instance of MidiIO
  midiIO = MidiIO.getInstance(this);
  println("printPorts of midiIO");
  midiIO.printDevices();
  midiIO.openInput(0, 0);
} 

void draw() {
  
  for (background(y=0);y++<w;) {
    for (x=0;x++<w;) {
      // "~" is a unary operator that returns a bitwise complement
      // "&" is a bitwise AND
      //print(~get(x&pit, y&pit));
      set(y, x, ~get(x&pit, y&pit));
    }
  }
}

void noteOn(Note note, int deviceNumber, int midiChannel) {
  int vel = note.getVelocity();
  pit = note.getPitch();
  //print(pit);
}

void controllerIn(Controller controller, int deviceNumber, int midiChannel) {
  int num = controller.getNumber();
  int val = controller.getValue();
}

void mousePressed(){
  //this is just for the satisfaction of those who do 
  // not feel like hooking up a midi device...
  pit = mouseX;
}

