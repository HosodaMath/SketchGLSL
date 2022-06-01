precision highp float;
precision highp int;
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
const float PI = 3.14159265359;
const float PI2 = 6.28318530718;
const float TAU = PI2;

float hexagon(vec2 uv, float r){
  const vec3 k = vec3(-0.866025404,0.5,0.577350269);
  uv = abs(uv);
  uv -= 2.0 * min(dot(k.xy, uv), 0.0) * k.xy;
  uv -= vec2(clamp(uv.x, -k.z * r, k.z * r), r);

  return length(uv) * sign(uv.y);
}

float circle(vec2 uv, float radius){
  return length(uv) - radius;
}

float random2(vec2 value){
  return fract (sin(dot(value, vec2(12.9898, 78.233))) * 43758.5453);
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

vec4 imageColor(vec2 uv){
  
  float scale = 0.05;
  uv.x = uv.x + random2(uv) * scale;
  uv.y = uv.y + random2(uv) * scale;

  vec4 bgColor = vec4(1.0, uv.x, uv.y, 1.0);
  vec4 mainColor = vec4(0.0, 0.5, 1.0, 1.0);
  vec3 p = vec3(gl_FragCoord.xy * 10.0 / resolution.y, time);
  vec4 noiseColor = vec4(vec3(valueNoise3(p) / 2.0 + 0.5), 1.0);
  mainColor += noiseColor;
  mainColor *= 0.5;

  float d = hexagon(uv, 0.5);
  vec4 color = mix(mainColor, bgColor, smoothstep(-0.005, 0.005, d));

  return color;
}

void main(){
  
  // vec2 uv = gl_FragCoord.xy / resolution.xy;
  vec2 uv = (gl_FragCoord.xy * 2.0 - resolution) / min(resolution.x ,resolution.y);

  vec4 bgColor = imageColor(uv);

  gl_FragColor = bgColor;
}