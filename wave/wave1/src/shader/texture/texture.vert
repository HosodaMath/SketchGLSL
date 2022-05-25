precision highp float;
precision highp int;
// in
attribute vec3 aPosition;
attribute vec3 aNormal;
attribute vec2 aTexCoord;
// uniform
uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
// out
varying vec3 vNormal;
varying vec2 vTexCoord;

void main(){

  vNormal = aNormal;

  vTexCoord = aTexCoord;

  gl_Position = uProjectionMatrix * uModelViewMatrix * vec4(aPosition, 1.0);
}