/*
  RGB Shift
*/
PShader rgbShiftFilter;
PImage textureImage;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  rgbShiftFilter = loadShader(
    "./shader/postProcessing/rgbShift/rgbShift.frag", 
    "./shader/postProcessing/rgbShift/rgbShift.vert"
  );

  textureImage = loadImage("./texture/plants.png");
}

void draw() {
  background(0, 0, 0);

  PVector uShift = new PVector(
    map(mouseX, 0, width, -0.05, 0.05), 
    map(mouseY, 0, height, -0.05, 0.05)
  );

  pushMatrix();
  translate(0, 0, 0);
  shader(rgbShiftFilter);
  rgbShiftFilter.set("uShift", uShift.x, uShift.y);
  rgbShiftFilter.set("uTexture", textureImage);
  rect(0, 0, width, height);
  resetShader();
  popMatrix();
  
}

