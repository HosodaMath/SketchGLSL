precision highp float;
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
const float PI2 = 6.28318530718;
const float PI = 3.141592653589793;

// 波のエフェクト
vec2 waveEffect(vec2 uv){
  uv.x += 0.0035 * sin(uv.y * 100.0 + time * PI2);
  uv.x += 0.0015 * cos(uv.y * 250.0 + time * PI2);
  
  uv.y += 0.0035 * sin(uv.x * 100.0 + time * PI2);
  uv.y += 0.0015 * cos(uv.x * 250.0 + time * PI2);
  
  return uv;
}

// 乱数を生成
float random(vec3 value){
  return fract(sin(dot(value, vec3(12.9898, 78.233, 19.8321))) * 43758.5453);
}

// ノイズを生成
float noise(vec3 value){
  vec3 i = floor(value);
  vec3 f = smoothstep(0.0, 1.0, fract(value));
  float color1 = 	mix(
		mix(random(i), random(i + vec3(1.0, 0.0, 0.0)), f.x),
		mix(random(i + vec3(0.0, 1.0, 0.0)), random(i + vec3(1.0, 1.0, 0.0)), f.x),
		f.y
	);
  float color2 = mix(
		mix(random(i + vec3(0.0, 0.0, 1.0)), random(i + vec3(1.0, 0.0, 1.0)), f.x),
		mix(random(i + vec3(0.0, 1.0, 1.0)), random(i + vec3(1.0, 1.0, 1.0)), f.x),
		f.y
	);
  return mix(color1,color2,f.z);
}

// fbm(フラクタルブラウン運動)
float fbm3(vec3 value){
  float result = 0.0;
  float amp = 0.5;
  for(int i = 0; i < 5; i++){
    result += amp * noise(value);
    value *= 2.01;
    amp *= 0.5;
  }

  return result;
}

vec3 createWater(vec2 uv){

  float r = 0.2;
  float g = fbm3(vec3(uv * 10.0, time * 0.05));
  float b = 1.0;
  vec3 warterColor = vec3(r, g, b);
  
  vec3 color = warterColor;

  return color;
}

void main(){
  // vec2 uv = gl_FragCoord.xy / min(resolution.x, resolution.y);
  vec2 uv = (2.0 * gl_FragCoord.xy - resolution) / min(resolution.x, resolution.y);
  
  uv = waveEffect(uv);

  vec3 bgColor = createWater(uv);

  gl_FragColor = vec4(bgColor, 1.0);
}