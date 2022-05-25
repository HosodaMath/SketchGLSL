export const fullScreen = (mainBody: HTMLElement) => {
  const fullScreenButton = document.createElement("button");
  fullScreenButton.classList.add(...["fullScreenButton"]);
  fullScreenButton.textContent = "fullScreen";
  mainBody.appendChild(fullScreenButton);

  const cancelFullScreenButton = document.createElement("button");
  cancelFullScreenButton.classList.add(...["fullScreenButton"]);
  cancelFullScreenButton.textContent = "cancelFullScreen";

  fullScreenButton.addEventListener("click", () => {
    mainBody.removeChild(fullScreenButton);
    mainBody.appendChild(cancelFullScreenButton);
    mainBody.requestFullscreen();
  });

  cancelFullScreenButton.addEventListener("click", () => {
    mainBody.removeChild(cancelFullScreenButton);
    mainBody.appendChild(fullScreenButton);
    document.exitFullscreen();
  });
};
