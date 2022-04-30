PShader voronoiShader;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  String vertexShader = "./shader/voronoi/voronoi3.vert";
  String fragmentShader = "./shader/voronoi/voronoi3.frag";
  
  voronoiShader = loadShader(fragmentShader, vertexShader);
}

void draw() {
  background(0, 0, 0);

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float uLoopMax1 = 10;
  float primitiveSize1 = width * 0.25;
  float sclaeSize = 2;
  float mousePosX = map(mouseX, 0, width, 0, 1.0);
  float mousePosY = map(mouseY, 0, height, 0, 1.0);
  pushMatrix();
  translate(width * 0.5, height * 0.5, -150);
  scale(sclaeSize);
  shader(voronoiShader);
  voronoiShader.set("uMouse", mousePosX, mousePosY);
  voronoiShader.set("uTime", uTime);
  voronoiShader.set("uLoopMax", uLoopMax1);
  sphere(primitiveSize1);
  resetShader();
  popMatrix();

  // saveFrame("frames/#######.png");
}
