vec4 finalColor;

uniform vec3 lightPos;
uniform vec3 lightInt;

varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec4 vertexColor;
varying mat4 model;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
  vec4 surfaceColor = Texel(tex, texture_coords);
  if (surfaceColor.a == 0.0) { discard; }
  
  //calculate normal in world coordinates
  mat3 normalMatrix = transpose(mat3(model));
  vec3 normal = normalize(normalMatrix * vertexNormal);
  
  //calculate the vector from this pixels surface to the light source
  vec3 surfaceToLight = lightPos - vec3(worldPosition.x,worldPosition.y,worldPosition.z);

  //calculate the cosine of the angle of incidence
  float brightness = dot(normal, surfaceToLight) / (length(surfaceToLight) * length(normal));
  
  brightness = clamp(brightness, 0, 1);
  
  float ambientLightStrength = 0.1;
  vec3 ambientColor = ambientLightStrength * vec3(surfaceColor.rgb);

  //calculate final color of the pixel, based on:
  // 1. The angle of incidence: brightness
  // 2. The color/intensities of the light: light.intensities
  // 3. The texture and texture coord: texture(tex, fragTexCoord)
  
  
  finalColor = vec4((brightness * lightInt * surfaceColor.rgb) + ambientColor, surfaceColor.a);

  return finalColor;
}
