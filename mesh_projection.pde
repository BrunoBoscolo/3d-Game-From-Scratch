void meshProjectionSetup(triangle t, ArrayList<triangle> triangles, int red, int green, int blue) {
  // Rotate vertices
  
  triangle rotatedTriangle = rotateTriangle(t, xRotMat, yRotMat, zRotMat);
  
  // Translate vertices
  //triangle translatedTriangle = translateTriangle(rotatedTriangle, tx, ty, tz);
  PVector v0r = rotatedTriangle.vertices.get(0);
  PVector v1r = rotatedTriangle.vertices.get(1);
  PVector v2r = rotatedTriangle.vertices.get(2);
  
  //triangle translatedTriangle = translateTriangle(rotatedTriangle,tx,ty,tz);
  
  v0r.x += tx; v1r.x+=tx; v2r.x+=tx;
  v0r.y += ty; v1r.y+=ty; v2r.y+=ty;
  v0r.z += tz; v1r.z+=tz; v2r.z+=tz;
  
  triangle translatedTriangle = new triangle(v0r,v1r,v2r);
  
  afterStateTriangles.add(translatedTriangle);
  
  boolean isVisible  = NormalTriangle(translatedTriangle);
  
  if (isVisible==true) {
      int[]shading = getTriangleShading(translatedTriangle, red, green, blue);
      
      int shadedRed = shading[0];
      int shadedGreen = shading[1];
      int shadedBlue = shading[2];
      
      translatedTriangle.red = shadedRed;
      translatedTriangle.green = shadedGreen;
      translatedTriangle.blue = shadedBlue;
        
      // Project vertices using the projection matrix
      triangle projectedTriangle = new triangle(
      MatrixVectorMultiplication(translatedTriangle.vertices.get(0), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(1), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(2), projectionMatrix));
     
      projectedTriangle.red = translatedTriangle.red;
      projectedTriangle.green = translatedTriangle.green;
      projectedTriangle.blue = translatedTriangle.blue;
      
      //triangle scaledTriangle = scaleTriangle(projectedTriangle, 40, 40, 40);
      
      PVector v0 = projectedTriangle.vertices.get(0);
      PVector v1 = projectedTriangle.vertices.get(1);
      PVector v2 = projectedTriangle.vertices.get(2);
      
      v0.x +=1; v0.y+=1; v0.z+=1;
      v1.x +=1; v1.y+=1; v1.z+=1;
      v2.x +=1; v2.y+=1; v2.z+=1;
      
      v0.x *= (0.5*screenWidth);
      v1.x *= (0.5*screenWidth);
      v2.x *= (0.5*screenWidth);
      
      v0.y *= (0.5*screenHeight);
      v1.y *= (0.5*screenHeight);
      v2.y *= (0.5*screenHeight);
      
      triangle scaledTriangle = new triangle(v0,v1,v2);
      
      scaledTriangle.red = shadedRed;
      scaledTriangle.green = shadedGreen;
      scaledTriangle.blue = shadedBlue;
      
      //println(t.red,t.green,t.blue);
      
      // Draw the projected triangle outline
      triangles.add(scaledTriangle);
      afterStateTriangles.add(scaledTriangle);
    }
}

void meshEnemyProjectionSetup(triangle t, ArrayList<triangle> triangles, int red, int green, int blue, enemy enemy) {
  // Rotate vertices
  
  triangle rotatedTriangle = rotateTriangle(t, EmemyRotationMatX, EmemyRotationMatY, EmemyRotationMatZ);
  // Translate vertices
  //triangle translatedTriangle = translateTriangle(rotatedTriangle, tx, ty, tz);
  PVector v0r = rotatedTriangle.vertices.get(0);
  PVector v1r = rotatedTriangle.vertices.get(1);
  PVector v2r = rotatedTriangle.vertices.get(2);
  
  //triangle translatedTriangle = translateTriangle(rotatedTriangle,tx,ty,tz);
  
  v0r.x += enemy.x; v1r.x+=enemy.x; v2r.x+=enemy.x;
  v0r.y += enemy.y; v1r.y+=enemy.y; v2r.y+=enemy.y;
  v0r.z += 130; v1r.z+=130; v2r.z+=130;
  
  triangle translatedTriangle = new triangle(v0r,v1r,v2r);
  
  afterStateTriangles.add(translatedTriangle);
  
  boolean isVisible  = NormalTriangle(translatedTriangle);
  
  if (isVisible==true) {
      int[]shading = getTriangleShading(translatedTriangle, red, green, blue);
      
      int shadedRed = shading[0];
      int shadedGreen = shading[1];
      int shadedBlue = shading[2];
      
      translatedTriangle.red = shadedRed;
      translatedTriangle.green = shadedGreen;
      translatedTriangle.blue = shadedBlue;
        
      // Project vertices using the projection matrix
      triangle projectedTriangle = new triangle(
      MatrixVectorMultiplication(translatedTriangle.vertices.get(0), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(1), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(2), projectionMatrix));
     
      projectedTriangle.red = translatedTriangle.red;
      projectedTriangle.green = translatedTriangle.green;
      projectedTriangle.blue = translatedTriangle.blue;
      
      PVector v0 = projectedTriangle.vertices.get(0);
      PVector v1 = projectedTriangle.vertices.get(1);
      PVector v2 = projectedTriangle.vertices.get(2);
      
      v0.x +=1; v0.y+=1; v0.z+=1;
      v1.x +=1; v1.y+=1; v1.z+=1;
      v2.x +=1; v2.y+=1; v2.z+=1;
      
      v0.x *= (enemyScalingHorizontalFactor);
      v1.x *= (enemyScalingHorizontalFactor);
      v2.x *= (enemyScalingHorizontalFactor);
      
      v0.y *= (enemyScalingVerticalFactor);
      v1.y *= (enemyScalingVerticalFactor);
      v2.y *= (enemyScalingVerticalFactor);
      
      triangle finalTriangle = new triangle(v0,v1,v2);
      
      finalTriangle.red = shadedRed;
      finalTriangle.green = shadedGreen;
      finalTriangle.blue = shadedBlue;
      
      // Draw the projected triangle outline
      triangles.add(finalTriangle);
      afterStateEnemy.add(finalTriangle);
    }
}

