/* 
  OffScreenRenderingで描画する  
*/
class Sketch {
  private PGraphics canvas;
  private PShader airShader;
  private PShader starMaterial;
  private PShader textureShader;
  Sketch(int width, int height){
    this.canvas = createGraphics(width, height, P3D);

    this.airShader = this.canvas.loadShader(
      "./shader/material/nightAir.frag", 
      "./shader/material/nightAir.vert"
    );

    this.starMaterial = this.canvas.loadShader(
      "./shader/material/color.frag", 
      "./shader/material/color.vert"
    );

    this.textureShader = loadShader(
      "./shader/filter/handWritten/handWritten.frag", 
      "./shader/filter/handWritten/handWritten.vert"
    );
  }

  public void start(){
    this.canvas.beginDraw();
  }

  public void set(){
    this.canvas.noStroke();
    this.canvas.background(0, 0 ,0);
  }

  public void drawSky(){
    NightSky nightSky = new NightSky(this.canvas, this.airShader);
    nightSky.drawing();
  }

  public void drawStarField() {
    NightStarField starField = new NightStarField(this.canvas, this.starMaterial);
    starField.draw();
  }

  public void end() {
    this.canvas.endDraw();
  }

  public void sketch(){
    pushMatrix();
    translate(0, 0, 0);
    float uScale = map(mouseX, 0, width, 0, 0.005);
    // float uScale = 0.005;
    shader(this.textureShader);
    this.textureShader.set("uScale", uScale);
    this.textureShader.set("uTexture", this.canvas);
    rect(0, 0, width, height);
    popMatrix();
    resetShader();
  }
}