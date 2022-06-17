class NightStarField {
  private PGraphics canvas;
  private PShader starMaterial;
  public NightStarField(PGraphics canvas, PShader starMaterial){
    this.canvas = canvas;
    this.starMaterial = starMaterial;
  }

  public void draw(){
    ArrayList<StarFieldParameter> data = starFieldData(this.canvas, 4);
    this.canvas.shader(starMaterial);
    this.canvas.pushMatrix();
    this.canvas.translate(this.canvas.width * 0.5, this.canvas.height * 0.5, 0.0);
    for(int count = 0; count < data.size(); count++){
      float radius = data.get(count).radius;
      float vertexNum = data.get(count).vertexNum;
      float split = data.get(count).split;
      float starMax = data.get(count).starMax;
      float starFieldSize = data.get(count).starFieldSize;
      StarField starField = new StarField(this.canvas, radius, vertexNum, split, starMax, starFieldSize);
      starField.circle();
    }
    this.canvas.popMatrix();
    this.canvas.resetShader();
  }
}