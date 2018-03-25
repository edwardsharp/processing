var canvas;

function setup() {
  canvas = createCanvas(windowWidth, windowHeight);
}

function draw() {
  background(51);
  fill(255);
  ellipse(windowWidth/2,windowHeight/2,100,100);
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}
