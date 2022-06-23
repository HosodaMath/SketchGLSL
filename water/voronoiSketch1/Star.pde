class Star {
  private PGraphics canvas;
  private float radius;
  private float vertexNum;
  private float split;
  Star(PGraphics canvas, float radius, float vertexNum, float split){
    this.canvas = canvas;
    this.radius = radius;
    this.vertexNum = vertexNum * 2.0;
    this.split = split;
  }

  void fillColor(color col){
    this.canvas.fill(col);
    this.canvas.beginShape();
    for (int theta = 0; theta < this.split; theta++) {
      float size = 0;
      if(theta % 2 == 0){
        size = radius * 0.5;
      } else {
        size = radius;
      }
      
      float radian = radians(360 / this.vertexNum * theta);
      float x = cos(radian) * size;
      float y = sin(radian) * size;
      float z = 0;
      this.canvas.vertex(x, y, z);
    }
    this.canvas.endShape(CLOSE);
  }

  void strokeColor(color col, float strokeWidth){
    this.canvas.stroke(col);
    this.canvas.strokeWeight(strokeWidth);
    this.canvas.beginShape();
    for (int theta = 0; theta < this.split; theta++) {
      float size = 0;
      if(theta % 2 == 0){
        size = radius * 0.5;
      } else {
        size = radius;
      }
      
      float radian = radians(360 / this.vertexNum * theta);
      float x = cos(radian) * size;
      float y = sin(radian) * size;
      float z = 0;
      this.canvas.vertex(x, y, z);
    }
    this.canvas.endShape(CLOSE);
  }

  void shaderColor(){
    this.canvas.beginShape();
    for (int theta = 0; theta < this.split; theta++) {
      float size = 0;
      if(theta % 2 == 0){
        size = radius * 0.5;
      } else {
        size = radius;
      }
      
      float radian = radians(360 / this.vertexNum * theta);
      float x = cos(radian) * size;
      float y = sin(radian) * size;
      float z = 0;
      float u = 0.5 + cos(radian) * 0.5;
      float v = 0.5 + sin(radian) * 0.5;
      this.canvas.vertex(x, y, z, u, v);
    }
    this.canvas.endShape(CLOSE);
  }
}