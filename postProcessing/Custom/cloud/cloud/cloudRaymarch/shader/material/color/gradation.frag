precision highp float;
precision highp int;
const float PI2 = 6.28318530718;
const float TAU = PI2;

varying vec4 vTexCoord;
varying vec3 vNormal;

void main(){
  bool isNormal = false;

  vec2 uv = vec2(0.0);

  if(isNormal == false){
    uv = vTexCoord.xy;
  } else {
    uv = vNormal.xy;
  }

  vec4 bgColor = vec4(uv.x, uv.y, 0.5, 1.0);

  gl_FragColor = bgColor;
}