
//import files could go here. processing.* file(s) are imported here.

//  note: final means that we can never use = again, like squareSize=100; 
//  also it's capitialized because of this final declaration. 
//  it's probably more correct to use a final VAR style 
//  but i'm trying to keep it consistantly simple, i suppose...
//final int squareSize = 80;
  
//define some variables
float dim;
int squareSize, imgX, imgY, sqrX, sqrY, offset, xPos, yPos;
PImage mark;

//sets technacalities
void setup() 
// it is great habbit (and vistually easing) to make the curly braces line up in a single column!
// remember, the type function declaration above should be at the same tabstop.
{
  size(800, 450, P2D);
  //smooth gives softer edges for better frame-to-frame blending
  smooth();
  colorMode(HSB, TWO_PI, 100, 100);
  //mmm, pie
  frameRate (24);
  //the human eye has a hard time seeing more than 24 FPS

  //initialize some variable values:
  squareSize = 80;
  dim = 80.0;
  imgX=0;
  imgY=0;
  //amount to offset each tiled image, essentialy width of image.
  offset=60;
  xPos= width-100;
  yPos= height-100;
  mark= loadImage ("Question.png");
  
}


void draw() {
  // draw is a loop that runs at the specified frameRate
  
  //set the background every frame update (serveral times per second)
  background(100);
  //draw the question mark a buncha times
  image (mark, imgX, imgY);
  image (mark, imgX+offset*2, imgY);
  image (mark, imgX+offset*4, imgY);
  image (mark, imgX+offset*6, imgY);
  //#TODO: repeat for outside walls.

  // http://processing.org/reference/constrain_.html
  // constrain(amt, low, high)
  sqrX = constrain(sqrX, 100, xPos);
  sqrY = constrain(sqrY, 100, yPos);
  //draw a rectangle that we are going to move with the keyboard

 
  //first two variables in rectange are position, second two are size.
  //rect(edge, edge, width-edge, height-edge);
  rect(sqrX,sqrY,squareSize,squareSize);
   //fill the rectangle with a red color
  fill(0, 75, 80);
}

// move the objects before this to stop them from flashing with the key presses.
void keyPressed() {
    // behold! lined up curly braces make it easier to keep track of opening & closing 
    // if statments... 
    if (key == 'w')
    {
      moveNorth();   
    } else if (key == 'a') //i like to keep else if on the same the same line..
    {
     moveWest();
    } else if (key == 's')
    {
      moveSouth();
    } else if (key == 'd')
    {
     moveEast();
    } else if (key == CODED) 
    {
      //we first have to check if key==CODED to determine if it will be a pre-defined CONSTANT
      // this also helps with press-and-hold issues...
      if (keyCode == UP) 
      {
        moveNorth();
      } else if (keyCode == DOWN) 
      {
        moveSouth();
      } //end if
    } //end if
} //end keyPressed

void moveNorth()
{
  sqrY-=8;
  if (sqrY < 0)
  {
    sqrY = 0;
  }
  redraw ();  
}

void moveSouth()
{
  sqrY+=8;
  //#TODO: re-work this. 
  //if (sqrY > getSize().height - 0 - squareSize)
  //{
  //  sqrY = getSize().height - 0 - squareSize;
  //}
  redraw ();
}

void moveEast() 
{
  sqrX += 8;
  //#TODO: re-work this. 
  //if (sqrX > getSize().width - 0 - squareSize)
  //sqrX = getSize().width - 0 - squareSize;
  redraw ();
}

void moveWest() 
{
   sqrX-=8;
   if (sqrX < 0) 
   {
     sqrX = 0;
   }
  redraw ();
}
  
