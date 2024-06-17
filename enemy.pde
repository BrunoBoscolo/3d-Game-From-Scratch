import java.util.Random;

public class enemy {
    public float x;
    public float y;
    public float z = 130;
    public mesh mesh;
    public final float size = 1;
    private Random random;
    private float targetX;
    private float targetY;
    private float speed = 0.1f;  // Adjust this to control the speed

    public enemy(float x, float y, float z) {
        this.mesh = new mesh();
        this.mesh.loadObjectFile("E:/3d-game-engine-from-scratch-main/game_engine_3d/objects/enemy.obj", "");
        this.x = x;
        this.y = y;
        this.z = z;
        this.random = new Random();
        chooseNewTarget();
    }

    private void chooseNewTarget() {
        this.targetX = random.nextFloat() * (15.1f - (-15.1f)) + (-15.1f);
        this.targetY = random.nextFloat() * (8.1f - (-8.1f)) + (-8.1f);
    }

    public void moviment() {
        float directionX = targetX - x;
        float directionY = targetY - y;
        float distance = (float) Math.sqrt(directionX * directionX + directionY * directionY);

        if (distance < 0.1f) {  // If close to the target, choose a new target
            chooseNewTarget();
        } else {
            // Normalize direction
            directionX /= distance;
            directionY /= distance;

            // Add some curvature
            float angle = (random.nextFloat() - 0.5f) * 0.2f;  // Small random angle
            float sinAngle = (float) Math.sin(angle);
            float cosAngle = (float) Math.cos(angle);

            float newDirectionX = directionX * cosAngle - directionY * sinAngle;
            float newDirectionY = directionX * sinAngle + directionY * cosAngle;

            // Move towards the target with added curvature
            this.x += newDirectionX * speed;
            this.y += newDirectionY * speed;
        }

        // Ensure the enemy stays within bounds (optional if you don't want the enemy to leave the area)
        this.x = Math.max(-15.1f, Math.min(15.1f, this.x));
        this.y = Math.max(-8.1f, Math.min(8.1f, this.y));
       
    }
      
}

public  enemy createEnemy() {
        return new enemy(screenWidth / 2, screenHeight / 2, etz);
}
