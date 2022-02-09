vec4 FragColor;
vec4 TexColor;

float depth;
float near = 0.1; 
float far  = 50;
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
    FragColor = vec4(vec3(depth), 1.0);

    TexColor = Texel(tex, texture_coords);
    if (TexColor.a == 0.0) { discard; }
    
    return FragColor * (TexColor * lightOffset);
}