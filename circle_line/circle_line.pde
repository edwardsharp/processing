/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/33067*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/** Demonstration of circle-line collision with a ball bouncing
 *  off line segments drawn using the mouse.
 *  
 *  Left click and drag to draw new segments. Segments are cleared
 *  each time the mouse is initially pressed. */

// Ball that is always drawn in the center of the screen,
// feels acceleration of gravity and collides with terrain. 
Circle ball;

// List of line segments drawn with the mouse
ArrayList<Line> terrain;

final PVector gravity = new PVector(0, 0.05);

boolean mouseToggled = false;

void setup() {
  size(1280, 720);
  frameRate(60);
  smooth();

  ball = new Circle(0, 0, 20);
  terrain = new ArrayList<Line>();
}

void draw() {
  float translateX = width/2 - ball.loc.x;
  float translateY = height/2 - ball.loc.y;
  translate(translateX, translateY);
  
  if (mouseToggled) {
    PVector clickedPoint = new PVector(mouseX - translateX,
                                       mouseY - translateY);
    PVector lastPoint;
    if (terrain.isEmpty()) {
      lastPoint = clickedPoint;
    } else {
      lastPoint = terrain.get(terrain.size() - 1).b;
    }
    terrain.add(new Line(lastPoint, clickedPoint));
  }
  
  background(0);
  ball.vel.limit(1000);

  ball.draw();
  drawTerrain();

  ball.update();
  ball.vel.add(gravity);

  handleCollisions();
}

void mousePressed() {
  if(mouseToggled){
    terrain.clear();
  }
  mouseToggled = !mouseToggled;
}

/** For each line drawn, test if there is a collision with
 *  ball. If there is, calculate a force vector perpendicular
 *  to the line, with a larger magnitude if the ball is closer
 *  to the line. */
void handleCollisions() {
  for (Line currentLine : terrain) {
    if (collision(ball, currentLine)) {     
      PVector dist_v = normalVector(ball, currentLine);
      
      // Give a slightly stronger force for lines closer to
      // the center of the circle.
      PVector force = PVector.div(dist_v, dist_v.mag());
      force.mult(50 * pow(dist_v.mag(), -1));
      
      // Keep the ball's initial velocity parallel to the line,
      // but replace its velocity perpindicular to the line with
      // the force vector.
      PVector seg = PVector.sub(currentLine.a, currentLine.b);
      ball.vel = PVector.add(project(ball.vel, seg), force);
    }
  }
}

/* Returns the vector perpendicular to the given line that
 * intersects the center of the given circle */
PVector normalVector(Circle c, Line line) {
  PVector pt_v = PVector.sub(c.loc, line.a);
  PVector seg_v = PVector.sub(line.b, line.a);

  PVector proj_v = project(pt_v, seg_v);

  PVector closest;
  if (PVector.angleBetween(proj_v, seg_v) >= 3.14) {
    closest = line.a;
  } else if(proj_v.mag() > seg_v.mag()) {
    closest = line.b;
  } else {
    closest = PVector.add(line.a, proj_v);
  }
  PVector dist_v = PVector.sub(c.loc, closest);
  return dist_v;
}

/** Returns a vector of the projection of 'v' onto 'onto' */
PVector project(PVector v, PVector onto) {
  PVector proj_v = new PVector(onto.x, onto.y);
  proj_v.normalize();
  proj_v.mult(PVector.dot(v, proj_v));
  
  return proj_v;
}

/** Checks for a collisions between a circle and a line
 *  connecting two points */
boolean collision(Circle c, Line line) {
  float dist = normalVector(c, line).mag();
  return dist < c.radius;
}

/** Draws the line segments. Lines that are colliding with the
 *  ball are red, others are white. */
void drawTerrain() { 
  strokeWeight(2);
  stroke(255);  
  for (Line currentLine : terrain) {
    if (collision(ball, currentLine)) {
      stroke(255, 0, 0);
    } else {
      stroke(255);
    }
    line(currentLine.a.x, currentLine.a.y,
         currentLine.b.x, currentLine.b.y);
  }
}

/** Returns true if a line from a to b intersects a line from c to d
 *
 *  See http://compgeom.cs.uiuc.edu/~jeffe/teaching/algorithms/ for a 
 *  good explanation of this algorithm. */
boolean intersect(PVector a, PVector b, PVector c, PVector d) {
  boolean acd = ccw(a, c, d) < 0;
  boolean bcd = ccw(b, c, d) < 0;
  boolean abc = ccw(a, b, c) < 0;
  boolean abd = ccw(a, b, d) < 0;

  return acd != bcd && abc != abd;
}

/** Returns >0 if the three points are in clockwise order, <0 if they
 *  are in counter clockwise order, or 0 if they are collinear. */
float ccw(PVector p1, PVector p2, PVector p3) {
  return (p2.x - p1.x) * (p3.y - p1.y)
       - (p2.y - p1.y) * (p3.x - p1.x);
}