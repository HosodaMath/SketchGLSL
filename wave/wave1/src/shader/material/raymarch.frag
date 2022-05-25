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


vec3 background(vec2 position){
  vec3 color = mix(
    vec3(0.0078, 0.0235, 0.2863), 
    vec3(0.3059, 0.3333, 0.7882), 
    position.y
  );
  return color;
}


vec2 rotate(vec2 position, float radian){
  float c = cos(-radian);
  float s = sin(-radian);
  vec2 calc = mat2(c, s, -s, c) * position;

  return calc;
}

float sphere(vec3 position, float radius){
  return length(position) - radius;
}

float torus(vec3 position){
  vec2 t = vec2(0.75, 0.25);
  vec2 radius = vec2(length(position.xy) - t.x, position.z);

  return length(radius) - t.y;
}

float map(vec3 position){
  position = mod(position, 5.0) - 2.5;
  
  float radius = 1.0;
  float g_sphere = sphere(position, radius);

  vec3 size = vec3(1.0, 1.0, 1.0);
  float g_torus = torus(position);

  float t = sin(uTime * 5.0) * 0.5 + 0.5;
  float d = mix(g_sphere, g_torus, t);

  return d;
}

vec3 calcNormal(vec3 position){
  float e = 0.01;
  float mapping1 = map(position + vec3(e, 0.0, 0.0)) - map(position - vec3(e, 0.0, 0.0));
  float mapping2 = map(position + vec3(0.0, e, 0.0)) - map(position - vec3(0.0, e, 0.0));
  float mapping3 = map(position + vec3(0.0, 0.0, e)) - map(position - vec3(0.0, 0.0, e));

  return normalize(vec3(mapping1, mapping2, mapping3));
}

vec3 raymarch(vec3 ro, vec3 rayDictance, vec2 uv){
  const int rayLoopMax = 32;
  vec3 position = ro;
  vec3 directionalLight = vec3(-0.5, 0.5, 0.5);
  vec3 gradientColor = vec3(uv.x, uv.y, 0.5);
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

  vec3 bgColor = background(uv);

  return bgColor;
}

void main(){

  bool isNormal = true;
  vec2 uv = vec2(0.0);
  
  if(isNormal == true){
    uv = vNormal.xy;
  } else {
    uv = vTexCoord;
  }

  vec3 ro = vec3(10.0 * vec2(0.5, 0.5) - 5.0, - uTime);
  vec3 ta = vec3(0.0, 0.0, -5.0 - uTime);

  vec3 normalColor = vec3(1.0, 1.0, 1.0);
  vec3 cameraZ = normalize(ta - ro);
  vec3 cameraX = normalize(cross(cameraZ, normalColor));
  vec3 cameraY = cross(cameraX, cameraZ);

  vec3 rayDictance = normalize(cameraX * uv.x + cameraY * uv.y + 1.5 * cameraZ);
  
  vec4 raymarchColor = vec4(vec3(raymarch(ro, rayDictance, uv)), 1.0);

  gl_FragColor = raymarchColor;
}