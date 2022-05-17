precision highp float;
precision highp int;
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
const float PI2 = 6.28318530718;
const float TAU = PI2;


vec2 rotateLoop(vec2 uv, float radian){
  int uLoopMax = 5;
  for(int i = 0; i < uLoopMax; i++){
    uv = abs(uv * 1.5) - 1.0;
    float a = radian * float(i);
    float c = cos(a);
    float s = sin(a);
    uv *= mat2(c, s, -s, c);
  }

  return uv;
}

vec2 fade(vec2 x){
  vec2 result = x * x * x * (x * (x * 6.0 - 15.0) + 10.0);

  return result;
}

vec2 phash(vec2 p){
  p = fract(mat2(1.2989833 ,7.8233139, 6.7598192 ,3.4857334) * p);
  p = ((2384.2345 * p - 1324.3438) * p + 3884.2243) * p - 4921.2345;

  return normalize(fract(p) * 2.0 - 1.0);
}

float noiseValue2(vec2 p){
  vec2 ip = floor(p);
  vec2 fp = fract(p);
  float d00 = dot(phash(ip), fp);
  float d01 = dot(phash(ip + vec2(0.0, 1.0)),  fp - vec2(0.0, 1.0));
  float d10 = dot(phash(ip + vec2(1.0, 0.0)),  fp - vec2(1.0, 0.0));
  float d11 = dot(phash(ip + vec2(1.0, 1.0)),  fp - vec2(1.0, 1.0));
  fp = fade(fp);

  return mix(mix(d00, d01, fp.y), mix(d10, d11, fp.y), fp.x);
}

vec3 fade(vec3 x){
  vec3 result = x * x * x * (x * (x * 6.0 - 15.0) + 10.0);

  return result;
}

vec3 phash(vec3 p){
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
    float d000 = dot(phash(ip), fp);
    float d001 = dot(phash(ip + vec3(0.0, 0.0, 1.0)), fp - vec3(0.0, 0.0, 1.0));
    float d010 = dot(phash(ip + vec3(0.0, 1.0, 0.0)), fp - vec3(0.0, 1.0, 0.0));
    float d011 = dot(phash(ip + vec3(0.0, 1.0, 1.0)), fp - vec3(0.0, 1.0, 1.0));
    float d100 = dot(phash(ip + vec3(1.0, 0.0, 0.0)), fp - vec3(1.0, 0.0, 0.0));
    float d101 = dot(phash(ip + vec3(1.0, 0.0, 1.0)), fp - vec3(1.0, 0.0, 1.0));
    float d110 = dot(phash(ip + vec3(1.0, 1.0, 0.0)), fp - vec3(1.0, 1.0, 0.0));
    float d111 = dot(phash(ip + vec3(1.0, 1.0, 1.0)), fp - vec3(1.0, 1.0, 1.0));
    fp = fade(fp);
    return mix(mix(mix(d000, d001, fp.z), mix(d010, d011, fp.z), fp.y),
              mix(mix(d100, d101, fp.z), mix(d110, d111, fp.z), fp.y), fp.x);
}

// ボロノイ
float voronoi(vec2 coord){
  vec2 baseCell = floor(coord);
  vec2 fst = fract(coord);
  float move_dist = 10.0;
  for(int x = -1; x <= 1; x++){
    for(int y = -1; y <= 1; y++){
      vec2 cell = vec2(float(x), float(y));
      //vec2 point = phash(baseCell + cell);
      vec2 point = vec2(noiseValue2(baseCell + cell));
      point = 0.5 + 0.5 * tan(6.2831 * point);
      vec2 diff = cell + point - fst;
      float cell_dist = length(diff);
      if(cell_dist < move_dist){
        move_dist = cell_dist;
      }
    }
  }

  return move_dist;
}

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


vec4 voronoiColor(vec2 uv){

  float polygonSize = 0.5;
  //float d = hexagon(uv, polygonSize);
  float d = smoothstep(-0.5, 0.5, hexagon(uv, polygonSize));

  float timeSlow = 0.5;
  vec3 p = vec3(gl_FragCoord.xy * 10.0 / resolution.y, time);
  vec4 noiseColor = vec4(vec3(valueNoise3(p) / 2.0 + 0.5), 1.0);

  float v = voronoi(uv);
  vec4 mainColor = vec4(vec3(v, v, v) * 0.25, 1.0);
  
  vec4 color = mix(noiseColor, mainColor, d);
  
  return color;
}

/*
  color(t) = a + b * cos(2pi(c * t + d))
*/
vec3 palette1(vec3 a, vec3 b, vec3 c, vec3 d, float t){
  return a + b * cos(PI2 * (c * t + d));
}

/*
  color(t) = a + b * sin(2pi(c * t + d))
*/
vec3 palette2(vec3 a, vec3 b, vec3 c, vec3 d, float t){
  return a + b * sin(PI2 * (c * t + d));
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

  float polygonSize = 0.5;
  float hexagon1 = hexagon(uv, polygonSize);
  float circle1 = circle(uv, 0.5);
  float t = sin(time * 5.0) * 0.5 + 0.5;
  float morphine = smoothstep(-0.5, 0.5, mix(circle1, hexagon1, t));
  
  vec3 paletteColor1 = palette2(
    vec3(0.5, 0.5, 0.5), 
    vec3(0.5, 0.5, 0.5), 
    vec3(2.0, 1.0, 0.0), 
    vec3(0.5, 0.2, 0.25), 
    morphine
  );

  vec3 paletteColor2 = palette2(
    vec3(0.5, 0.5, 0.5), 
    vec3(0.5, 0.5, 0.5), 
    vec3(1.0, 1.0, 1.0), 
    vec3(0.0, 0.333, 0.666), 
    morphine
  );

  uv = rotateLoop(uv, time * 0.2);

  vec4 bgColor = vec4(vec3(0.0), 1.0);

  bgColor += voronoiColor(uv);
  //bgColor += vec4(mix(paletteColor1, paletteColor2, hexagon(uv, polygonSize)), 1.0);
  bgColor += vec4(mix(paletteColor1, paletteColor2, hexagon1), 1.0);


  gl_FragColor = bgColor;
}