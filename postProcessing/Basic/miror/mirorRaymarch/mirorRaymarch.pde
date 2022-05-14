// raymarch
PGraphics raymarchCanvas;
PShader raymarchShader;

// miror
PShader mirorFilter;

void setup() {
  size(1024, 1024, P3D);
  noStroke();
  
  raymarchCanvas = createGraphics(width, height, P3D);

  raymarchShader = raymarchCanvas.loadShader(
    "./shader/raymarch/raymarch.frag", 
    "./shader/raymarch/raymarch.vert"
  );

  mirorFilter = loadShader(
    "./shader/postProcessing/miror/miror.frag", 
    "./shader/postProcessing/miror/miror.vert"
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

  pushMatrix();
  translate(0, 0, 0);
  shader(mirorFilter);
  mirorFilter.set("uTexture", raymarchCanvas);
  rect(0, 0, width, height);
  // image(raymarchCanvas, 0, 0);
  resetShader();
  popMatrix();

  // saveFrame("frames/########.png");
}
