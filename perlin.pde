import java.util.Random;

public class PerlinNoise {
    private int[] permutationTable;
    private Random random;

    public PerlinNoise(long seed) {
        random = new Random(seed);
        permutationTable = new int[512];
        int[] p = new int[256];
        for (int i = 0; i < 256; i++) p[i] = i;
        for (int i = 0; i < 256; i++) {
            int j = random.nextInt(256);
            int swap = p[i];
            p[i] = p[j];
            p[j] = swap;
        }
        for (int i = 0; i < 512; i++) permutationTable[i] = p[i & 255];
    }

    private  double fade(double t) {
        return t * t * t * (t * (t * 6 - 15) + 10);
    }

    private  double lerp(double t, double a, double b) {
        return a + t * (b - a);
    }

    private  double grad(int hash, double x, double y, double z) {
        int h = hash & 15;
        double u = h < 8 ? x : y;
        double v = h < 4 ? y : (h == 12 || h == 14 ? x : z);
        return ((h & 1) == 0 ? u : -u) + ((h & 2) == 0 ? v : -v);
    }

    public double noise(double x, double y, double z) {
        int X = (int) Math.floor(x) & 255;
        int Y = (int) Math.floor(y) & 255;
        int Z = (int) Math.floor(z) & 255;

        x -= Math.floor(x);
        y -= Math.floor(y);
        z -= Math.floor(z);

        double u = fade(x);
        double v = fade(y);
        double w = fade(z);

        int A = permutationTable[X] + Y;
        int AA = permutationTable[A] + Z;
        int AB = permutationTable[A + 1] + Z;
        int B = permutationTable[X + 1] + Y;
        int BA = permutationTable[B] + Z;
        int BB = permutationTable[B + 1] + Z;

        return lerp(w, lerp(v, lerp(u, grad(permutationTable[AA], x, y, z), grad(permutationTable[BA], x - 1, y, z)),
                lerp(u, grad(permutationTable[AB], x, y - 1, z), grad(permutationTable[BB], x - 1, y - 1, z))),
                lerp(v, lerp(u, grad(permutationTable[AA + 1], x, y, z - 1), grad(permutationTable[BA + 1], x - 1, y, z - 1)),
                lerp(u, grad(permutationTable[AB + 1], x, y - 1, z - 1), grad(permutationTable[BB + 1], x - 1, y - 1, z - 1))));
    }
}
