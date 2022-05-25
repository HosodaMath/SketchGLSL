precision highp float;
precision highp int;
// in
attribute vec3 aPosition;
attribute vec3 aNormal;
attribute vec2 aTexCoord;
// uniform
uniform mat4 uModelViewMatrix;
uniform mat4 uProjectionMatrix;
uniform float uFrameCount;
uniform float uFrequency;
uniform float uAmplitude;
// out
varying vec3 vNormal;
varying vec2 vTexCoord;

void main(){

  vNormal = aNormal;

  vTexCoord = aTexCoord;

  // ジオメトリの頂点を直接変形させる
  // 細かく変形するには別の方法が必要になる
  vec3 position = aPosition;

  const float slowScale = 0.05;

  // x軸に対しての頂点変化
  float cosWaveX = cos(aPosition.z * uFrequency + uFrameCount * slowScale);
  position.x += cosWaveX * aNormal.x * uAmplitude;
  
  // y軸に対しての頂点変化
  float sinWaveY = sin(aPosition.x * uFrequency + uFrameCount * slowScale);
  position.y += sinWaveY * aNormal.y * uAmplitude;

  // z軸に対しての頂点変化
  float sinWaveZ = sin(aPosition.y * uFrequency + uFrameCount * slowScale);
  position.z += sinWaveZ * aNormal.z * uAmplitude;

  gl_Position = uProjectionMatrix * uModelViewMatrix * vec4(position, 1.0);
}