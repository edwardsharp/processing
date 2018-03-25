
var pg;

function setup(){
  createCanvas(windowWidth, windowHeight);
  pg = createGraphics(windowWidth/2, windowHeight/2);
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}

function draw(){
  fill(0, 12);
  rect(0, 0, width, height);
  fill(255);
  noStroke();
  ellipse(mouseX, mouseY, 60, 60);

  pg.background(51);
  pg.noFill();
  pg.stroke(255);
  pg.ellipse(mouseX-150, mouseY-75, 60, 60);

  //Draw the offscreen buffer to the screen with image()
  image(pg, 150, 75);
}