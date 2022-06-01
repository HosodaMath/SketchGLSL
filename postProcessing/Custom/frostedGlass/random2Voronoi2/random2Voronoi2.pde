// voronoiMaterial
PGraphics voronoiCanvas;
PShader voronoi1;

// random
PShader randomFilter;

void setup() {
  size(1024, 1024, P3D);
  noStroke();
  
  voronoiCanvas = createGraphics(width, height, P3D);

  voronoi1 = voronoiCanvas.loadShader(
    "./shader/material/voronoi/voronoi1.frag", 
    "./shader/material/voronoi/voronoi1.vert"
  );

  randomFilter = loadShader(
    "./shader/postProcessing/random2/random2.frag", 
    "./shader/postProcessing/random2/random2.vert"
  );

}

void createVoronoiCanvas(){
  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float positionX = 0;
  float positionY = 0;
  float positionZ = 0;
  voronoiCanvas.beginDraw();
  voronoiCanvas.background(0, 0, 0);
  voronoiCanvas.noStroke();
  voronoiCanvas.shader(voronoi1);
  voronoi1.set("uResolution", float(width), float(height));
  voronoi1.set("uTime", uTime);
  voronoiCanvas.pushMatrix();
  voronoiCanvas.translate(positionX, positionY, positionZ);
  voronoiCanvas.rect(0, 0, voronoiCanvas.width, voronoiCanvas.height);
  voronoiCanvas.popMatrix();
  voronoiCanvas.resetShader();
  voronoiCanvas.endDraw();
}

void draw() {
  background(0, 0, 0);

  createVoronoiCanvas();

  float uScale = map(mouseX, 0, width, 0.0, 0.02);

  pushMatrix();
  translate(0, 0, 0);
  shader(randomFilter);
  randomFilter.set("uScale", uScale);
  randomFilter.set("uTexture", voronoiCanvas);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();

  saveFrame("frames/########.png");
}
