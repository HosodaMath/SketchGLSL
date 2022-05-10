precision highp float;
precision highp int;
uniform vec2 uResolution;
uniform sampler2D uTexture;
varying vec4 vTexCoord;
varying vec3 vNormal;

const float PI2 = 6.28318530718;
const float TAU = PI2;

void main(){

  vec2 uv = gl_FragCoord.xy / uResolution.xy;
  // vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution) / min(uResolution.x ,uResolution.y);
  // vec2 uv = vTexCoord.xy;

  vec4 bgColor = texture(uTexture, uv);

  gl_FragColor = bgColor;
}