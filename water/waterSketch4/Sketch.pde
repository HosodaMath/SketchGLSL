/**
  Material + PostProcessingはWaterFilter
  MaterialはCloudMaterial
*/
class Sketch {
  private PGraphics canvas;
  private int width;
  private int height;
  private BoxWater boxWater;
  public Sketch(int width, int height){
    this.width = width;
    this.height = height;
    this.canvas = createGraphics(this.width, this.height, P3D);
    this.boxWater = new BoxWater(this.width, this.height);
  }

  /**
    FrameBuffer作成開始
  */
  public void start(){
    this.canvas.beginDraw();
  }

  /**
    FrameBuffer基本設定
    strokeなし
    背景は黒
  */
  public void set(){
    this.canvas.noStroke();
    this.canvas.background(0, 0, 0);
  }

  /**
    ここでCloudMaterialを貼り付けたSphereを作成
  */
  public void createCloud(){
    SphereCloud cloud = new SphereCloud(canvas);
    cloud.draw();
  }

  /**
    FrameBuffer作成終了
  */
  public void end() {
    this.canvas.endDraw();
  }

  public void sketch(){
    this.boxWater.updateUniform();
    this.boxWater.draw(this.canvas);
  }
}