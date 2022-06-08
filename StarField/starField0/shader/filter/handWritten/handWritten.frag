precision highp float;
precision highp int;
uniform float uScale;
uniform sampler2D uTexture;
varying vec4 vTexCoord;
varying vec3 vNormal;

float random2(vec2 value){
  return fract (sin(dot(value, vec2(12.9898, 78.233))) * 43758.5453);
}

void main(){
  
  // vec2 uv = gl_FragCoord.xy / uResolution.xy;
  // vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution) / min(uResolution.x ,uResolution.y);
  vec2 uv = vTexCoord.xy;

  // float uScale = 0.02;
  uv.x = uv.x + random2(uv) * uScale;
  uv.y = uv.y + random2(uv) * uScale;
  
  vec4 bgColor = texture(uTexture, uv);
  
  gl_FragColor = bgColor;
}