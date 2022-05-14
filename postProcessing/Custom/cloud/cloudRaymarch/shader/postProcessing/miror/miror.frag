precision highp float;
precision highp int;
uniform sampler2D uTexture;
varying vec4 vTexCoord;
varying vec3 vNormal;
void main(){

  // vec2 uv = gl_FragCoord.xy / uResolution.xy;
  // vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution) / min(uResolution.x ,uResolution.y);
  vec2 uv = vTexCoord.xy;

  vec2 miror = abs(uv * 2.0 - 1.0);

  vec4 fragColor = texture(uTexture, miror);

  gl_FragColor = fragColor;
}