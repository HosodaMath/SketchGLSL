class SphereCloud {
  private PGraphics canvas;
  private PShader cloudMaterial;
  public SphereCloud(PGraphics canvas){
    this.canvas = canvas;

    String cloudVertexShader = "./shader/material/cloud/cloud2.vert";
    String cloudFragmentShader = "./shader/material/cloud/cloud2.frag";
    cloudMaterial = this.canvas.loadShader(cloudFragmentShader, cloudVertexShader);
  }

  public void draw(){
    float x = this.canvas.width * 0.5;
    float y = this.canvas.height * 0.5;
    float z = 0;
    PVector position = new PVector(x, y, z);
    float scaleSize = 0.5;
    float radius = this.canvas.width * 0.5;
    this.canvas.shader(this.cloudMaterial);
    this.canvas.pushMatrix();
    this.canvas.translate(position.x, position.y, position.z);
    this.canvas.scale(scaleSize);
    this.canvas.sphere(radius);
    this.canvas.popMatrix();
    this.canvas.resetShader();
  }
}