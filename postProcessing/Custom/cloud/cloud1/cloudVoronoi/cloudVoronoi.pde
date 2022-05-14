/*
  明るすぎてほとんど見えなくなる
*/

// voronoiMaterial
PGraphics voronoiCanvas;
PShader voronoiCloud;

// cloud
PShader cloudFilter;

void setup() {
  size(1024, 1024, P3D);
  noStroke();
  
  voronoiCanvas = createGraphics(width, height, P3D);

  voronoiCloud = voronoiCanvas.loadShader(
    "./shader/material/cloud/voronoiCloud.frag", 
    "./shader/material/cloud/voronoiCloud.vert"
  );

  cloudFilter = loadShader(
    "./shader/postProcessing/cloud/cloud1.frag", 
    "./shader/postProcessing/cloud/cloud1.vert"
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

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.005;

  pushMatrix();
  translate(0, 0, 0);
  shader(cloudFilter);
  cloudFilter.set("uTime", uTime);
  cloudFilter.set("uTexture", voronoiCanvas);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();

  // saveFrame("frames/########.png");
}
