void meshCubeSetup(String filename){
  
  //meshCube.loadObjectFile(filename);
  // Define vertices of the cube
  // South face (clockwise order)
  meshCube.addTriangle(new triangle(
    new PVector(0.0f, 0.0f, 0.0f),
    new PVector(0.0f, 1.0f, 0.0f),
    new PVector(1.0f, 1.0f, 0.0f)
  ));
  meshCube.addTriangle(new triangle(
    new PVector(0.0f, 0.0f, 0.0f),
    new PVector(1.0f, 1.0f, 0.0f),
    new PVector(1.0f, 0.0f, 0.0f)
  ));
  
  // East face (clockwise order)
  meshCube.addTriangle(new triangle(
    new PVector(1.0f, 0.0f, 0.0f),
    new PVector(1.0f, 1.0f, 0.0f),
    new PVector(1.0f, 1.0f, 1.0f)
  ));
  meshCube.addTriangle(new triangle(
    new PVector(1.0f, 0.0f, 0.0f),
    new PVector(1.0f, 1.0f, 1.0f),
    new PVector(1.0f, 0.0f, 1.0f)
  ));
  
  // North face (clockwise order)
  meshCube.addTriangle(new triangle(
    new PVector(1.0f, 0.0f, 1.0f),
    new PVector(1.0f, 1.0f, 1.0f),
    new PVector(0.0f, 1.0f, 1.0f)
  ));
  meshCube.addTriangle(new triangle(
    new PVector(1.0f, 0.0f, 1.0f),
    new PVector(0.0f, 1.0f, 1.0f),
    new PVector(0.0f, 0.0f, 1.0f)
  ));
  
  // West face (clockwise order)
  meshCube.addTriangle(new triangle(
    new PVector(0.0f, 0.0f, 1.0f),
    new PVector(0.0f, 1.0f, 1.0f),
    new PVector(0.0f, 1.0f, 0.0f)
  ));
  meshCube.addTriangle(new triangle(
    new PVector(0.0f, 0.0f, 1.0f),
    new PVector(0.0f, 1.0f, 0.0f),
    new PVector(0.0f, 0.0f, 0.0f)
  ));
  
  // Top face (clockwise order)
  meshCube.addTriangle(new triangle(
    new PVector(0.0f, 1.0f, 0.0f),
    new PVector(0.0f, 1.0f, 1.0f),
    new PVector(1.0f, 1.0f, 1.0f)
  ));
  meshCube.addTriangle(new triangle(
    new PVector(0.0f, 1.0f, 0.0f),
    new PVector(1.0f, 1.0f, 1.0f),
    new PVector(1.0f, 1.0f, 0.0f)
  ));
  
  // Bottom face (clockwise order)
  meshCube.addTriangle(new triangle(
    new PVector(1.0f, 0.0f, 1.0f),
    new PVector(0.0f, 0.0f, 1.0f),
    new PVector(0.0f, 0.0f, 0.0f)
  ));
  meshCube.addTriangle(new triangle(
    new PVector(1.0f, 0.0f, 1.0f),
    new PVector(0.0f, 0.0f, 0.0f),
    new PVector(1.0f, 0.0f, 0.0f)
  )); 
}
