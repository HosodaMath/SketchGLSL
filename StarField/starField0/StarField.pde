class StarField {
  PGraphics canvas;
  PShader starShader;
  ArrayList<StarData> starData;
  public StarField(PGraphics canvas, PShader starShader){
    this.canvas = canvas;
    this.starShader = starShader;
    
    SetStarField setStarField = new SetStarField(30, this.canvas.width * 0.1);
    this.starData = setStarField.setSpiral();
  }

  // public void update() {};

  public void render(){
    this.canvas.shader(this.starShader);
    this.canvas.pushMatrix();
    this.canvas.translate(width * 0.5, height * 0.5, 0.0);
    for(int count = 0; count < this.starData.size(); count++){
      PVector position = this.starData.get(count).position;
      float radius = this.starData.get(count).radius;
      float vertexNum = this.starData.get(count).vertexNum;
      float split = this.starData.get(count).split;
      
      this.canvas.pushMatrix();
      this.canvas.translate(position.x, position.y, position.z);
      Star star = new Star(this.canvas, radius, vertexNum, split);
      star.shaderColor();
      this.canvas.popMatrix();
    }
    this.canvas.popMatrix();
    this.canvas.resetShader();
  }
}
