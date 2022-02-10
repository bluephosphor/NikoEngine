vec4 PixelColor;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
  PixelColor = Texel(tex, texture_coords);
  PixelColor.a *= 0.5;

  if (PixelColor.a == 0.0) { discard; }

  return PixelColor;
}