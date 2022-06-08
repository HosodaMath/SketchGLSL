class StarData {
  public PVector position;
  public float radius;
  public float vertexNum;
  public float split;
  public StarData(PVector position, float radius, float vertexNum, float split){
    this.position = position;
    this.radius = radius;
    this.vertexNum = vertexNum;
    this.split = split;
  }
}

class SetStarField {
  private ArrayList<StarData> starData;
  private float starMax;
  private float fieldScale;
  public SetStarField(float starMax, float fieldScale){
    this.starData = new ArrayList<StarData>();
    this.starMax = starMax;
    this.fieldScale = fieldScale;
  }

  public ArrayList<StarData> setCircle(){
    for (int theta = 0; theta < this.starMax; theta++) {
      float radian = radians(360 / this.starMax * theta);
      float positionX = cos(radian) * this.fieldScale;
      float positionY = sin(radian) * this.fieldScale;
      float positionZ = 0;
      PVector position = new PVector(positionX, positionY, positionZ);
    
      float radius = width * 0.025;
    
      float vertexNum = 5;
    
      float split = 256;
    
      this.starData.add(new StarData(position, radius, vertexNum, split));
    }

    return this.starData;
  }

  public ArrayList<StarData> setSpiral(){
    float a = 6;
    float radius = width * 0.025;
    float vertexNum = 5;
    float split = 256;
    for (int theta = 0; theta < this.starMax; theta++) {
      float r = a * (theta / this.starMax);
      float positionX = r * cos(theta) * this.fieldScale;
      float positionY = r * sin(theta) * this.fieldScale;
      float positionZ = 0;
      PVector position = new PVector(positionX, positionY, positionZ);
    
      this.starData.add(new StarData(position, radius, vertexNum, split));
    }

    return this.starData;
  }
}