public class bullet {
  public float x;
  public float y;
  public float z;
  public mesh mesh;
  public mesh objectOrigin;
  public final float size = 1;
  public boolean foward; //true = foward ; false = backwards
  public boolean exclude;
  
  public bullet(float x, float y, float z, boolean foward, mesh origin) {
    this.mesh = new mesh();
    this.mesh.loadObjectFile(filepath+"objects/missile.obj", "");
    this.objectOrigin = origin;
    this.x = 50*size;
    this.y = 50*size;
    this.z = 120;
    this.foward = foward;
    this.exclude = false;
  }
  
  public void translate(mesh origin){
    triangle tOrigin = origin.currentTris.get(1);
    PVector vOrigin = tOrigin.vertices.get(1);
    for (triangle t : mesh.tris) {
      PVector v0r = t.vertices.get(0);
      PVector v1r = t.vertices.get(1);
      PVector v2r = t.vertices.get(2);

      v0r.x += vOrigin.x; v1r.x+=vOrigin.x; v2r.x+=vOrigin.x;
      v0r.y += vOrigin.y; v1r.y+=vOrigin.y; v2r.y+=vOrigin.y;
    }
  }
}

void foward(bullet bullet) {
    if (bullet.foward == true) {
      bullet.z += 0.1;
    }
    if (bullet.foward == false) {
      bullet.z -= 0.1;
    }
    
  }

bullet createBullet(mesh object){
  bullet bullet = new bullet(object.bulletSpawn.x,object.bulletSpawn.y,object.bulletSpawn.z, object.bulletDirection, object);
  triangle tOrigin = triangles.get(2);
  PVector vOrigin = tOrigin.vertices.get(1);
  bullet.x = vOrigin.x;
  bullet.y = vOrigin.y;
  return bullet;
}
