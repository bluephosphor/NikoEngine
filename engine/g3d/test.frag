vec4 finalColor;

uniform vec3 lightPos;
uniform vec3 lightInt;

varying vec4 worldPosition;
varying vec4 viewPosition;
varying vec4 screenPosition;
varying vec3 vertexNormal;
varying vec4 vertexColor;
varying mat4 model;

float det(mat2 matrix) {
  return matrix[0].x * matrix[1].y - matrix[0].y * matrix[1].x;
}

mat3 inverse3(mat3 matrix) {
  vec3 row0 = matrix[0];
  vec3 row1 = matrix[1];
  vec3 row2 = matrix[2];

  vec3 minors0 = vec3(
    det(mat2(row1.y, row1.z, row2.y, row2.z)),
    det(mat2(row1.z, row1.x, row2.z, row2.x)),
    det(mat2(row1.x, row1.y, row2.x, row2.y))
  );
  vec3 minors1 = vec3(
    det(mat2(row2.y, row2.z, row0.y, row0.z)),
    det(mat2(row2.z, row2.x, row0.z, row0.x)),
    det(mat2(row2.x, row2.y, row0.x, row0.y))
  );
  vec3 minors2 = vec3(
    det(mat2(row0.y, row0.z, row1.y, row1.z)),
    det(mat2(row0.z, row0.x, row1.z, row1.x)),
    det(mat2(row0.x, row0.y, row1.x, row1.y))
  );

  mat3 adj = transpose(mat3(minors0, minors1, minors2));

  return (1.0 / dot(row0, minors0)) * adj;
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
  vec4 surfaceColor = Texel(tex, texture_coords);
  if (surfaceColor.a == 0.0) { discard; }
  
  //ambient
  float ambientLightStrength = 0.1;
  vec3 ambient = ambientLightStrength * vec3(surfaceColor.rgb);
  
  //diffuse. calculate normal in world coordinates
  mat3 normalMatrix = transpose(inverse3(mat3(model)));
  vec3 normal = normalize(normalMatrix * vertexNormal);
  
  //calculate the vector from this pixels surface to the light source
  vec3 surfaceToLight = lightPos - vec3(worldPosition.x,worldPosition.y,worldPosition.z);

  //calculate the cosine of the angle of incidence
  float brightness = dot(normal, surfaceToLight) / (length(surfaceToLight) * length(normal));
        brightness = clamp(brightness, 0, 1);
  vec3 diffuse = brightness * lightInt;
  
  //spec
  float specularStrength = 0.5;

  vec3 viewDir = normalize(vec3(viewPosition) - vec3(worldPosition));
  vec3 reflectDir = reflect(-surfaceToLight, normal);  
  
  float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
  vec3 specular = specularStrength * spec * lightInt;  

  
  vec4 result = vec4((ambient + diffuse + specular) * surfaceColor.rgb, surfaceColor.a);

  return result;
}
