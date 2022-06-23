class Sketch {
  private PGraphics canvas;
  private int width;
  private int height;
  private PShader starMaterial;
  private PShader waterFilter;
  public Sketch(int width, int height){
    this.canvas = createGraphics(width, height, P3D);
    this.width = width;
    this.height = height;

    String gradationVertexShader = "./shader/material/gradation/gradation1.vert";
    String gradationFragmentShader = "./shader/material/gradation/gradation1.frag";
    this.starMaterial = this.canvas.loadShader(gradationFragmentShader, gradationVertexShader);

    String waterVertexShader = "./shader/filter/water/water1.vert";
    String waterFragmentShader = "./shader/filter/water/water1.frag";
    this.waterFilter = loadShader(waterFragmentShader, waterVertexShader);
  }

  public void start(){
    this.canvas.beginDraw();
  }

  public void set(){
    this.canvas.noStroke();
    this.canvas.background(0, 0, 0);
  }

  public void draw(){

    NightStarField nightStarField = new NightStarField(this.canvas, this.starMaterial);
    nightStarField.draw();

    /*
    // star単体
    float radius = this.canvas.width * 0.1;
    float vertexNum = 5;
    float split = 128;
    Star star = new Star(this.canvas, radius, vertexNum, split);
    this.canvas.shader(this.starMaterial);
    PVector starPosition = new PVector(this.canvas.width * 0.5, this.canvas.height * 0.5, 0.0);
    this.canvas.pushMatrix();
    this.canvas.translate(starPosition.x, starPosition.y, starPosition.z);
    star.shaderColor();
    this.canvas.popMatrix();
    this.canvas.resetShader();
    */
  }

  public void end() {
    this.canvas.endDraw();
  }

  public void sketch(){
    // frequency (-20, 20)
    PVector uFrequency = new PVector(
      map(mouseX, 0, width, -20, 20),
      map(mouseY, 0, height, -20, 20)
    );
  
    // amplitude (-0.05, 0.05)
    PVector uAmplitude = new PVector(
      map(mouseX, 0, width, -0.05, 0.05),
      map(mouseY, 0, height, -0.05, 0.05)
    );

    float uFrameCount = frameCount;
    float uTime = uFrameCount * 0.02;
    float uScale = 0.01;
    shader(this.waterFilter);
    // this.waterFilter.set("uResolution", float(width), float(height));
    this.waterFilter.set("uFrequency", uFrequency.x, uFrequency.y);
    this.waterFilter.set("uAmplitude", uAmplitude.x, uAmplitude.y);
    this.waterFilter.set("uTime", uTime);
    this.waterFilter.set("uScale", uScale);
    this.waterFilter.set("uTexture", this.canvas);
    pushMatrix();
    translate(0, 0, 0);
    rect(0, 0, width, height);
    popMatrix();
    resetShader();
  }
}