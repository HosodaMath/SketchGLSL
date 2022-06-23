/*
  Materialとして扱うのか？あるいはPostProcessingとして扱うのか
  PostProcessing or Material
  清涼感
*/
Sketch sketch;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  sketch = new Sketch(width, height);
  sketch.start();
  sketch.set();
  sketch.draw();
  sketch.end();
}

void draw() {
  background(0, 0, 0);

  sketch.sketch();

  // saveFrame("./frames/########.png");
}
