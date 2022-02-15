vec4 PixelColor;
uniform float transparency = 0.5;
vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
  PixelColor = Texel(tex, texture_coords);
  PixelColor.a *= transparency;

  if (PixelColor.a == 0.0) { discard; }

  return PixelColor;
}