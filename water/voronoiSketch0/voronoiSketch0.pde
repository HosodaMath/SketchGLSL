PShader mainShader;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  String vertexShader = "./shader/material/voronoiWater.vert";
  String fragmentShader = "./shader/material/voronoiWater.frag";
  mainShader = loadShader(fragmentShader, vertexShader);

}

void draw() {
  background(0, 0, 0);

  // frequency (-20, 20)
  PVector uFrequency = new PVector(
    map(mouseX, 0, width, -20, 20),
    map(mouseY, 0, height, -20, 20)
  );
  
  // amplitude (-0.05, 0.05)
  PVector uAmplitude = new PVector(
    map(mouseX, 0, width, -0.05, 0.05),
    map(mouseY, 0, height, -0.05, 0.05)
  );

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.02;
  float uScale = 0.01;
  shader(mainShader);
  mainShader.set("uResolution", float(width), float(height));
  mainShader.set("uFrequency", uFrequency.x, uFrequency.y);
  mainShader.set("uAmplitude", uAmplitude.x, uAmplitude.y);
  mainShader.set("uTime", uTime);
  mainShader.set("uScale", uScale);
  pushMatrix();
  translate(0, 0, 0);
  rect(0, 0, width, height);
  popMatrix();
  resetShader();

}
