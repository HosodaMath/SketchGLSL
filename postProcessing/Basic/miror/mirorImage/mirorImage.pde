PShader mirorFilter;
PImage textureImage;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  mirorFilter = loadShader(
    "./shader/postProcessing/miror/miror.frag", 
    "./shader/postProcessing/miror/miror.vert"
  );

  textureImage = loadImage("./texture/plants.png");
}

void draw() {
  background(0, 0, 0);

  pushMatrix();
  translate(0, 0, 0);
  shader(mirorFilter);
  mirorFilter.set("uTexture", textureImage);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();
  
}

