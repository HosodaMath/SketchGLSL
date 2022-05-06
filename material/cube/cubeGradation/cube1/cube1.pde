PShader cubeMaterial;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  cubeMaterial = loadShader(
    "material/color/gradation.frag", 
    "material/color/gradation.vert"
  );
}

void draw() {
  background(0, 0, 0);

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;

  float size = width * 0.25;
  pushMatrix();
  shader(cubeMaterial);
  translate(width * 0.5, height * 0.5, 0);
  rotateX(uTime);
  rotateY(uTime);
  box(size, size, size);
  resetShader();
  popMatrix();
}
