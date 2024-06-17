static class TriangleComparator implements Comparator<triangle> {
  public int compare(triangle t1, triangle t2) {
    float medianZ1 = t1.getMedianZ();
    float medianZ2 = t2.getMedianZ();
    return Float.compare(medianZ2, medianZ1); // Compare in descending order (farthest away first)
  }
}

public static void sortTrianglesByMedianZ(ArrayList<triangle> triangles) {
  Collections.sort(triangles, new TriangleComparator());
}

void printTriangleParameters(triangle t) {
  println("Triangle Parameters:");
  for (int i = 0; i < t.vertices.size(); i++) {
    PVector v = t.vertices.get(i);
    println("Vertex " + (i+1) + ": (" + v.x + ", " + v.y + ", " + v.z + ")");
  }
}
