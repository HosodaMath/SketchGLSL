PShader voronoiShader;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  String vertexShader = "./shader/voronoi/voronoi1.vert";
  String fragmentShader = "./shader/voronoi/voronoi1.frag";
  
  voronoiShader = loadShader(fragmentShader, vertexShader);
}

void draw() {
  background(0, 0, 0);

  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;

  pushMatrix();
  shader(voronoiShader);
  voronoiShader.set("uResolution", float(width), float(height));
  voronoiShader.set("uTime", uTime);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();
}