void meshTextEnemyProjectionSetup(triangle t, ArrayList<triangle> triangles, int red, int green, int blue, int sf, enemy enemy) {
  // Rotate vertices
  
  triangle rotatedTriangle = rotateTriangle(t, EmemyTextRotationMatX, EmemyTextRotationMatY, EmemyTextRotationMatZ);
  // Translate vertices
  //triangle translatedTriangle = translateTriangle(rotatedTriangle, tx, ty, tz);
  PVector v0r = rotatedTriangle.vertices.get(0);
  PVector v1r = rotatedTriangle.vertices.get(1);
  PVector v2r = rotatedTriangle.vertices.get(2);
  
  //v0r.x += enemy.x; v1r.x+=enemy.x; v2r.x+=enemy.x;
  v0r.y += 2; v1r.y+=2; v2r.y+=2;
  v0r.z += 130; v1r.z+=130; v2r.z+=130;
  
  triangle translatedTriangle = new triangle(v0r,v1r,v2r);
  
  afterStateTriangles.add(translatedTriangle);
  
  boolean isVisible  = NormalTriangle(translatedTriangle);
  
  if (isVisible==true) {
      int[]shading = getTriangleShading(translatedTriangle, red, green, blue);
      
      int shadedRed = shading[0];
      int shadedGreen = shading[1];
      int shadedBlue = shading[2];
      
      translatedTriangle.red = shadedRed;
      translatedTriangle.green = shadedGreen;
      translatedTriangle.blue = shadedBlue;
        
      // Project vertices using the projection matrix
      triangle projectedTriangle = new triangle(
      MatrixVectorMultiplication(translatedTriangle.vertices.get(0), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(1), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(2), projectionMatrix));
     
      projectedTriangle.red = translatedTriangle.red;
      projectedTriangle.green = translatedTriangle.green;
      projectedTriangle.blue = translatedTriangle.blue;
      
      triangle scaledTriangle = scaleTriangle(projectedTriangle, sf, sf, sf);
      
      PVector v0 = scaledTriangle.vertices.get(0);
      PVector v1 = scaledTriangle.vertices.get(1);
      PVector v2 = scaledTriangle.vertices.get(2);

      v0.x +=1; v0.y+=1; v0.z+=1;
      v1.x +=1; v1.y+=1; v1.z+=1;
      v2.x +=1; v2.y+=1; v2.z+=1;
      
      v0.x *= (enemyScalingHorizontalFactor);
      v1.x *= (enemyScalingHorizontalFactor);
      v2.x *= (enemyScalingHorizontalFactor);
      
      v0.y *= (enemyScalingVerticalFactor);
      v1.y *= (enemyScalingVerticalFactor);
      v2.y *= (enemyScalingVerticalFactor);
      
      triangle finalTriangle = new triangle(v0,v1,v2);
      
      finalTriangle.red = shadedRed;
      finalTriangle.green = shadedGreen;
      finalTriangle.blue = shadedBlue;
      
      // Draw the projected triangle outline
      triangles.add(finalTriangle);
      afterStateEnemy.add(finalTriangle);
    }
}

