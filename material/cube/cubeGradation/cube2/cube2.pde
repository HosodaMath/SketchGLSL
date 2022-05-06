// cubeCanvas
PGraphics cubeCanvas;
PShader cubeMaterial;
ArrayList<PVector> cubePosition;

// texture
PShader textureShader;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  // cubeCanvas
  cubeCanvas = createGraphics(width, height, P3D);
  cubeMaterial = cubeCanvas.loadShader(
    "./material/color/gradation.frag", 
    "./material/color/gradation.vert"
  );
  cubePosition = getCubePosition(10);

  textureShader = loadShader(
    "./texture/texture.frag", 
    "./texture/texture.vert"
  );
}

void createCubeCanvas(){
  float uFrameCount = frameCount;
  float uTime = uFrameCount * 0.01;
  float size = width * 0.1;
  cubeCanvas.beginDraw();
  cubeCanvas.noStroke();
  cubeCanvas.background(0, 0, 0);
  cubeCanvas.shader(cubeMaterial);
  for(int count = 0; count < cubePosition.size(); count++){
    cubeCanvas.pushMatrix();
    cubeCanvas.translate(
      cubePosition.get(count).x, 
      cubePosition.get(count).y, 
      cubePosition.get(count).z
    );
    cubeCanvas.rotateX(uTime);
    cubeCanvas.rotateY(uTime);
    cubeCanvas.box(size, size, size);
    cubeCanvas.popMatrix();
  }
  cubeCanvas.resetShader();
  cubeCanvas.endDraw();
}

void draw() {
  background(0, 0, 0);

  createCubeCanvas();

  shader(textureShader);
  textureShader.set("uTexture", cubeCanvas);
  pushMatrix();
  translate(0, 0, 0);
  rect(0, 0, width, height);
  popMatrix();
  resetShader();


}
