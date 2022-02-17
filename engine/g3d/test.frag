vec4 finalColor;

uniform vec3 lightPos;
uniform vec3 lightColor;

varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec4 vertexColor;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
  vec4 surfaceColor = Texel(tex, texture_coords);
  if (surfaceColor.a == 0.0) { discard; }
  
  //ambient
  float ambientLightStrength = 0.1;
  vec3 ambient = ambientLightStrength * lightColor;
  
  //diffuse

  vec3 normal = normalize(vertexNormal);
  vec3 surfaceToLight = normalize(lightPos - vec3(worldPosition.xyz));
  
  //float diff = max((dot(normal, surfaceToLight)) / (length(surfaceToLight) * length(normal)), 0.0);
  float diff = max(dot(normal, surfaceToLight), 0.0);
  
  vec3 diffuse = diff * lightColor;
  
  //spec
  float specularStrength = 0.5;

  vec3 viewDir = normalize(vec3(viewPosition) - vec3(worldPosition));
  vec3 reflectDir = reflect(-surfaceToLight, normal);  
  
  float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
  vec3 specular = specularStrength * spec * lightColor;  
  
  vec3 result = (ambient + diffuse + specular) * surfaceColor.rgb;

  return vec4(result, surfaceColor.a);
}
