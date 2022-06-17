ArrayList<StarFieldParameter> starFieldData(PGraphics canvas, int dataMax){
  ArrayList<StarFieldParameter> data  = new ArrayList<StarFieldParameter>();
  
  float starSizeScale = 0;
  float starFieldSizeScale = 0;
  for(int count = 0; count < dataMax; count++){
    starSizeScale += 0.005;
    starFieldSizeScale += 0.1;
    float radius = canvas.width * starSizeScale;
    float vertexNum = 5;
    float split = 256;
    float starMax = (count + 2) * 5;
    float starFieldSize = canvas.width * starFieldSizeScale;
    data.add(new StarFieldParameter(radius, vertexNum, split, starMax, starFieldSize));
  }

  return data;
}