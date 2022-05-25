precision highp float;
precision highp int;
// uniform
uniform sampler2D uTexture;
// in
varying vec3 vNormal;
varying vec2 vTexCoord;

void main(){

  vec2 uv = vTexCoord;

  vec4 fragColor = texture2D(uTexture, uv);

  gl_FragColor = fragColor;
}