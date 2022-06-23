precision highp float;
precision highp int;
varying vec4 vTexCoord;
varying vec3 vNormal;

void main(){
  
  // vec2 uv = gl_FragCoord.xy / uResolution.xy;
  // vec2 uv = (gl_FragCoord.xy * 2.0 - uResolution) / min(uResolution.x ,uResolution.y);
  vec2 uv = vTexCoord.xy;
  
  vec4 bgColor = vec4(uv.x, uv.y, 1.0, 1.0);

  gl_FragColor = bgColor;
}