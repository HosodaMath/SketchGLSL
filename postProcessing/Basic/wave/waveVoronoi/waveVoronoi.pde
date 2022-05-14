// voronoiMaterial
PGraphics voronoiCanvas;
PShader voronoiCloud;

// wave
PShader waveFilter;

void setup() {
  size(1024, 1024, P3D);
  noStroke();
  
  voronoiCanvas = createGraphics(width, height, P3D);

  voronoiCloud = voronoiCanvas.loadShader(
    "./shader/material/cloud/voronoiCloud.frag", 
    "./shader/material/cloud/voronoiCloud.vert"
  );

  waveFilter = loadShader(
    "./shader/postProcessing/wave/wave.frag", 
    "./shader/postProcessing/wave/wave.vert"
  );
}

void createVoronoiCanvas(){
  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float positionX = width * 0.5;
  float positionY = height * 0.5;
  float positionZ = -width + width * 0.5;
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
  float uTime = uFrameCount * 0.05;

  pushMatrix();
  translate(0, 0, 0);
  shader(waveFilter);
  waveFilter.set("uFrequency", uFrequency.x, uFrequency.y);
  waveFilter.set("uAmplitude", uAmplitude.x, uAmplitude.y);
  waveFilter.set("uTime", uTime);
  waveFilter.set("uTexture", voronoiCanvas);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();

  // saveFrame("frames/########.png");
}
