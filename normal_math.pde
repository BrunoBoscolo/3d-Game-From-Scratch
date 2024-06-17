boolean NormalTriangle(triangle t) {
  // Calculate the triangle's normal vector
  PVector normal = calculateTriangleNormal(t);

  // Normalize the normal vector
  normal = normalize(normal);

  // Create a vector pointing from the camera to the triangle's center
  PVector cameraRay = new PVector(t.vertices.get(0).x - camera.x, 
                               t.vertices.get(0).y - camera.y, 
                               t.vertices.get(0).z - camera.z);

  // Perform dot product between normal and camera ray
  float dotProduct = dot(normal, cameraRay);

  // Check if the dot product is within a certain threshold
  if (dotProduct < 0) {
    return true;
  }
  
  else {
    return false;
  }
}

// Helper functions to calculate normal vector, normalize vector, and perform dot product
PVector calculateTriangleNormal(triangle t) {
  // Get the edges of the triangle
  PVector edge1 = new PVector(t.vertices.get(1).x - t.vertices.get(0).x,
                           t.vertices.get(1).y - t.vertices.get(0).y,
                           t.vertices.get(1).z - t.vertices.get(0).z);
  PVector edge2 = new PVector(t.vertices.get(2).x - t.vertices.get(0).x,
                           t.vertices.get(2).y - t.vertices.get(0).y,
                           t.vertices.get(2).z - t.vertices.get(0).z);

  // Calculate the normal vector using cross product
  PVector normal = cross(edge1, edge2);

  return normal;
}

// Helper function to perform cross product
PVector cross(PVector v1, PVector v2) {
  float x = v1.y * v2.z - v1.z * v2.y;
  float y = v1.z * v2.x - v1.x * v2.z;
  float z = v1.x * v2.y - v1.y * v2.x;
  return new PVector(x, y, z);
}

PVector normalize(PVector v) {
  float magnitude = magnitude(v);
  return new PVector(v.x / magnitude, v.y / magnitude, v.z / magnitude);
}

float dot(PVector v1, PVector v2) {
  return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}

float magnitude(PVector v) {
  return (float) Math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
}
