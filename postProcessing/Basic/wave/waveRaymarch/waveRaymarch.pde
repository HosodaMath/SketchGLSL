// raymarch
PGraphics raymarchCanvas;
PShader raymarchShader;

// wave
PShader waveFilter;

void setup() {
  size(1024, 1024, P3D);
  noStroke();
  
  raymarchCanvas = createGraphics(width, height, P3D);

  raymarchShader = raymarchCanvas.loadShader(
    "./shader/raymarch/raymarch.frag", 
    "./shader/raymarch/raymarch.vert"
  );

  waveFilter = loadShader(
    "./shader/postProcessing/wave/wave.frag", 
    "./shader/postProcessing/wave/wave.vert"
  );
}

void createRaymarchCanvas(){
  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float positionX = width * 0.5;
  float positionY = height * 0.5;
  float positionZ = 0;
  float size = width * 0.5;
  raymarchCanvas.beginDraw();
  raymarchCanvas.background(0, 0, 0);
  raymarchCanvas.noStroke();
  raymarchCanvas.shader(raymarchShader);
  raymarchShader.set("uResolution", float(raymarchCanvas.width), float(raymarchCanvas.height));
  raymarchShader.set("uTime", uTime);
  raymarchCanvas.pushMatrix();
  raymarchCanvas.translate(positionX, positionY, positionZ);
  raymarchCanvas.scale(5);
  // raymarchCanvas.rotateX(uTime);
  // raymarchCanvas.rotateY(uTime);
  raymarchCanvas.sphere(size);
  // raymarchCanvas.rect(0, 0, raymarchCanvas.width, raymarchCanvas.height);
  raymarchCanvas.popMatrix();
  raymarchCanvas.resetShader();
  raymarchCanvas.endDraw();
}

void draw() {
  background(0, 0, 0);

  createRaymarchCanvas();

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
  waveFilter.set("uTexture", raymarchCanvas);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();

  // saveFrame("frames/########.png");
}
