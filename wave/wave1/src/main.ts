import { sketch } from "./sketch/sketch";
import { fullScreen } from "./event/fullScreen"
import "sanitize.css";
import "./style.css";
const main = () => {
  const mainBody = document.body;
  fullScreen(mainBody);

  sketch();
};

window.addEventListener("load", main);
