int getTriangleShadingMono(triangle t) {
  
  int red = t.red;
  int green = t.green;
  int blue = t.blue;
  
  PVector v0t = t.vertices.get(0);
  PVector v1t = t.vertices.get(1);
  PVector v2t = t.vertices.get(2);
  
  PVector line1 = new PVector(v0t.x, v0t.y, v0t.z);
  PVector line2 = new PVector(v0t.x, v0t.y, v0t.z);
  
  line1.x = v1t.x - v0t.x;
  line1.y = v1t.y - v0t.y;
  line1.z = v1t.z - v0t.z;
  
  line2.x = v2t.x - v0t.x;
  line2.y = v2t.y - v0t.y;
  line2.z = v2t.z - v0t.z;
  
  PVector pvNormal = line1.cross(line2);
  
  pvNormal.normalize();
  
  PVector lightPvector = new PVector(0, 0, -1);
  
  lightPvector.normalize();
  
  float dp = pvNormal.dot(lightPvector);
  
  int shading = (int)(dp * 100) + 50;
   
  return shading;
}

int[] getTriangleShading(triangle t, int red, int green, int blue) {
  
  PVector v0t = t.vertices.get(0);
  PVector v1t = t.vertices.get(1);
  PVector v2t = t.vertices.get(2);
  
  PVector line1 = new PVector(v0t.x, v0t.y, v0t.z);
  PVector line2 = new PVector(v0t.x, v0t.y, v0t.z);
  
  line1.x = v1t.x - v0t.x;
  line1.y = v1t.y - v0t.y;
  line1.z = v1t.z - v0t.z;
  
  line2.x = v2t.x - v0t.x;
  line2.y = v2t.y - v0t.y;
  line2.z = v2t.z - v0t.z;
  
  PVector pvNormal = line1.cross(line2);
  
  pvNormal.normalize();
  
  PVector lightPvector = new PVector(0, 0, -1);
  
  lightPvector.normalize();
  
  float dp = pvNormal.dot(lightPvector);
  
  // Calculate new RGB values based on dp
  int shadedRed = constrains((int)(red * dp), 0, 255);
  int shadedGreen = constrains((int)(green * dp), 0, 255);
  int shadedBlue = constrains((int)(blue * dp), 0, 255);

  // Return the shaded values
  return new int[]{shadedRed, shadedGreen, shadedBlue};
}

// Helper function to constrain the values within the 0-255 range
int constrains(int value, int min, int max) {
  if (value < min) {
    return min;
  } else if (value > max) {
    return max;
  } else {
    return value;
  }
}
