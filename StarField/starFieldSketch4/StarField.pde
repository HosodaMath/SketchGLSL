class StarField {
  private PGraphics canvas;
  private float radius;
  private float vertexNum;
  private float split;
  private float starMax;
  private float starFieldSize;
  public StarField(
    PGraphics canvas,
    float radius, 
    float vertexNum, 
    float split, 
    float starMax, 
    float starFieldSize
  ){
    this.canvas = canvas;
    this.radius = radius;
    this.vertexNum = vertexNum;
    this.split = split;
    this.starMax = starMax;
    this.starFieldSize = starFieldSize;
  }

  public void circle1(){
    for(int theta = 0; theta < int(this.starMax); theta++){
      Star star = new Star(this.canvas, this.radius, this.vertexNum, this.split);
      float radian = radians((360 / this.starMax) * theta);
      float positionX = cos(radian) * this.starFieldSize;
      float positionY = sin(radian) * this.starFieldSize;
      float positionZ = 0;
      PVector position = new PVector(positionX, positionY, positionZ);
      this.canvas.pushMatrix();
      this.canvas.translate(position.x, position.y, position.z);
      star.shaderColor();
      this.canvas.popMatrix();
    }
  }

  public void circle2(){
    for(int theta = 0; theta < int(this.starMax); theta++){
      float radius = 0;
      if(theta % 2 == 0){
        radius = this.radius;
      } else {
        radius = this.radius * 0.5;
      }
      Star star = new Star(this.canvas, radius, this.vertexNum, this.split);
      float radian = radians((360 / this.starMax) * theta);
      float positionX = cos(radian) * this.starFieldSize;
      float positionY = sin(radian) * this.starFieldSize;
      float positionZ = 0;
      PVector position = new PVector(positionX, positionY, positionZ);
      this.canvas.pushMatrix();
      this.canvas.translate(position.x, position.y, position.z);
      star.shaderColor();
      this.canvas.popMatrix();
    }
  }
}