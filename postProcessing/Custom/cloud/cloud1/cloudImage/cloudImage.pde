PShader cloudFilter;
PImage textureImage;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  cloudFilter = loadShader(
    "./shader/postProcessing/cloud/cloud1.frag", 
    "./shader/postProcessing/cloud/cloud1.vert"
  );

  textureImage = loadImage("./texture/plants.png");
}

void draw() {
  background(0, 0, 0);

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.005;

  pushMatrix();
  translate(0, 0, 0);
  shader(cloudFilter);
  cloudFilter.set("uTime", uTime);
  cloudFilter.set("uTexture", textureImage);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();
  
  saveFrame("./frames/########.png");
}

