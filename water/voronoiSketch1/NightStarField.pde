class NightStarField {
  private PGraphics canvas;
  private PShader starMaterial;
  public NightStarField(PGraphics canvas, PShader starMaterial){
    this.canvas = canvas;
    this.starMaterial = starMaterial;
  }

  public void draw(){
    int LOOP_MAX = 4;
    this.canvas.shader(starMaterial);
    this.canvas.pushMatrix();
    this.canvas.translate(this.canvas.width * 0.5, this.canvas.height * 0.5, 0.0);
    float starSizeScale = 0;
    float starFieldSizeScale = 0;
    for(int count = 0; count < LOOP_MAX; count++){
      starSizeScale += 0.01;
      starFieldSizeScale += 0.1;
      float radius = canvas.width * starSizeScale;
      float vertexNum = 5;
      float split = 256;
      float starMax = (count + 2) * 5;
      float starFieldSize = canvas.width * starFieldSizeScale;
      StarField starField = new StarField(this.canvas, radius, vertexNum, split, starMax, starFieldSize);
      starField.circle2();
    }
    this.canvas.popMatrix();
    this.canvas.resetShader();
  }
}