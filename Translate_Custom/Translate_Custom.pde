
//import files would go here. Processing.star file is imported here.

//defines the variables
float xpos;
float ypos;
final int SQUARE_SIZE = 80;
float dim = 80.0;
int squareTop, squareLeft;  // Coordinates of top-left corner of square.
float mx;
float my;
PImage Mark;
float ptI;
float ptII;

//sets technacalities
void setup() {
  size(800, 450, P2D);
  smooth() ;
  colorMode(HSB, TWO_PI, 100, 100);
  frameRate (100);
  xpos= width/2;
  Mark= loadImage ("Question.png");
  ypos= height/2;
}


void draw() {
  background(#00FFFF);
  
   image (Mark, ptI, ptII);
  rect (100, 700, 100, 350); 
  fill(0, 75, 80);
  //first two variables in rectange are position, second two are size.
rect(squareLeft,squareTop,SQUARE_SIZE,SQUARE_SIZE);
  


}
// move the objects before this to stop them from flashing with the key presses.
void keyPressed()
  {
    if (key == 'w')
    {
      squareTop-=8;
if (squareTop < 0)
      squareTop = 0;
      redraw ();
    }

    else if (key == 'a')
    {
      squareLeft-=8;
       if (squareLeft < 0)
      squareLeft = 0;
      redraw ();
    }
    
    else if (key == 's')
    {
      squareTop+=8;
      if (squareTop > getSize().height - 0 - SQUARE_SIZE)
      squareTop = getSize().height - 0 - SQUARE_SIZE;
      redraw ();
    }
    
    else if (key == 'd')
    {
      squareLeft+=8;
      if (squareLeft > getSize().width - 0 - SQUARE_SIZE)
      squareLeft = getSize().width - 0 - SQUARE_SIZE;
      redraw ();
    }
    
    else if (key == KeyEvent.VK_UP)
    {ptI= ptI+8;
    redraw();
    }
   

  }

  
  
