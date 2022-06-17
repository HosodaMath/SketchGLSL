Sketch sketch;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  sketch = new Sketch(width, height);
}

void draw() {
  background(0, 0, 0);

  sketch.start();
  sketch.set();
  sketch.drawStarField();
  sketch.end();
  sketch.sketch();

  saveFrame("./frames/########.png");
  // noLoop();
}
