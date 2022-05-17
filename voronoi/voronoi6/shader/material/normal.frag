precision highp float;
precision highp int;
const float PI2 = 6.28318530718;
const float TAU = PI2;

varying vec4 vTexCoord;
varying vec3 vNormal;

void main(){
  bool isNormal = true;
  
  vec2 uv = vec2(0.0);
  
  if(isNormal == true){
    uv = vNormal.xy;
  } else {
    uv = vTexCoord.xy;
  }

  vec4 bgColor = vec4(vNormal, 1.0);

  gl_FragColor = bgColor;
}