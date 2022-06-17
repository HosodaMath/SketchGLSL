class NightStarField {
  private PGraphics canvas;
  private PShader starMaterial;
  public NightStarField(PGraphics canvas, PShader starMaterial){
    this.canvas = canvas;
    this.starMaterial = starMaterial;
  }

  /*
  public void draw(){
    this.canvas.shader(starMaterial);
    this.canvas.pushMatrix();
    this.canvas.translate(this.canvas.width * 0.5, this.canvas.height * 0.5, 0.0);
    for(int degree = 0; degree < 360; degree+=30){
      float radius = canvas.width * 0.025;
      float vertexNum = 5;
      float split = 256;
      float starMax = 50;
      float starFieldSize = canvas.width * 0.01;
      StarField starField = new StarField(this.canvas, radius, vertexNum, split, starMax, starFieldSize);
      this.canvas.pushMatrix();
      this.canvas.translate(x, y, z);
      starField.spiral();
      this.canvas.popMatrix();
    }
    this.canvas.popMatrix();
    this.canvas.resetShader();
  }*/

  public void draw(){
    int LOOP_MAX = 5;
    this.canvas.shader(starMaterial);
    this.canvas.pushMatrix();
    this.canvas.translate(this.canvas.width * 0.5, this.canvas.height * 0.5, 0.0);
    float starSizeScale = 0;
    float starFieldSizeScale = 0;
    for(int count = 0; count < LOOP_MAX; count++){
      starSizeScale += 0.005;
      starFieldSizeScale += 0.005;
      float radius = canvas.width * starSizeScale;
      float vertexNum = (count + 1) * 2;
      float split = 256;
      // 密度が濃くなるだけ
      float starMax = (count + 2) * 5;
      float starFieldSize = canvas.width * starFieldSizeScale;
      StarField starField = new StarField(this.canvas, radius, vertexNum, split, starMax, starFieldSize);
      // starField.circle();
      starField.spiral();
    }
    this.canvas.popMatrix();
    this.canvas.resetShader();
  }
}