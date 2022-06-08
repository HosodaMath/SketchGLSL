class Sketch1 {
  private PGraphics canvas;
  private PShader drawShader;
  private PShader nightAirShader;
  private PShader starShader;
  private StarField starField;
  public Sketch1(String vertexShader, String fragmentShader){
    this.canvas = createGraphics(width, height, P3D);

    nightAirShader = this.canvas.loadShader(
      "./shader/material/nightAir.frag", 
      "./shader/material/nightAir.vert"
    );

    starShader = this.canvas.loadShader(
      "./shader/material/color.frag", 
      "./shader/material/color.vert"
    );

    this.starField = new StarField(this.canvas, this.starShader);

    drawShader = loadShader(fragmentShader, vertexShader);
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
    this.starField.render();
  }

  public void end(){
    this.canvas.endDraw();
  }

  public void sketch(){
    float uScale = 0.005;
    shader(drawShader);
    drawShader.set("uScale", uScale);
    drawShader.set("uTexture", this.canvas);
    pushMatrix();
    translate(0, 0, 0);
    rect(0, 0, width, height);
    popMatrix();
    resetShader();
  }
}