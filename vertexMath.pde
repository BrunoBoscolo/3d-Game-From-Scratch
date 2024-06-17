triangle scaleTriangle(triangle t, float sX, float sY, float sZ){
  PVector vOut0 = new PVector(0,0,0);
  PVector vOut1 = new PVector(0,0,0);
  PVector vOut2 = new PVector(0,0,0);
  
  PVector v0 = t.vertices.get(0);
  PVector v1 = t.vertices.get(1);
  PVector v2 = t.vertices.get(2);
  
  vOut0.x = v0.x*sX; vOut0.y = v0.y*sY; vOut0.z = v0.z*sZ;
  vOut1.x = v1.x*sX; vOut1.y = v1.y*sY; vOut1.z = v1.z*sZ;
  vOut2.x = v2.x*sX; vOut2.y = v2.y*sY; vOut2.z = v2.z*sZ;
  
  
  triangle tScaled = new triangle(vOut0, vOut1, vOut2);
  
  return tScaled;
}

triangle rotateTriangleSingleAxis(triangle t, mat4x4 rotMat){
  PVector vOut0 = new PVector(0,0,0);
  PVector vOut1 = new PVector(0,0,0);
  PVector vOut2 = new PVector(0,0,0);
  
  PVector v0 = t.vertices.get(0);
  PVector v1 = t.vertices.get(1);
  PVector v2 = t.vertices.get(2);
  
  vOut0 = MatrixVectorMultiplication(v0, rotMat);
  vOut1 = MatrixVectorMultiplication(v1, rotMat);
  vOut2 = MatrixVectorMultiplication(v2, rotMat);
  
  triangle tRotated = new triangle(vOut0, vOut1, vOut2);
  
  return tRotated;
}

triangle rotateTriangle(triangle t, mat4x4 xRotMat, mat4x4 yRotMat, mat4x4 zRotMat){
  PVector vOut0 = new PVector(0,0,0);
  PVector vOut1 = new PVector(0,0,0);
  PVector vOut2 = new PVector(0,0,0);
  
  PVector v0 = t.vertices.get(0);
  PVector v1 = t.vertices.get(1);
  PVector v2 = t.vertices.get(2);
  
  vOut0 = MatrixVectorMultiplication(v0, zRotMat);
  vOut1 = MatrixVectorMultiplication(v1, zRotMat);
  vOut2 = MatrixVectorMultiplication(v2, zRotMat);
  
  vOut0 = MatrixVectorMultiplication(vOut0, xRotMat);
  vOut1 = MatrixVectorMultiplication(vOut1, xRotMat);
  vOut2 = MatrixVectorMultiplication(vOut2, xRotMat);
  
  vOut0 = MatrixVectorMultiplication(vOut0, yRotMat);
  vOut1 = MatrixVectorMultiplication(vOut1, yRotMat);
  vOut2 = MatrixVectorMultiplication(vOut2, yRotMat);
  
  triangle tRotated = new triangle(vOut0, vOut1, vOut2);
  
  return tRotated;
}

triangle translateTriangle(triangle t, float tx, float ty, float tz) {
  PVector vOut0 = new PVector(0,0,0);
  PVector vOut1 = new PVector(0,0,0);
  PVector vOut2 = new PVector(0,0,0);
  
  PVector v0 = t.vertices.get(0);
  PVector v1 = t.vertices.get(1);
  PVector v2 = t.vertices.get(2);
  
  vOut0 = MatrixVectorMultiplication(v0, translationMatrix);
  vOut1 = MatrixVectorMultiplication(v1, translationMatrix);
  vOut2 = MatrixVectorMultiplication(v2, translationMatrix);
  
  triangle tTranslated = new triangle(vOut0, vOut1, vOut2);
  
  return tTranslated;
}
