import P5 from "p5";
import VertexShader from "../shader/material/default.vert?raw";
import RaymarchFragmentShader from "../shader/material/raymarch.frag?raw";
export class RaymarchSphere {
  private p: P5;
  private position: P5.Vector;
  private size: number;
  private uFrameCount: number;
  private uTime: number;
  private cloudShader: P5.Shader;
  constructor(p: P5) {
    this.p = p;
    this.position = this.p.createVector(0, 0, 0);
    this.size = this.p.width * 0.5;
    this.uFrameCount = 0;
    this.uTime = 0;
    this.cloudShader = this.p.createShader(
      VertexShader,
      RaymarchFragmentShader
    );
  }

  setPosition(position: P5.Vector) {
    this.position = position;
  }

  update() {
    this.uFrameCount = this.p.frameCount;
    this.uTime = this.uFrameCount * 0.005;
  }

  draw() {
    this.p.push();
    this.p.shader(this.cloudShader);
    // this.cloudShader.setUniform("uFrameCount", this.uFrameCount);
    // this.cloudShader.setUniform("uFrequency", 20);
    // this.cloudShader.setUniform("uAmplitude", 0.1);
    this.cloudShader.setUniform("uTime", this.uTime);
    this.p.translate(this.position.x, this.position.y, this.position.z);
    // p.rotateX(uFrameCount * 0.005);
    // p.rotateY(uFrameCount * 0.005);
    this.p.sphere(this.size, 128, 128);
    this.p.pop();
  }
}
