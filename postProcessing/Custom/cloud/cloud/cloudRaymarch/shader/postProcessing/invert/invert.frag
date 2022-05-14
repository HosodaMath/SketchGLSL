precision highp float;
precision highp int;
uniform sampler2D uTexture;
varying vec4 vTexCoord;
varying vec3 vNormal;
void main(){

  // vec2 uv = gl_FragCoord.xy / uResolution.xy;
  // vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution) / min(uResolution.x ,uResolution.y);
  vec2 uv = vTexCoord.xy;

  vec4 color = texture2D(uTexture, uv);

  color.r = 1.0 - color.r;
  color.g = 1.0 - color.g;
  color.b = 1.0 - color.b;

  gl_FragColor = color;
}