precision highp float;
precision highp int;
uniform float uTime;
uniform float uScale;
uniform sampler2D uTexture;
varying vec4 vTexCoord;
varying vec3 vNormal;
const float PI2 = 6.28318530718;
const float TAU = PI2;

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

void main(){
  
  // vec2 uv = gl_FragCoord.xy / uResolution.xy;
  // vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution) / min(uResolution.x ,uResolution.y);
  vec2 uv = vTexCoord.xy;

  vec3 p = vec3(uv * 10.0, uTime * 0.5);
  
  // vec4 cloudColor = vec4(vec3(valueNoise3(p) / 2.0 + 0.5), 1.0);
  vec4 cloudColor = vec4(vec3(fbm3(p) / 2.0 + 0.5), 1.0);

  // float uScale = 0.02;
  uv.x = uv.x + random2(uv) * uScale;
  uv.y = uv.y + random2(uv) * uScale;
  
  vec4 bgColor = texture(uTexture, uv);
  bgColor += cloudColor;
  bgColor += mix(vec4(0.0, 0.0, 0.05, 1.0), vec4(0.0, uv.x, uv.y, 1.0), uv.y);
  bgColor *= 0.5;
  
  gl_FragColor = bgColor;
}