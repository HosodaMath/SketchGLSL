/**
  SphereにシェーダーフィルターはWaterFilterとして貼り付けた場合
*/
class BoxWater {
  private int width;
  private int height;
  private PShader waterMaterial;
  private PVector uFrequency;
  private PVector uAmplitude;
  private float uTime;
  public BoxWater(int width, int height){
    // canvas size
    this.width = width;
    this.height = height;
    
    // filter material  shader
    String waterVertexShader = "./shader/filter/water/water2.vert";
    String waterFragmentShader = "./shader/filter/water/water2.frag";
    waterMaterial = loadShader(waterFragmentShader, waterVertexShader);
    
    // shader uniform
    this.uFrequency = new PVector(0, 0);
    this.uAmplitude = new PVector(0, 0);
    this.uTime = 0;
  }

  /**
    shader uniform update
  */
  public void updateUniform(){
    // water shader data
    // frequency (-20, 20)
    this.uFrequency = new PVector(
      map(mouseX, 0, width, -20, 20),
      map(mouseY, 0, height, -20, 20)
    );

    // amplitude (-0.05, 0.05)
    this.uAmplitude = new PVector(
      map(mouseX, 0, width, -0.05, 0.05),
      map(mouseY, 0, height, -0.05, 0.05)
    );

    float uFrameCount = frameCount;
    this.uTime = uFrameCount * 0.02;
  }

  public void draw(PGraphics textureData){
    
    // float uScale = 0.01;
    shader(this.waterMaterial);
    this.waterMaterial.set("uFrequency", this.uFrequency.x, this.uFrequency.y);
    this.waterMaterial.set("uAmplitude", this.uAmplitude.x, this.uAmplitude.y);
    this.waterMaterial.set("uTime", this.uTime);
    // this.waterMaterial.set("uScale", uScale);
    this.waterMaterial.set("uTexture", textureData);
    
     // boxData
    PVector position = new PVector(this.width * 0.5, this.height * 0.5, 0);
    float radius = this.width * 0.5;
    // float radian = frameCount * 0.005;
    float scaleSize = 5;
    pushMatrix();
    translate(position.x, position.y, position.z);
    // rotateX(radian);
    // rotateY(radian);
    scale(scaleSize);
    box(radius);
    popMatrix();
    resetShader();
  }
}