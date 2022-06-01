precision highp float;
precision highp int;
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
const float PI = 3.14159265359;
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

//乱数2
vec2 random2(vec2 value){
  return fract(sin(vec2(dot(value, vec2(127.1, 311.7)), dot(value, vec2(269.5, 183.3)))) * 43758.5453);
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

// 球体を描く
float GSphere(vec3 position, float radius){
  return length(position) - radius;
}

// ボックスを描く
float GBox(vec3 position, vec3 size){
  vec3 d = abs(position) - size;

  return length(max(d, 0.0)) + min(max(d.x, max(d.y, d.z)), 0.0);
}

// 繰り返しで球体とBoxを配置する
float map(vec3 position){
  position = mod(position, 5.0) - 2.5;
  
  float radius = 1.0;
  float sphere = GSphere(position, radius);

  vec3 size = vec3(1.0, 1.0, 1.0);
  float box = GBox(position, size);

  float t = sin(time * 5.0) * 0.5 + 0.5;
  float d = mix(sphere, box, t);

  return d;
}

// 正規化計算
vec3 calcNormal(vec3 position){
  float e = 0.01;
  float mapping1 = map(position + vec3(e, 0.0, 0.0)) - map(position - vec3(e, 0.0, 0.0));
  float mapping2 = map(position + vec3(0.0, e, 0.0)) - map(position - vec3(0.0, e, 0.0));
  float mapping3 = map(position + vec3(0.0, 0.0, e)) - map(position - vec3(0.0, 0.0, e));

  return normalize(vec3(mapping1, mapping2, mapping3));
}


// 背景色
vec3 backgroundColor(vec2 uv){
  vec3 color = mix(
    vec3(0.0078, 0.0235, 0.2863), 
    vec3(0.3059, 0.3333, 0.7882), 
    uv.y
  );
  return color;
}

/*
  primitive color
*/
vec3 primitiveColor(vec2 uv){

  vec3 color = vec3(0.05, 0.2, 0.5);

  return color;
}

// レイマーチング
vec3 raymarch(vec3 ro, vec3 rayDictance, vec2 uv){
  const int rayLoopMax = 64;
  vec3 position = ro;
  vec3 directionalLight = vec3(-0.5, 0.5, 0.5);
  vec3 gradientColor = primitiveColor(uv);
  for(int i = 0; i < rayLoopMax; i++){
    float objectDistance = map(position);
    position += objectDistance * rayDictance;
    if(objectDistance < 0.01){
      vec3 normal = calcNormal(position);
      float diffuese = clamp(dot(directionalLight, normal), 0.1, 1.0);
      vec3 mainColor = vec3(diffuese, diffuese, diffuese);
      mainColor += gradientColor;
      
      return mainColor;
    }
  }

  vec3 bgColor = backgroundColor(uv);

  return bgColor;
}

void main() {
  // 正規化座標
  vec2 uv = (2.0 * gl_FragCoord.xy - resolution) / min(resolution.x, resolution.y); 
  

  float scale = 0.02;
  uv.x = uv.x + random2(uv).x * scale;
  uv.y = uv.y + random2(uv).y * scale;

  vec3 ro = vec3(10.0 * vec2(0.5, 0.5) - 5.0, -time);
  vec3 ta = vec3(0.0, 0.0, -5.0 - time);

  vec3 normalColor = vec3(0.8667, 1.0, 0.3765);
  vec3 cameraZ = normalize(ta - ro);
  vec3 cameraX = normalize(cross(cameraZ, normalColor));
  vec3 cameraY = cross(cameraX, cameraZ);

  vec3 rd = normalize(cameraX * uv.x + cameraY * uv.y + 1.5 * cameraZ);
  
  vec4 mainColor = vec4(vec3(raymarch(ro, rd, uv)), 1.0);
  mainColor *= 0.5;

  gl_FragColor = mainColor;
}