void meshBulletProjection(triangle t, ArrayList<triangle> triangles, bullet bullet, int red, int green, int blue) {
  
  triangle rotatedTriangle = rotateTriangleSingleAxis(t, bulletRotationMat);
  
  PVector v0r = t.vertices.get(0);
  PVector v1r = t.vertices.get(1);
  PVector v2r = t.vertices.get(2);
  
  //triangle translatedTriangle = translateTriangle(rotatedTriangle,tx,ty,tz);
  
  v0r.x += tx; v1r.x+=tx; v2r.x+=tx;
  v0r.y += ty; v1r.y+=ty; v2r.y+=ty;
  v0r.z += bullet.z; v1r.z+=bullet.z; v2r.z+=bullet.z;
  
  triangle translatedTriangle = new triangle(v0r,v1r,v2r);
  
  boolean isVisible  = NormalTriangle(translatedTriangle);
  
  if (isVisible==true) {
      int shading = getTriangleShadingMono(translatedTriangle);
      
      translatedTriangle.red = shading;
      translatedTriangle.green = shading;
      translatedTriangle.blue = shading;
        
      // Project vertices using the projection matrix
      triangle projectedTriangle = new triangle(
      MatrixVectorMultiplication(translatedTriangle.vertices.get(0), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(1), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(2), projectionMatrix));
      
      triangle scaledTriangle = scaleTriangle(projectedTriangle, 5, 5, 5);
     
      PVector v0 = scaledTriangle.vertices.get(0);
      PVector v1 = scaledTriangle.vertices.get(1);
      PVector v2 = scaledTriangle.vertices.get(2);
      
      v0.x +=bullet.x; v0.y+=bullet.y; v0.z+=bullet.z;
      v1.x +=bullet.x; v1.y+=bullet.y; v1.z+=bullet.z;
      v2.x +=bullet.x; v2.y+=bullet.y; v2.z+=bullet.z;
      
      scaledTriangle.red = red;
      scaledTriangle.green = green;
      scaledTriangle.blue = blue;

      triangles.add(scaledTriangle);

    }
}
void textMeshProjection(triangle t, ArrayList<triangle> triangles) {
  // Rotate vertices
  
  triangle rotatedTriangle = rotateTriangleSingleAxis(t, textRotationMat);
  
  // Translate vertices
  //triangle translatedTriangle = translateTriangle(rotatedTriangle, tx, ty, tz);
  PVector v0r = rotatedTriangle.vertices.get(0);
  PVector v1r = rotatedTriangle.vertices.get(1);
  PVector v2r = rotatedTriangle.vertices.get(2);
  
  //triangle translatedTriangle = translateTriangle(rotatedTriangle,tx,ty,tz);
  
  v0r.x += ttx; v1r.x+=ttx; v2r.x+=ttx;
  v0r.y += tty; v1r.y+=tty; v2r.y+=tty;
  v0r.z += ttz; v1r.z+=ttz; v2r.z+=ttz;
  
  triangle translatedTriangle = new triangle(v0r,v1r,v2r);
  
  afterStateTriangles.add(translatedTriangle);
  
  boolean isVisible  = NormalTriangle(translatedTriangle);
  
  if (isVisible==true) {
      int shading = getTriangleShadingMono(translatedTriangle);
      
      translatedTriangle.red = shading;
      translatedTriangle.green = shading;
      translatedTriangle.blue = shading;
        
      // Project vertices using the projection matrix
      triangle projectedTriangle = new triangle(
      MatrixVectorMultiplication(translatedTriangle.vertices.get(0), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(1), projectionMatrix),
      MatrixVectorMultiplication(translatedTriangle.vertices.get(2), projectionMatrix));
     
      projectedTriangle.red = translatedTriangle.red;
      projectedTriangle.green = translatedTriangle.green;
      projectedTriangle.blue = translatedTriangle.blue;
      
      //triangle scaledTriangle = scaleTriangle(projectedTriangle, 40, 40, 40);
      
      PVector v0 = projectedTriangle.vertices.get(0);
      PVector v1 = projectedTriangle.vertices.get(1);
      PVector v2 = projectedTriangle.vertices.get(2);
      
      v0.x +=1; v0.y+=1; v0.z+=1;
      v1.x +=1; v1.y+=1; v1.z+=1;
      v2.x +=1; v2.y+=1; v2.z+=1;
      
      v0.x *= (0.5*screenWidth);
      v1.x *= (0.5*screenWidth);
      v2.x *= (0.5*screenWidth);
      
      v0.y *= (0.5*screenHeight)-100;
      v1.y *= (0.5*screenHeight)-100;
      v2.y *= (0.5*screenHeight)-100;
      
      triangle scaledTriangle = new triangle(v0,v1,v2);
      
      scaledTriangle.red = shading;
      scaledTriangle.green = shading;
      scaledTriangle.blue = shading;
      
      // Draw the projected triangle outline
      triangles.add(scaledTriangle);
      afterStateEnemy.add(scaledTriangle);
    }
}
