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

  public void circle(){
    for(int theta = 0; theta < int(this.starMax); theta++){
      Star star = new Star(this.canvas, this.radius, this.vertexNum, this.split);
      float radian = radians((360 / this.starMax) * theta);
      float positionX = cos(radian) * this.starFieldSize;
      float positionY = sin(radian) * this.starFieldSize;
      float positionZ = 0;
      PVector position = new PVector(positionX, positionY, positionZ);
      this.canvas.pushMatrix();
      this.canvas.translate(position.x, position.y, position.z);
      // star.fillColor(color(240, 240, 100));
      star.shaderColor();
      this.canvas.popMatrix();
    }
  }

  public void spiral(){
    float a = 4;
    for(int theta = 0; theta < int(this.starMax); theta++){
      Star star = new Star(this.canvas, this.radius, this.vertexNum, this.split);
      float radian = radians((360 / this.starMax) * theta);
      float r = a * sqrt(theta);
      float positionX = r * cos(radian) * this.starFieldSize;
      float positionY = r * sin(radian) * this.starFieldSize;
      float positionZ = 0;
      PVector position = new PVector(positionX, positionY, positionZ);
      // println("x:" + position.x + "y:" + position.y);
      this.canvas.pushMatrix();
      this.canvas.translate(position.x, position.y, position.z);
      // star.fillColor(color(240, 240, 100));
      star.shaderColor();
      this.canvas.popMatrix();
    }
  }
}