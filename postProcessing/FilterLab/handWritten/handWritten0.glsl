precision highp float;
precision highp int;

uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;

float random2(vec2 value){
  return fract (sin(dot(value, vec2(12.9898, 78.233))) * 43758.5453);
}

float circle(vec2 uv, float radius){
  return length(uv) - radius;
}

vec4 mainColor(vec2 uv){
  float scale = 0.05;
  
  uv.x = uv.x + random2(uv) * scale;
  uv.y = uv.y + random2(uv) * scale;

  vec4 color1 = vec4(uv.x, uv.y, 0.8, 1.0);
  vec4 color2 = vec4(0.0, 0.0, 0.0, 1.0);
  float d = circle(uv, 0.5);
  vec4 color = mix(color1, color2, smoothstep(-0.005, 0.005, d));
  vec4 bgColor = color;

  return bgColor;
}

void main(){
  bool centerFlag = true;

  vec2 uv = vec2(0.0);

  if(centerFlag == false){
    // 原点は画面左下
    uv = gl_FragCoord.xy / resolution;
  } else {
    // 原点を画面中央にする -> 繰り返し回数が多くなる
    uv = (2.0 * gl_FragCoord.xy - resolution) / min(resolution.x, resolution.y);
  }

  vec4 bgColor = mainColor(uv);

  gl_FragColor = bgColor;
}
