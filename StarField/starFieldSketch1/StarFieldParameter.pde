class StarFieldParameter {
  private float radius; 
  private float vertexNum;
  private float split;
  private float starMax;
  private float starFieldSize;
  public StarFieldParameter(
    float radius, 
    float vertexNum, 
    float split, 
    float starMax, 
    float starFieldSize
  ){
    this.radius = radius;
    this.vertexNum = vertexNum;
    this.split = split;
    this.starMax = starMax;
    this.starFieldSize = starFieldSize;
  }
}