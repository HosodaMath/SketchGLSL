precision highp float;
precision highp int;
// uniform vec2 uResolution;
uniform vec2 uFrequency;
uniform vec2 uAmplitude;
uniform float uTime;
uniform float uScale;
uniform sampler2D uTexture;
varying vec4 vTexCoord;
varying vec3 vNormal;
const float PI2 = 6.28318530718;
const float TAU = PI2;

vec2 waveEffect(vec2 uv){
  uv.x += 0.0035 * sin(uv.y * 100.0 + uTime * PI2);
  uv.x += 0.0015 * cos(uv.y * 250.0 + uTime * PI2);
  
  uv.y += 0.0035 * sin(uv.x * 100.0 + uTime * PI2);
  uv.y += 0.0015 * cos(uv.x * 250.0 + uTime * PI2);
  
  return uv;
}

vec2 rotateLoop(vec2 uv, float radian){
  const int iter = 5;
  for(int i = 0; i < iter; i++){
    uv = abs(uv * 1.5) - 1.0;
    float a = radian * float(i);
    float c = cos(a);
    float s = sin(a);
    uv *= mat2(c, s, -s, c);
  }

  return uv;
}

// 乱数生成
float random(vec2 value){
  return fract(sin(dot(value, vec2(12.9898, 78.233))) * 43758.5453);
}

//乱数2
vec2 random2(vec2 value){
  return fract(sin(vec2(dot(value, vec2(127.1, 311.7)), dot(value, vec2(269.5, 183.3)))) * 43758.5453);
}

// ノイズ 多種多様な生成
float valueNoise2(vec2 value){
  vec2 i = floor(value);
  vec2 f = smoothstep(0.0, 1.0, fract(value));
  
  float mix1 = mix(random(i), random(i + vec2(1.0, 0.0)), f.x);
  float mix2 = mix(random(i + vec2(0.0, 1.0)), random(i + vec2(1.0, 1.0)), f.x);
  float valueMix = mix(mix1,mix2,f.y);
  
  return valueMix;
}

vec3 fade3(vec3 x){
  vec3 result = x * x * x * (x * (x * 6.0 - 15.0) + 10.0);

  return result;
}

vec3 phash3(vec3 p){
  p = fract(mat3(1.2989833, 7.8233198, 2.3562332,
                  6.7598192, 3.4857334, 8.2837193,
                   2.9175399, 2.9884245, 5.4987265) * p);
    p = ((2384.2345 * p - 1324.3438) * p + 3884.2243) * p - 4921.2354;
    return normalize(fract(p) * 2.0 - 1.0);
}

float valueNoise3(vec3 p)
{
    vec3 ip = floor(p);
    vec3 fp = fract(p);
    float d000 = dot(phash3(ip), fp);
    float d001 = dot(phash3(ip + vec3(0.0, 0.0, 1.0)), fp - vec3(0.0, 0.0, 1.0));
    float d010 = dot(phash3(ip + vec3(0.0, 1.0, 0.0)), fp - vec3(0.0, 1.0, 0.0));
    float d011 = dot(phash3(ip + vec3(0.0, 1.0, 1.0)), fp - vec3(0.0, 1.0, 1.0));
    float d100 = dot(phash3(ip + vec3(1.0, 0.0, 0.0)), fp - vec3(1.0, 0.0, 0.0));
    float d101 = dot(phash3(ip + vec3(1.0, 0.0, 1.0)), fp - vec3(1.0, 0.0, 1.0));
    float d110 = dot(phash3(ip + vec3(1.0, 1.0, 0.0)), fp - vec3(1.0, 1.0, 0.0));
    float d111 = dot(phash3(ip + vec3(1.0, 1.0, 1.0)), fp - vec3(1.0, 1.0, 1.0));
    fp = fade3(fp);
    return mix(mix(mix(d000, d001, fp.z), mix(d010, d011, fp.z), fp.y),
              mix(mix(d100, d101, fp.z), mix(d110, d111, fp.z), fp.y), fp.x);
}

float fbm3(vec3 value){
  float result = 0.0;
  float amp = 0.5;
  for(int i = 0; i < 5; i++){
    result += amp * valueNoise3(value);
    value *= 2.01;
    amp *= 0.5;
  }

  return result;
}

// ボロノイ
float voronoi(vec2 uv){
  uv = rotateLoop(uv, uTime * 0.2);
  vec2 baseCell = floor(uv);
  vec2 fst = fract(uv);
  float move_dist = 10.0;
  for(int x = -1; x <= 1; x++){
    for(int y = -1; y <= 1; y++){
      vec2 cell = vec2(float(x), float(y));
      vec2 point = random2(baseCell + cell);
      point = 0.5 + 0.5 * sin(6.2831 * point);
      vec2 diff = cell + point - fst;
      float cell_dist = length(diff);
      if(cell_dist < move_dist){
        move_dist = cell_dist;
      }
    }
  }

  return move_dist;
}

vec3 createVoronoiColor(vec2 uv){
  
  vec3 color1 = vec3(0.1, 0.2, 0.6);
  vec3 color2 = vec3(0.2, 0.4, 0.8);
  vec3 bgColor = mix(color1, color2, uv.y);

  
  float voronoiNoise1 = 0.0;
  float voronoiNoise2 = voronoi(uv);
  float voronoiNoise3 = voronoi(uv);

  vec3 color = vec3(voronoiNoise1, voronoiNoise2, voronoiNoise3);
  color *= 2.0;
  color = pow(color,vec3(4.0));

  vec3 voronoiColor = vec3(color);

  bgColor += voronoiColor;

  return bgColor;
}


void main(){
  
  // vec2 uv = gl_FragCoord.xy / uResolution.xy;
  // vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution) / min(uResolution.x ,uResolution.y);
  vec2 uv = vTexCoord.xy;
  // vec2 uv = vNormal.xy;
  
  uv.x = uv.x + random(uv) * uScale;
  uv.y = uv.y + random(uv) * uScale;
  
  // Wave Effect
  uv = waveEffect(uv);
  float cosWave = cos(uv.y * uFrequency.x + uTime) * uAmplitude.x;
  float sinWave = sin(uv.x * uFrequency.y + uTime) * uAmplitude.y;
  uv.x = uv.x + cosWave;
  uv.y = uv.y + sinWave;

  vec4 bgColor = vec4(createVoronoiColor(uv), 1.0);
  bgColor += texture(uTexture, uv);
  bgColor *= 0.5;


  gl_FragColor = bgColor;
}