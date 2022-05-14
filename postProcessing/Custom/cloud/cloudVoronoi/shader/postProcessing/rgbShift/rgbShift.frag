precision highp float;
precision highp int;
uniform vec2 uShift;
uniform sampler2D uTexture;
varying vec4 vTexCoord;
varying vec3 vNormal;
void main(){

  // vec2 uv = gl_FragCoord.xy / uResolution.xy;
  // vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution) / min(uResolution.x ,uResolution.y);
  vec2 uv = vTexCoord.xy;

  vec2 redShift = vec2(uv.x - uShift.x, uv.y - uShift.y);
  vec4 redTexture = texture2D(uTexture, redShift);
  
  vec2 greenShift = uv;
  vec4 greenTexture = texture2D(uTexture, greenShift);
  
  vec2 blueShift = vec2(uv.x + uShift.x, uv.y + uShift.y);
  vec4 blueTexture = texture2D(uTexture, blueShift);

  vec4 fragColor = vec4(redTexture.r, greenTexture.g, blueTexture.b, 1.0);

  gl_FragColor = fragColor;
}