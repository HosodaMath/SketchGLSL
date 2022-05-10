PShader cloudMaterial;
void setup() {
  size(1024, 1024, P3D);
  noStroke();
  
  cloudMaterial = loadShader(
    "./shader/material/cloud/cloud.frag", 
    "./shader/material/cloud/cloud.vert"
  );
}

void draw() {
  background(0, 0, 0);

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float size = width * 0.5;
  shader(cloudMaterial);
  cloudMaterial.set("uTime", uTime);
  pushMatrix();
  translate(width * 0.5, height * 0.5, -width * 0.5);
  scale(5);
  // rotateX(uTime);
  // rotateY(uTime);
  sphere(size);
  popMatrix();
  resetShader();

  saveFrame("frames/########.png");
}
