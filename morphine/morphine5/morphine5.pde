PShader morphineShader;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  morphineShader = loadShader(
    "shader/morphine5.frag", 
    "shader/morphine5.vert"
  );
}

void draw() {
  background(0, 0, 0);

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float uMouseX = map(mouseX, 0, width, 0, 1);
  float uMouseY = map(mouseY, 0, height, 0, 1);
  pushMatrix();
  shader(morphineShader);
  morphineShader.set("uResolution", float(width), float(height));
  morphineShader.set("uMouse", uMouseX, uMouseY);
  morphineShader.set("uTime", uTime);
  translate(0, 0, 0);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();

  saveFrame("frames/######.png");
}
