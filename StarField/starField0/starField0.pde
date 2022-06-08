Sketch1 sketch1;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  sketch1 = new Sketch1(
    "./shader/filter/handWritten/handWritten.vert", 
    "./shader/filter/handWritten/handWritten.frag"
  );
}

void draw() {
  background(0, 0, 0);
  noLoop();
  
  sketch1.start();
  sketch1.set();
  sketch1.drawAir();
  sketch1.drawStar();
  sketch1.end();
  sketch1.sketch();

  saveFrame("./frames/capture.png");
}
