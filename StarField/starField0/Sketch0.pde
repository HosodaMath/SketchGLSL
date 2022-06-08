class Sketch0 {
  private PGraphics canvas;
  private PShader nightAirShader;
  public Sketch0(){
    this.canvas = createGraphics(width, height, P3D);
    nightAirShader = this.canvas.loadShader(
      "./shader/material/nightAir.frag", 
      "./shader/material/nightAir.vert"
    );
  }

  public void start(){
    this.canvas.beginDraw();
  }

  public void set(){
    this.canvas.background(0, 0, 0);
    this.canvas.noStroke();
  }

  public void drawAir(){
    this.canvas.shader(this.nightAirShader);
    this.canvas.pushMatrix();
    this.canvas.translate(0, 0, 0);
    this.canvas.rect(0, 0, this.canvas.width, this.canvas.height);
    this.canvas.popMatrix();
    this.canvas.resetShader();
  }

  public void drawStar() {
    float radius = width * 0.25;
    float vertexNum = 5;
    float split = 256;
    this.canvas.pushMatrix();
    this.canvas.translate(width * 0.5, height * 0.5, 0.0);
    this.canvas.rotate(radians(90));
    Star star = new Star(this.canvas, radius, vertexNum, split);
    star.fillColor(color(240, 240, 100));
    this.canvas.popMatrix();
  }

  public void end(){
    this.canvas.endDraw();
  }

  public void sketch(){
    pushMatrix();
    translate(0, 0, 0);
    image(this.canvas, 0, 0, width, height);
    popMatrix();
  }
}