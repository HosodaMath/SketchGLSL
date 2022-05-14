precision highp float;
precision highp int;

uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
varying vec4 vTexCoord;
varying vec3 vNormal;

const float PI2 = 6.28318530718;
const float TAU = PI2;

float circle(vec2 uv, float radius){
  return length(uv) - radius;
}

float hexagon(vec2 uv, float r){
  const vec3 k = vec3(-0.866025404,0.5,0.577350269);
  uv = abs(uv);
  uv -= 2.0 * min(dot(k.xy, uv), 0.0) * k.xy;
  uv -= vec2(clamp(uv.x, -k.z * r, k.z * r), r);

  return length(uv) * sign(uv.y);
}

/*
  color(t) = a + b * cos(2pi(c * t + d))
*/
vec3 paletteCos(vec3 a, vec3 b, vec3 c, vec3 d, float t){
  return a + b * cos(TAU * (c * t + d));
}

/*
  color(t) = a + b * sin(2pi(c * t + d))
*/
vec3 paletteSin(vec3 a, vec3 b, vec3 c, vec3 d, float t){
  return a + b * sin(TAU * (c * t + d));
}

void main(){
  /*
  bool isNormal = false;
  vec2 uv = vec2(0.0);
  if(isNormal == false){
    uv = vTexCoord.xy;
  } else {
    uv = vNormal.xy;
  }
  uv = uv - 0.5;
  */

  bool centerFlag = true;

  vec2 uv = vec2(0.0);

  if(centerFlag == false){
    // 原点は画面左下
    uv = gl_FragCoord.xy / resolution;
  } else {
    // 原点を画面中央にする -> 繰り返し回数が多くなる
    uv = (2.0 * gl_FragCoord.xy - resolution) / min(resolution.x, resolution.y);
  }

  float polygonSize = 0.2;
  float hexagon1 = hexagon(uv, polygonSize);
  float circle1 = circle(uv, 0.2);

  vec3 bgColor1 = paletteCos(
    vec3(0.5, 0.5, 0.5), 
    vec3(0.5, 0.5, 0.5), 
    vec3(2.0, 1.0, 0.0), 
    vec3(0.5, 0.2, 0.25), 
    circle1
  );
  
  vec3 bgColor2 = paletteSin(
    vec3(0.5, 0.5, 0.5), 
    vec3(0.5, 0.5, 0.5), 
    vec3(1.0, 1.0, 1.0), 
    vec3(0.0, 0.333, 0.666), 
    circle1
  );

  vec4 bgColor = vec4(mix(bgColor1, bgColor2, uv.x), 1.0);

  gl_FragColor = bgColor;
}