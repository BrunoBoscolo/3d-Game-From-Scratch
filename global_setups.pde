mesh meshCube = new mesh();
mesh arwing = new mesh();
mesh titleMesh = new mesh();

mat4x4 zRotMat = new mat4x4();
mat4x4 xRotMat = new mat4x4();
mat4x4 yRotMat = new mat4x4();

mat4x4 bulletRotationMat = new mat4x4();
mat4x4 textRotationMat = new mat4x4();
mat4x4 EmemyRotationMatX = new mat4x4();
mat4x4 EmemyRotationMatY = new mat4x4();
mat4x4 EmemyRotationMatZ = new mat4x4();

mat4x4 EmemyTextRotationMatX = new mat4x4();
mat4x4 EmemyTextRotationMatY = new mat4x4();
mat4x4 EmemyTextRotationMatZ = new mat4x4();

mat4x4 projectionMatrix = new mat4x4();
mat4x4 translationMatrix = new mat4x4();
mat4x4 identityMatrix = new mat4x4();

enemy enemy = createEnemy();
enemy textEnemy = createEnemy();

PImage background;

PVector camera = new PVector(0,0,0);

float xtheta=0, ztheta=-0.3, ytheta=3.3;

float bxtheta=0, bztheta=0, bytheta=0;

float extheta=0, eztheta=0, eytheta=0;

float txtheta=-3.3, tztheta=0, tytheta=0;

final float screenWidth = 1280.0f;
final float screenHeight = 800.0f;

float enemyScalingHorizontalFactor = 0.5*screenWidth;
float enemyScalingVerticalFactor = 0.5*screenHeight;

float tx = 0;
float ty = 0;
float tz = 70;

float etx, tetx = 0;
float ety, tety = 0;
float etz, tetz = 130;

float ttx = 0;
float tty = 0;
float ttz = 130;

float menuEnemyRotation = 0;

boolean bgMode = true;
boolean rasterizerMode = true;
boolean pointMode = false;

int gameMode = 0;
int score = 0;
int bulletTimeout = 0;

int timeDif = 0, bulletDif = 0, speedDif = 0, upDif = 0;
  
ArrayList<bullet> bullets = new ArrayList<>();
ArrayList<bullet> renderBullets = new ArrayList<>();

ArrayList<triangle> triangles = new ArrayList<>();
ArrayList<triangle> afterStateEnemy = new ArrayList<>();
ArrayList<triangle> afterStateTriangles = new ArrayList<>();

PFont titleFont;
PFont speakFont;
PFont speakFont8;
PFont speakFont16;
PFont speakFont64;
PFont speakFont128;

Animation explosion;

float sA=0, iA=0, cA=0;

boolean countdownStarted = false;
int countdownDuration = 10;
int bulletCountdown = 10;
int remainingTime;
long startTime;

boolean sAd = true, iAd = false, cAd = true;

SoundFile laser;
SoundFile menuMusic;
SoundFile playMusic;
SoundFile timeOver;
SoundFile gameStart;
SoundFile hitting;
