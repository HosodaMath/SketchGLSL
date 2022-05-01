// voronoi shader
PGraphics voronoiCanvas;
PShader voronoiShader;
// wave shader
PShader waveSahder;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  voronoiCanvas = createGraphics(width, height, P3D);
  String vertexShader = "./shader/voronoi/voronoi5.vert";
  String fragmentShader = "./shader/voronoi/voronoi5.frag";
  voronoiShader = voronoiCanvas.loadShader(fragmentShader, vertexShader);

  waveSahder = loadShader(
    "shader/postProcessing/wave.frag", 
    "shader/postProcessing/common.vert"
  );

}

void draw() {
  background(0, 0, 0);
  
  PVector position = new PVector(width * 0.5, height * 0.5, 0);
  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float uLoopMax1 = 10;
  float primitiveSize1 = width * 0.25;
  float sclaeSize = 5;
  float mousePosX = map(mouseX, 0, width, 0, 1.0);
  float mousePosY = map(mouseY, 0, height, 0, 1.0);
  voronoiCanvas.beginDraw();
  voronoiCanvas.noStroke();
  voronoiCanvas.pushMatrix();
  voronoiCanvas.translate(position.x, position.y, position.z);
  voronoiCanvas.scale(sclaeSize);
  voronoiCanvas.shader(voronoiShader);
  voronoiShader.set("uMouse", mousePosX, mousePosY);
  voronoiShader.set("uTime", uTime);
  voronoiShader.set("uLoopMax", uLoopMax1);
  voronoiCanvas.sphere(primitiveSize1);
  voronoiCanvas.resetShader();
  voronoiCanvas.popMatrix();
  voronoiCanvas.endDraw();

  // waveShader
  PVector uFrequency = new PVector(
    map(mouseX, 0, width, -20.0, 20.0), 
    map(mouseY, 0, height, -20.0, 20.0)
  );
  
  PVector uAmplitude = new PVector(
    map(mouseX, 0, width, -0.05, 0.05), 
    map(mouseY, 0, height, -0.05, 0.05)
  );

  float uTime2 = uFrameCount * 0.05;

  pushMatrix();
  translate(0, 0, 0);
  shader(waveSahder);
  waveSahder.set("uTexture", voronoiCanvas);
  waveSahder.set("uTime", uTime2);
  waveSahder.set("uFrequency", uFrequency.x, uFrequency.y);
  waveSahder.set("uAmplitude", uAmplitude.x, uAmplitude.y);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();

  saveFrame("frames/#######.png");
}
