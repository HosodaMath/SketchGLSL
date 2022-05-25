import P5 from "p5";
import { CloudSphere } from "./CloudSphere";

export const sketch = () => {
  const sketch = (p: P5) => {
    let cloudSphere: CloudSphere;
    p.setup = () => {
      p.createCanvas(p.windowWidth, p.windowHeight, p.WEBGL);
      p.noStroke();

      cloudSphere = new CloudSphere(p);

    };

    p.draw = () => {
      p.background(0, 0 ,0);
      //p.orbitControl();
      cloudSphere.update();
      cloudSphere.draw();
    };

    p.windowResized = () => {
      p.resizeCanvas(p.windowWidth, p.windowHeight);
    }
  };

  new P5(sketch);
};
