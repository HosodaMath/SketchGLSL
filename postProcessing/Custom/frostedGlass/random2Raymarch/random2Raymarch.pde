// raymarch
PGraphics raymarchCanvas;
PShader raymarchShader;

// random2
PShader randomFilter;

void setup() {
  size(1024, 1024, P3D);
  noStroke();
  
  raymarchCanvas = createGraphics(width, height, P3D);

  raymarchShader = raymarchCanvas.loadShader(
    "./shader/raymarch/raymarch.frag", 
    "./shader/raymarch/raymarch.vert"
  );

  randomFilter = loadShader(
    "./shader/postProcessing/random2/random2.frag", 
    "./shader/postProcessing/random2/random2.vert"
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

  float uScale = map(mouseX, 0, width, 0.0, 0.05);

  pushMatrix();
  translate(0, 0, 0);
  shader(randomFilter);
  randomFilter.set("uScale", uScale);
  randomFilter.set("uTexture", raymarchCanvas);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();

  // saveFrame("frames/########.png");
}
