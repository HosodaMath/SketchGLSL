PShader voronoiShader;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  String vertexShader = "./shader/voronoi/voronoi2.vert";
  String fragmentShader = "./shader/voronoi/voronoi2.frag";
  
  voronoiShader = loadShader(fragmentShader, vertexShader);
}

void draw() {
  background(0, 0, 0);

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float primitiveSize = width * 0.25;
  float sclaeSize = 1;
  pushMatrix();
  translate(width * 0.5, height * 0.5, 0.0);
  scale(sclaeSize);
  rotateX(uFrameCount * 0.01);
  rotateY(uFrameCount * 0.01);
  shader(voronoiShader);
  // voronoiShader.set("uResolution", float(width), float(height));
  voronoiShader.set("uTime", uTime);
  sphere(primitiveSize);
  // box(primitiveSize);
  resetShader();
  popMatrix();

  // saveFrame("frames/#######.png");
}
