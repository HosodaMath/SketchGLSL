precision highp float;
precision highp int;
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
const float PI2 = 6.28318530718;
const float TAU = PI2;

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

float noise(vec3 p)
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

float circle(vec2 uv, float radius){
  return length(uv) - radius;
}

float rect(vec2 position, vec2 size){
  position = abs(position) - size;
  return length(max(position, 0.0)) + min(max(position.x, position.y), 0.0);
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
  return a + b * cos(PI2 * (c * t + d));
}

/*
  color(t) = a + b * sin(2pi(c * t + d))
*/
vec3 paletteSin(vec3 a, vec3 b, vec3 c, vec3 d, float t){
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
  
  float slowScale = 1.0;
  float colorChangeTime1 = clamp(cos(time * slowScale), 0.0, 1.0);
  float colorChangeTime2 = clamp(sin(time * slowScale), 0.0, 1.0);
  
  float colorChange1 = mouse.x;
  float colorChange2 = mouse.y;

  vec3 p = vec3(gl_FragCoord.xy * 10.0 / resolution.y, time);
  vec4 noiseColor = vec4(vec3(noise(p) / 2.0 + 0.5), 1.0);
  
  vec3 bgColor1 = paletteCos(
    vec3(0.5, 0.5, 0.5), 
    vec3(0.5, 0.5, 0.5), 
    vec3(2.0, 1.0, 0.0), 
    vec3(colorChangeTime1, colorChange1, 0.25), 
    morphine
  );

  vec3 bgColor2 = paletteSin(
    vec3(0.5, 0.5, 0.5), 
    vec3(0.5, 0.5, 0.5), 
    vec3(2.0, 1.0, 0.0), 
    vec3(colorChangeTime2, colorChange2, 0.25), 
    morphine
  );

  vec4 bgColor = vec4(mix(bgColor1, bgColor2, hexagon1), 1.0);
  bgColor += noiseColor;

  gl_FragColor = bgColor;
}