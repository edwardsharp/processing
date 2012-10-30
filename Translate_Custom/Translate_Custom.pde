
//import files would go here. Processing.star file is imported here.

//defines the variables
float xpos;
float ypos;
final int SQUARE_SIZE = 80;
float dim = 80.0;
float mx;
float my;
PImage Mark;
float ptI;
float ptII;
int x;
int y;


//sets technacalities
void setup() {
  size(800, 450, P2D);
  smooth() ;
  frameRate (40);
  xpos= width/2;
  ypos= height/2;
  Mark= loadImage ("Question.png");
  colorMode(HSB, TWO_PI, 100, 100);
}


void draw() {
  background(188);
  for (int i=0;i<width;i=i+1) {
    fill(i);
    rect(0, 0, 800, 450);
  }


  for(int i = 0; i < 255; i++)
    {
        stroke(width,height);
        line(width,height,i,i);

  image (Mark, ptI, ptII);
  //first two variables in rectange are position, second two are size.
  rect(xpos, ypos, SQUARE_SIZE, SQUARE_SIZE);
    fill(#FFFFFF);
}

 
  }
  // move the objects before this to stop them
  //from flashing with the frame updates.
  void keyPressed()
  {
    if (key == 'w')
    {
      ypos-=8;
      if (ypos < 0)
        ypos = 0;
      redraw ();
    }

    else if (key == 'a')
    {
      xpos-=8;
      if (xpos < 0)
        xpos = 0;
      redraw ();
    }

    else if (key == 's')
    {
      ypos+=8;
      if (ypos > getSize().height - 0 - SQUARE_SIZE)
        ypos = getSize().height - 0 - SQUARE_SIZE;
      redraw ();
    }

    else if (key == 'd')
    {
      xpos+=8;
      if (xpos > getSize().width - 0 - SQUARE_SIZE)
        xpos = getSize().width - 0 - SQUARE_SIZE;
      redraw ();
    }

    else if (key == KeyEvent.VK_UP)
    {
      ptI= ptI+8;
      redraw();
    }
  }

