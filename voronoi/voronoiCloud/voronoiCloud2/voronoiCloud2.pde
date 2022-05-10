// voronoiMaterial
PGraphics voronoiCanvas;
PShader voronoiCloud;

// waveEffect
PShader waveEffectShader;

void setup() {
  size(1024, 1024, P3D);
  noStroke();
  
  voronoiCanvas = createGraphics(width, height, P3D);

  voronoiCloud = voronoiCanvas.loadShader(
    "./shader/material/cloud/voronoiCloud.frag", 
    "./shader/material/cloud/voronoiCloud.vert"
  );

  waveEffectShader = loadShader(
    "./shader/postProcessing/wave.frag", 
    "./shader/postProcessing/wave.vert"
  );
}

void createVoronoiCanvas(){
  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float positionX = width * 0.5;
  float positionY = height * 0.5;
  float positionZ = -width + cos(uFrameCount * 0.05) * width * 0.5;
  float size = width * 0.5;
  voronoiCanvas.beginDraw();
  voronoiCanvas.background(0, 0, 0);
  voronoiCanvas.noStroke();
  voronoiCanvas.shader(voronoiCloud);
  voronoiCloud.set("uTime", uTime);
  voronoiCanvas.pushMatrix();
  voronoiCanvas.translate(positionX, positionY, positionZ);
  voronoiCanvas.scale(5);
  // voronoiCanvas.rotateX(uTime);
  // voronoiCanvas.rotateY(uTime);
  voronoiCanvas.sphere(size);
  voronoiCanvas.popMatrix();
  voronoiCanvas.resetShader();
  voronoiCanvas.endDraw();
}

void draw() {
  background(0, 0, 0);

  createVoronoiCanvas();

  PVector uFrequency = new PVector(
    map(mouseX, 0, width, -20, 20), 
    map(mouseY, 0, height, -20, 20)
  );

  PVector uAmplitude = new PVector(
    map(mouseX, 0, width, -0.05, 0.05), 
    map(mouseY, 0, height, -0.05, 0.05)
  );

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;

  shader(waveEffectShader);
  waveEffectShader.set("uResolution", float(width), float(height));
  waveEffectShader.set("uFrequency", uFrequency.x, uFrequency.y);
  waveEffectShader.set("uAmplitude", uAmplitude.x, uAmplitude.y);
  waveEffectShader.set("uTime", uTime);
  waveEffectShader.set("uTexture", voronoiCanvas);
  pushMatrix();
  translate(0, 0, 0);
  rect(0, 0, width, height);
  popMatrix();
  resetShader();

  saveFrame("frames/########.png");
}
