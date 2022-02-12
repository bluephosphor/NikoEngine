vec4 PixelShade;
vec4 PixelColor;

float depth;
float near = 0.1; 
float far  = 35;
float lightOffset = 1.5;
float z;
  
float LinearizeDepth(float depth) 
{
    z = depth * 2.0 - 1.0; 
    return (2.0 * near * far) / (far + near - z * (far - near));
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    depth     = LinearizeDepth(gl_FragCoord.z) / far; 
    PixelShade = vec4(vec3(depth), 1.0);

    PixelColor = Texel(tex, texture_coords);
    if (PixelColor.a == 0.0) { discard; }
    
    return PixelShade * (PixelColor * lightOffset);
}