ArrayList<PVector> getCubePosition(float loopMax){
  ArrayList<PVector> cubePosition = new ArrayList<PVector>();

  for(int count = 0; count < loopMax; count++){
    float positionX = random(0, width);
    float positionY = random(0, height);
    float positionZ = random(-width, 0);
    PVector position = new PVector(positionX, positionY, positionZ);

    cubePosition.add(position);

  }

  return cubePosition;
}