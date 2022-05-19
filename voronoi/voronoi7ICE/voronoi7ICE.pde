// voronoi shader
PGraphics voronoiCanvas;
PShader voronoiShader;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  voronoiCanvas = createGraphics(width, height, P3D);
  String vertexShader = "./shader/voronoi/voronoi7.vert";
  String fragmentShader = "./shader/voronoi/voronoi7.frag";
  voronoiShader = voronoiCanvas.loadShader(fragmentShader, vertexShader);

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

  

  pushMatrix();
  translate(0, 0, 0);
  image(voronoiCanvas, 0, 0);
  popMatrix();

  saveFrame("frames/#######.png");
}
