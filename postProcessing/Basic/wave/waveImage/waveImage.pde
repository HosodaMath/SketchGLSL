PShader waveFilter;
PImage textureImage;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  waveFilter = loadShader(
    "./shader/postProcessing/wave/wave.frag", 
    "./shader/postProcessing/wave/wave.vert"
  );

  textureImage = loadImage("./texture/plants.png");
}

void draw() {
  background(0, 0, 0);
  
  PVector uFrequency = new PVector(
    map(mouseX, 0, width, -20, 20), 
    map(mouseY, 0, height, -20, 20)
  );
  
  PVector uAmplitude = new PVector(
    map(mouseX, 0, width, -0.05, 0.05), 
    map(mouseY, 0, height, -0.05, 0.05)
  );

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.05;

  pushMatrix();
  translate(0, 0, 0);
  shader(waveFilter);
  waveFilter.set("uFrequency", uFrequency.x, uFrequency.y);
  waveFilter.set("uAmplitude", uAmplitude.x, uAmplitude.y);
  waveFilter.set("uTime", uTime);
  waveFilter.set("uTexture", textureImage);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();
  
}

