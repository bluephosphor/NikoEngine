vec4 PixelShade;
vec4 PixelColor;

varying vec4 viewPosition;
varying vec4 worldPosition;

uniform float fogEnd   = 50.0;
uniform float fogStart = 10;
uniform vec4  fogColor = vec4(0.0,0.0,0.0,1.0);

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
  PixelColor = Texel(tex, texture_coords);
  if (PixelColor.a == 0.0) { discard; }

  float dist = length(viewPosition.xyz);

  float fraction = clamp((dist-fogStart) / (fogEnd-fogStart), 0.0, 1.0);

  vec4 finalColor = mix(PixelColor, fogColor, fraction);

  return finalColor;
}