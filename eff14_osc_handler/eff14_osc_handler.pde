/**
 * SIMPLE 
 * 
 * Example displaying values received from
 * the touchOSC "Simple" layout
 * http://hexler.net/touchosc
 *
 */

import oscP5.*;
import netP5.*;
OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(100,100);
  /* start oscP5, listening for incoming messages at port 5000 */
  //239.0.0.1
  oscP5 = new OscP5(this,"eeeeee.local",5000);
  
  myRemoteLocation = new NetAddress("e.local",9000);
}

void handlePush(int p, int v){  
  if (v == 1){
    println("PUSH GOT:"+p+" VAL:"+v);
  }
    
}

void oscEvent(OscMessage theOscMessage) {

    String addr = theOscMessage.addrPattern();
    //.floatValue()
    float  val  = theOscMessage.get(0).floatValue();
    
//    println("GOT ADDR:"+addr+" GOT VAL:"+val);

    if(addr.equals("/1/multitoggle1/1/1"))        { handlePush(1, int(val)); }
    else if(addr.equals("/1/multitoggle1/2/1"))   { handlePush(2, int(val)); }
    else if(addr.equals("/1/multitoggle1/3/1"))   { handlePush(3, int(val)); }
    else if(addr.equals("/1/multitoggle1/4/1"))   { handlePush(4, int(val)); }
    else if(addr.equals("/1/multitoggle1/1/2"))   { handlePush(5, int(val)); }
    else if(addr.equals("/1/multitoggle1/2/2"))   { handlePush(6, int(val)); }
    else if(addr.equals("/1/multitoggle1/3/2"))   { handlePush(7, int(val)); }
    else if(addr.equals("/1/multitoggle1/4/2"))   { handlePush(8, int(val)); }
    else if(addr.equals("/1/multitoggle1/1/3"))   { handlePush(9, int(val)); }
    else if(addr.equals("/1/multitoggle1/2/3"))  { handlePush(10, int(val)); }
    else if(addr.equals("/1/multitoggle1/3/3"))  { handlePush(11, int(val)); }
    else if(addr.equals("/1/multitoggle1/4/3"))  { handlePush(12, int(val)); }
}

void draw() {
    background(0);
}


void mousePressed() {
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
  myOscMessage.add(millis());
  
  /* send the OscMessage to the remote location. 
   */
  OscP5.flush(myOscMessage,myRemoteLocation);
  
  println("SENT MESSAGE!");
}
