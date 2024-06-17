// Classes

public class vec3d {
  public float x;
  public float y;
  public float z;
  
  public vec3d(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
}

public class triangle {
  public ArrayList<PVector> vertices;
  
  public int red;
  public int green;
  public int blue;
  
  public PImage texture;
  
  public triangle(PVector v1, PVector v2, PVector v3) {
    vertices = new ArrayList<PVector>();
    vertices.add(v1);
    vertices.add(v2);
    vertices.add(v3);
  }
  
  public float getMedianZ() {
    float medianZ = 0.0f;
    for (PVector vertex : vertices) {
        medianZ += vertex.z;
    }
    return medianZ / vertices.size();
  }
  
  public String verticesToString() {
        PVector v0 = vertices.get(0);
        PVector v1 = vertices.get(1);
        PVector v2 = vertices.get(2);
        return String.format("v0: %f, %f | v1: %f, %f | v2: %f, %f", 
                             v0.x, v0.y, v1.x, v1.y, v2.x, v2.y);
    }
    
}

public class mesh {
  public ArrayList<triangle> tris;
  public ArrayList<triangle> currentTris;
  public PVector bulletSpawn;
  public boolean bulletDirection;
  public float hitboxX = 50;
  public float hitBoxY = 50;
      
  public mesh() {
    tris = new ArrayList<triangle>();
    currentTris = new ArrayList<triangle>();
    bulletSpawn = new PVector(0,0,0);
  }
  
  public boolean isCollidingBullet(mesh object, ArrayList<triangle> selfTriangles, float bulletX, float bulletY, float bulletZ) {
    int hitBoxX = 50;
    int hitBoxY = 50;
    
    PVector selfMedian = this.getMedianValues(selfTriangles);
    selfMedian.x /= 3 ; selfMedian.y /= 3 ; selfMedian.z /= 3;
    PVector selfHitboxStart = new PVector(selfMedian.x - hitBoxX, selfMedian.y - hitBoxY, selfMedian.z-10);
    PVector selfHitboxEnd = new PVector(selfMedian.x + hitBoxX, selfMedian.y + hitBoxY, selfMedian.z+10);
    PVector objectHitboxStart = new PVector(bulletX - 20, bulletY, bulletZ-10);
    PVector objectHitboxEnd = new PVector(bulletX + 20, bulletY, bulletZ+10);
    
    // Check for collision along each axis
    boolean xCollision = (selfHitboxStart.x <= objectHitboxEnd.x && selfHitboxEnd.x >= objectHitboxStart.x);
    boolean yCollision = (selfHitboxStart.y <= objectHitboxEnd.y && selfHitboxEnd.y >= objectHitboxStart.y);
    boolean zCollision = (selfHitboxStart.z <= objectHitboxEnd.z && selfHitboxEnd.z >= objectHitboxStart.z);
    // Return true if there's a collision along all axes
    return xCollision && yCollision && true;
}
  
  public PVector getMedianValues(ArrayList<triangle> triangles) {
        PVector median = new PVector(0,0,0);
        float totalX = 0.0f;
        float totalY = 0.0f;
        float totalZ = 0.0f;
        
        // Calculate the total sum of x, y, and z coordinates
        for (triangle t : triangles) {
            for (PVector vertex : t.vertices) {
                totalX += vertex.x;
                totalY += vertex.y;
                totalZ += vertex.z;
            }
        }
        
        // Calculate the median values
        float medianX = totalX / (triangles.size()); // Dividing by the total number of vertices
        float medianY = totalY / (triangles.size());
        float medianZ = totalZ / (triangles.size());
        
        median.x = medianX; median.y = medianY; median.z = medianZ;
        
        return median;
    }
  
  public void addTriangle(triangle t){
    tris.add(t);
  }
  
  public void addSpawnPoint(PVector spawn){
    bulletSpawn = spawn;
  }
  
  public void addBulletDirection(boolean foward) {
    bulletDirection = foward;
  }  
  
  public void printMesh() {
    println("Mesh contains " + tris.size() + " triangles:");
    for (int i = 0; i < tris.size(); i++) {
        triangle t = tris.get(i);
        println("Triangle " + (i + 1) + ":\n " + t.verticesToString()+"\n");
    }
  }
  
  boolean loadObjectFile(String filename, String materialPath) {
    ArrayList<PVector> vertexes = new ArrayList<PVector>();
    int red=0;
    int green=0;
    int blue=0;
    
    try {
        BufferedReader reader = new BufferedReader(new FileReader(filename));
        String line;
  
        while (reader.ready()) {
            line = reader.readLine();
            String[] pieces = line.trim().split("\\s+");
            
            if (pieces[0].equals("C")) {
                // Store the material name
                red = int(pieces[1]);
                green = int(pieces[2]);
                blue = int(pieces[3]);

            }
            
            if (pieces[0].equals("v")) {
                PVector vector = new PVector(0, 0, 0);
                vector.x = Float.parseFloat(pieces[1]);
                vector.y = Float.parseFloat(pieces[2]);
                vector.z = Float.parseFloat(pieces[3]);
                vertexes.add(vector);
            }
            
            if (pieces[0].equals("f")) {
                int v1Index = Integer.parseInt(pieces[1]) - 1;
                int v2Index = Integer.parseInt(pieces[2]) - 1;
                int v3Index = Integer.parseInt(pieces[3]) - 1;
                
                PVector v1 = vertexes.get(v1Index);
                PVector v2 = vertexes.get(v2Index);
                PVector v3 = vertexes.get(v3Index);
                
                triangle t = new triangle(v1, v2, v3);
                
                t.red = red;
                t.blue = blue;
                t.green = green;
                
                tris.add(t); // Add the triangle to the tris ArrayList of the mesh
                currentTris.add(t);
            }
        }
        reader.close();
        
        } catch (Exception e) {
            println("Error loading object file: " + e.getMessage());
            return false;
        }
        
        return true;
}
    
    public void printCMesh() {
      println("Mesh contains " + currentTris.size() + " triangles:");
      for (int i = 0; i < currentTris.size(); i++) {
          triangle t = currentTris.get(i);
          println("Triangle " + (i + 1) + ":\n " + t.verticesToString()+"\n");
      }
    }
  
    public PVector getVertexWithMaxZ() {
      PVector maxZVertex = null;
      float maxZ = Float.NEGATIVE_INFINITY;
  
      for (triangle tri : currentTris) {
          for (PVector vertex : tri.vertices) {
              if (vertex.z > maxZ) {
                  maxZ = vertex.z;
                  maxZVertex = vertex;
              }
          }
      }

    return maxZVertex;
   }
}

public class mat4x4 {
    public float[][] matrix;

    // Constructor to initialize the matrix
    public mat4x4() {
        matrix = new float[4][4];
        // Initialize all values as 0
        for (int i = 0; i < 4; i++) {
            for (int j = 0; j < 4; j++) {
                matrix[i][j] = 0.0f;
            }
        }
    }
    
    public float get(int row, int col) {
        if (row >= 0 && row < 4 && col >= 0 && col < 4) {
            return matrix[row][col];
        } else {
            println("Invalid row or column index.");
            return 0.0f; // Return 0 if the indices are invalid
        }
    }

    // Method to set the value of a specific element in the matrix
    public void set(int row, int col, float value) {
        if (row >= 0 && row < 4 && col >= 0 && col < 4) {
            matrix[row][col] = value;  
        } else {
            println("Invalid row or column index.");
        }
    }
}
