PShader randomFilter;
PImage textureImage;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  randomFilter = loadShader(
    "./shader/postProcessing/random2/random2.frag", 
    "./shader/postProcessing/random2/random2.vert"
  );

  textureImage = loadImage("./texture/plants.png");
}

void draw() {
  background(0, 0, 0);

  float uScale = map(mouseX, 0, width, 0.0, 0.05);

  pushMatrix();
  translate(0, 0, 0);
  shader(randomFilter);
  randomFilter.set("uScale", uScale);
  randomFilter.set("uTexture", textureImage);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();
  
  //saveFrame("./frames/########.png");
}

