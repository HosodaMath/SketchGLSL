/*
  色の反転
*/
PShader invertShader;
PImage textureImage;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  invertShader = loadShader(
    "./shader/postProcessing/invert/invert.frag", 
    "./shader/postProcessing/invert/invert.vert"
  );

  textureImage = loadImage("./texture/plants.png");
}

void draw() {
  background(0, 0, 0);

  pushMatrix();
  translate(0, 0, 0);
  shader(invertShader);
  invertShader.set("uTexture", textureImage);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();
  
}

