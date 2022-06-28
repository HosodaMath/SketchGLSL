/*
  Material + PostProcessingの作成
  BoxのシェーダーフィルターはWaterFilter
  SphereのシェーダーマテリアルはCloudMaterial
  逆バージョンなども作成
*/
Sketch sketch;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  sketch = new Sketch(width, height);
  sketch.start();
  sketch.set();
  sketch.createCloud();
  sketch.end();
}

void draw() {
  background(0, 0, 0);

  sketch.sketch();

  // saveFrame("./frames/########.png");
}
