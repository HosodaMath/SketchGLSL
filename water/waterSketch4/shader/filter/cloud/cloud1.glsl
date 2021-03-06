precision highp float;
precision highp int;
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
const float PI2 = 6.28318530718;
const float TAU = PI2;

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
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  // vec2 uv = (2.0 * gl_FragCoord.xy - resolution) / min(resolution.x, resolution.y);

  vec3 p = vec3(uv * 10.0, time * 0.5);
  vec4 cloudColor = vec4(vec3(valueNoise3(p) / 2.0 + 0.5), 1.0);
  // vec4 cloudColor = vec4(vec3(fbm3(p) / 2.0 + 0.5), 1.0);

  vec4 bgColor = cloudColor;
  bgColor += vec4(uv.x, uv.y, 1.0, 1.0);
  // 明るめ
  // bgColor *= 0.7;
  // 普通
  bgColor *= 0.5;
  // 暗め
  // bgColor *= 0.25;

  gl_FragColor = bgColor;
}
