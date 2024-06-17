void drawTriangleOutline(triangle t) {
  PVector v0 = t.vertices.get(0);
  PVector v1 = t.vertices.get(1);
  PVector v2 = t.vertices.get(2);

  stroke(t.red, t.green, t.blue);
  triangle(v0.x, v0.y, v1.x, v1.y, v2.x, v2.y);
  stroke(0);
  line(v0.x, v0.y, v1.x, v1.y);
  line(v1.x, v1.y, v2.x, v2.y);
  line(v2.x, v2.y, v0.x, v0.y);
}

void drawTriangleFill(triangle t) {
  PVector v0 = t.vertices.get(0);
  PVector v1 = t.vertices.get(1);
  PVector v2 = t.vertices.get(2);
  
  fill(255);
  stroke(255,255,255);
  line(v0.x, v0.y, v1.x, v1.y);
  line(v1.x, v1.y, v2.x, v2.y);
  line(v2.x, v2.y, v0.x, v0.y);
}

void rasterizeTriangle(triangle t) {
  pushMatrix();
  PVector v0 = t.vertices.get(0);
  PVector v1 = t.vertices.get(1);
  PVector v2 = t.vertices.get(2);
  
  fill(t.red,t.green,t.blue);
  stroke(t.red, t.green, t.blue);
  triangle(v0.x, v0.y, v1.x, v1.y, v2.x, v2.y);
  popMatrix();
}

void drawTriangleVertices(triangle t) {
  PVector v0 = t.vertices.get(0);
  PVector v1 = t.vertices.get(1);
  PVector v2 = t.vertices.get(2);
  
  fill(255);
  stroke(255,255,255);
  circle(v0.x, v0.y, 2);
  circle(v1.x, v1.y, 2);
  circle(v2.x, v2.y, 2);
}
