// voronoi shader
PGraphics voronoiCanvas;
PShader voronoiShader;
// normal shader
PShader normalShader;
// wave shader
PShader waveSahder;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  voronoiCanvas = createGraphics(width, height, P3D);
  String vertexShader = "./shader/voronoi/voronoi6.vert";
  String fragmentShader = "./shader/voronoi/voronoi6.frag";
  voronoiShader = voronoiCanvas.loadShader(fragmentShader, vertexShader);

  String normalVertexShader = "./shader/material/normal.vert";
  String normalFragmentShader = "./shader/material/normal.frag";
  normalShader = voronoiCanvas.loadShader(normalFragmentShader, normalVertexShader);

  waveSahder = loadShader(
    "shader/postProcessing/wave.frag", 
    "shader/postProcessing/common.vert"
  );

}

void draw() {
  background(0, 0, 0);
  // shader uniform
  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;

  // BackgroundSphere
  PVector position1 = new PVector(width * 0.5, height * 0.5, 0);
  float primitiveSize1 = width * 0.25;
  float sclaeSize = 5;

  voronoiCanvas.beginDraw();
  voronoiCanvas.noStroke();
  // BackgroundSphere
  voronoiCanvas.pushMatrix();
  voronoiCanvas.translate(position1.x, position1.y, position1.z);
  voronoiCanvas.rotateX(uTime * 0.05);
  voronoiCanvas.scale(sclaeSize);
  voronoiCanvas.shader(voronoiShader);
  // voronoiShader.set("uMouse", mousePosX, mousePosY);
  voronoiShader.set("uTime", uTime);
  // voronoiShader.set("uLoopMax", uLoopMax1);
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
