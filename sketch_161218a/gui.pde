/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void button1_click1(GButton source, GEvent event) { //_CODE_:button1:673603:
  println("button1 - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:button1:673603:

public void custom_slider1_change1(GCustomSlider source, GEvent event) { //_CODE_:custom_slider1:567031:
  println("custom_slider1 - GCustomSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:custom_slider1:567031:

public void custom_slider2_change1(GCustomSlider source, GEvent event) { //_CODE_:custom_slider2:937876:
  println("custom_slider2 - GCustomSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:custom_slider2:937876:

public void custom_slider3_change1(GCustomSlider source, GEvent event) { //_CODE_:custom_slider3:954166:
  println("custom_slider3 - GCustomSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:custom_slider3:954166:

public void custom_slider4_change1(GCustomSlider source, GEvent event) { //_CODE_:custom_slider4:248540:
  println("custom_slider4 - GCustomSlider >> GEvent." + event + " @ " + millis());
} //_CODE_:custom_slider4:248540:

public void slider2d1_change1(GSlider2D source, GEvent event) { //_CODE_:slider2d1:620214:
  println("slider2d1 - GSlider2D >> GEvent." + event + " @ " + millis());
} //_CODE_:slider2d1:620214:

public void option1_clicked1(GOption source, GEvent event) { //_CODE_:option1:367098:
  println("option1 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:option1:367098:

public void option2_clicked1(GOption source, GEvent event) { //_CODE_:option2:473477:
  println("option2 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:option2:473477:

public void option3_clicked1(GOption source, GEvent event) { //_CODE_:option3:701904:
  println("option3 - GOption >> GEvent." + event + " @ " + millis());
} //_CODE_:option3:701904:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  button1 = new GButton(this, 30, 220, 90, 30);
  button1.setText("FOOBAR");
  button1.setTextBold();
  button1.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  button1.addEventHandler(this, "button1_click1");
  custom_slider1 = new GCustomSlider(this, 190, 260, 100, 40, "purple18px");
  custom_slider1.setShowValue(true);
  custom_slider1.setLimits(0.5, 0.0, 1.0);
  custom_slider1.setShowTicks(true);
  custom_slider1.setNumberFormat(G4P.DECIMAL, 2);
  custom_slider1.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
  custom_slider1.setOpaque(false);
  custom_slider1.addEventHandler(this, "custom_slider1_change1");
  custom_slider2 = new GCustomSlider(this, 190, 180, 100, 40, "grey_blue");
  custom_slider2.setLimits(0.5, 0.0, 1.0);
  custom_slider2.setNumberFormat(G4P.DECIMAL, 2);
  custom_slider2.setOpaque(false);
  custom_slider2.addEventHandler(this, "custom_slider2_change1");
  custom_slider3 = new GCustomSlider(this, 190, 220, 100, 40, "grey_blue");
  custom_slider3.setLimits(0.5, 0.0, 1.0);
  custom_slider3.setNumberFormat(G4P.DECIMAL, 2);
  custom_slider3.setOpaque(false);
  custom_slider3.addEventHandler(this, "custom_slider3_change1");
  custom_slider4 = new GCustomSlider(this, 190, 140, 100, 40, "grey_blue");
  custom_slider4.setLimits(0.5, 0.0, 1.0);
  custom_slider4.setNumberFormat(G4P.DECIMAL, 2);
  custom_slider4.setOpaque(false);
  custom_slider4.addEventHandler(this, "custom_slider4_change1");
  slider2d1 = new GSlider2D(this, 420, 260, 50, 50);
  slider2d1.setLimitsX(0.5, 0.0, 1.0);
  slider2d1.setLimitsY(0.5, 0.0, 1.0);
  slider2d1.setNumberFormat(G4P.DECIMAL, 2);
  slider2d1.setOpaque(true);
  slider2d1.addEventHandler(this, "slider2d1_change1");
  togGroup1 = new GToggleGroup();
  option1 = new GOption(this, 360, 60, 120, 20);
  option1.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  option1.setText("option text");
  option1.setOpaque(false);
  option1.addEventHandler(this, "option1_clicked1");
  option2 = new GOption(this, 360, 80, 120, 20);
  option2.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  option2.setText("option text");
  option2.setOpaque(false);
  option2.addEventHandler(this, "option2_clicked1");
  option3 = new GOption(this, 360, 100, 120, 20);
  option3.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  option3.setText("option text");
  option3.setOpaque(false);
  option3.addEventHandler(this, "option3_clicked1");
  togGroup1.addControl(option1);
  option1.setSelected(true);
  togGroup1.addControl(option2);
  togGroup1.addControl(option3);
  sketchPad1 = new GSketchPad(this, 10, 10, 180, 120);
}

// Variable declarations 
// autogenerated do not edit
GButton button1; 
GCustomSlider custom_slider1; 
GCustomSlider custom_slider2; 
GCustomSlider custom_slider3; 
GCustomSlider custom_slider4; 
GSlider2D slider2d1; 
GToggleGroup togGroup1; 
GOption option1; 
GOption option2; 
GOption option3; 
GSketchPad sketchPad1; 
