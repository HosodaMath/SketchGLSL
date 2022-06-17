class NightSky {
  PGraphics canvas;
  PShader skyShader;
  public NightSky(PGraphics canvas, PShader skyShader){
    this.canvas = canvas;
    this.skyShader = skyShader;
  }

  public void drawing(){
    float uFrameCount = frameCount;
    float uTime = uFrameCount * 0.005;
    
    this.canvas.shader(this.skyShader);
    this.skyShader.set("uTime", uTime);
    this.canvas.pushMatrix();
    this.canvas.translate(0, 0, 0);
    this.canvas.rect(0, 0, this.canvas.width, this.canvas.height);
    this.canvas.popMatrix();
    this.canvas.resetShader();
  }

}