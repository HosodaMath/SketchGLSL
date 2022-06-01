precision highp float;
precision highp int;
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;

float random2(vec2 value){
  return fract (sin(dot(value, vec2(12.9898, 78.233))) * 43758.5453);
}

float circle(vec2 position, float radius){
  float dicetance = length(position);
  float smoothValue = 0.2;
  float color = smoothstep(radius, radius - smoothValue, dicetance);

  return color;
}

float ring(vec2 uv, float radius){
  float frequency = 20.0;
  float d = length(uv);
  d = sin(d * frequency) * 0.5 + 0.5;
  float smoothValue = 0.2;
  float color = smoothstep(radius, radius - smoothValue, d);

  return color;
}

void main(void){
  bool centerFlag = true;

  vec2 uv = vec2(0.0);

  if(centerFlag == false){
    // 原点は画面左下
    uv = gl_FragCoord.xy / resolution;
  } else {
    // 原点を画面中央にする -> 繰り返し回数が多くなる
    uv = (2.0 * gl_FragCoord.xy - resolution) / min(resolution.x, resolution.y);
  }

  float scale = 0.02;
  uv.x = uv.x + random2(uv) * scale;
  uv.y = uv.y + random2(uv) * scale;

  float radius = 0.5;
  vec4 bgColor = vec4(vec3(ring(uv, radius)), 1.0);
  

  gl_FragColor = bgColor;
}