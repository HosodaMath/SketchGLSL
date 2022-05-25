precision highp float;
precision highp int;
// uniform
uniform float uTime;
// in
varying vec3 vNormal;
varying vec2 vTexCoord;

const float PI = 3.14159265359;
const float PI2 = 6.28318530718;
const float TAU = PI2;

vec2 rotateLoop(vec2 uv, float radian){
  const int uLoopMax = 5;
  for(int i = 0; i < uLoopMax; i++){
    uv = abs(uv * 1.5) - 1.0;
    float a = radian * float(i);
    float c = cos(a);
    float s = sin(a);
    uv *= mat2(c, s, -s, c);
  }

  return uv;
}

vec2 fade2(vec2 x){
  vec2 result = x * x * x * (x * (x * 6.0 - 15.0) + 10.0);

  return result;
}

vec2 phash2(vec2 p){
  p = fract(mat2(1.2989833 ,7.8233139, 6.7598192 ,3.4857334) * p);
  p = ((2384.2345 * p - 1324.3438) * p + 3884.2243) * p - 4921.2345;

  return normalize(fract(p) * 2.0 - 1.0);
}

float noiseValue2(vec2 p){
  vec2 ip = floor(p);
  vec2 fp = fract(p);
  float d00 = dot(phash2(ip), fp);
  float d01 = dot(phash2(ip + vec2(0.0, 1.0)),  fp - vec2(0.0, 1.0));
  float d10 = dot(phash2(ip + vec2(1.0, 0.0)),  fp - vec2(1.0, 0.0));
  float d11 = dot(phash2(ip + vec2(1.0, 1.0)),  fp - vec2(1.0, 1.0));
  fp = fade2(fp);

  return mix(mix(d00, d01, fp.y), mix(d10, d11, fp.y), fp.x);
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

/*
  3次元ノイズ
*/
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

float morphine(vec2 uv){
  float polygonSize = 1.0;
  float h = hexagon(uv, polygonSize);

  float radius = 1.0;
  float c = circle(uv, radius);

  float t = sin(uTime * 5.0) * 0.5 + 0.5;
  float d = mix(c, h, t);

  return d;
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

vec4 voronoiColor(vec2 uv){
  uv = rotateLoop(uv, uTime * 0.2);
  
  float polygonSize = 0.5;
  //float d = hexagon(uv, polygonSize);
  float d = smoothstep(-0.5, 0.5, hexagon(uv, polygonSize));

  float timeSlow = 0.5;
  vec3 p = vec3(uv * 10.0, uTime);
  vec4 noiseColor = vec4(vec3(valueNoise3(p) / 2.0 + 0.5), 1.0);

  float v = voronoi(uv);
  vec4 mainColor = vec4(vec3(v, v, v) * 0.25, 1.0);
  
  vec4 color = mix(noiseColor, mainColor, d);
  
  return color;
}

vec4 imageColor(vec2 uv){
  vec4 mainColor = vec4(vec3(uv.x, uv.y, 0.5), 1.0);

  return mainColor;
}

void main(){

  bool isNormal = true;
  vec2 uv = vec2(0.0);
  
  if(isNormal == true){
    uv = vNormal.xy;
  } else {
    uv = vTexCoord;
  }

   vec3 p = vec3(uv * 10.0, uTime);
  vec4 noiseColor = vec4(vec3(valueNoise3(p) / 2.0 + 0.5), 1.0);

  vec4 iceColor = voronoiColor(uv);
  
  float d = morphine(uv);
  
  vec4 bgColor = vec4(0.0, 0.5, 0.5, 1.0);
  bgColor += mix(noiseColor, iceColor, d);
  bgColor *= 0.5;

  vec4 mainColor  = imageColor(uv);
  mainColor += bgColor;
  mainColor *= 0.5;

  gl_FragColor = mainColor;
}