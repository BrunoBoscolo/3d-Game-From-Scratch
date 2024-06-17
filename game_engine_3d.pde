import java.io.*;
import java.util.*;
import java.util.Iterator;

void setup(){
  size(1280,800);
  background = loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/objects/background.png");
  // Projection matrix parameters;
  float near = 0.1f;
  float far = 1000.0f;
  float fov = 120.0f;
  float aspectRatio = screenHeight/screenWidth;
  float fovRad = 1.0f / (tan((fov*0.5f)/(180.0f*3.14159f))); //FOV in radians
  
  // Projection matrix setup;
  projectionMatrix.set(0,0,(aspectRatio*fovRad));
  projectionMatrix.set(1,1,fovRad);
  projectionMatrix.set(2,2,(far/(far-near)));
  projectionMatrix.set(3,2,((-far*near)/(far-near)));
  projectionMatrix.set(2,3,1.0f);
  projectionMatrix.set(3,3,0.0f);
  
  String filename = "C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/fonts/title.obj";
  boolean success = titleMesh.loadObjectFile(filename, "C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/objects/arwingMaterials/");
  if (success) {
      println("Object file loaded successfully.");
  } else {
      println("Failed to load object file: " + filename);
  }
  
  titleFont = createFont("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/fonts/Arwing.ttf", 64);
  speakFont = createFont("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/fonts/all-aircraft-report.ttf", 32);
  speakFont8 = createFont("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/fonts/all-aircraft-report.ttf", 16);
  speakFont64 = createFont("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/fonts/all-aircraft-report.ttf", 64);
  speakFont128 = createFont("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/fonts/all-aircraft-report.ttf", 128);
  
  laser = new SoundFile(this,"C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sounds/laser.mp3");
  menuMusic = new SoundFile(this,"C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sounds/menuMusic.mp3");
  gameStart = new SoundFile(this,"C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sounds/gameStart.mp3");
  hitting = new SoundFile(this,"C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sounds/hitting.mp3");
  playMusic = new SoundFile(this,"C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sounds/gameMusic.mp3");
  
  //Mesh Setup
  
  filename = "C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/objects/Arwing.obj";
  success = arwing.loadObjectFile(filename, "C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/objects/arwingMaterials/");
  if (success) {
      println("Object file loaded successfully.");
  } else {
      println("Failed to load object file: " + filename);
  }
  arwing.addBulletDirection(true);
  arwing.addSpawnPoint(arwing.getVertexWithMaxZ());
 
}

void draw() {
  if (gameMode == 0) { //Menu mode
    if(menuMusic.isPlaying() == false){
      menuMusic.play();
    }
    background(0);
    
    xRotationMatrixSetup(txtheta, textRotationMat);
  
    for (triangle t : titleMesh.tris) {
       textMeshProjection(t, triangles);
    }
    
    sortTrianglesByMedianZ(triangles);
    
    for (triangle t : triangles) {
             rasterizeTriangle(t);
    }
    
    if (mousePressed && (mouseButton == LEFT)) {
      if (mouseButton == LEFT) {
        if (mouseX >= 500 && mouseX <= 800 && mouseY >= 440 && mouseY<= 530) {
         gameMode = 5;
        }
        if (mouseX >= 522 && mouseX <= 750 && mouseY >= 575 && mouseY<= 600) {
         gameMode = 2; 
        }
        if (mouseX >= 575 && mouseX <= 700 && mouseY >= 620 && mouseY<= 645) {
         gameMode = 4; 
        }
        if (mouseX >= 600 && mouseX <= 750 && mouseY >= 650 && mouseY<= 690) {
         gameMode = 3; 
        }
      }
    }
    
    //text(nf(mouseX) + "," + nf(mouseY), mouseX,mouseY-10);
    textAlign(CENTER);
    
    if (sAd == true) {
      sA += 0.3;
    } else {
      sA -= 0.3;
    }
    
    if (sA>=5) {
      sAd = false;
    }
    if (sA<=-5) {
      sAd = true;
    }
    
    if (iAd == true) {
      iA += 0.3;
    } else {
      iA -= 0.3;
    }
    
    if (iA>=7) {
      iAd = false;
    }
    if (iA<=-7) {
      iAd = true;
    }
    
    if (cAd == true) {
      cA += 0.3;
    } else {
      cA -= 0.3;
    }
    
    if (cA>=7) {
      cAd = false;
    }
    if (cA<=-7) {
      cAd = true;
    }
    
    pushMatrix();
    textFont(speakFont128);
    translate(screenWidth/2,screenHeight*0.66);
    rotate(radians(sA));
    text("Start", 0,0);
    popMatrix();
    
    pushMatrix();
    textFont(speakFont);
    translate(screenWidth/2,screenHeight*0.75);
    rotate(radians(iA));
    text("Instructions", 0,0);
    popMatrix();
    
    pushMatrix();
    translate(screenWidth/2,screenHeight*0.80);
    rotate(radians(sA));
    text("History", 0,0 );
    popMatrix();
    
    pushMatrix();
    translate(screenWidth/2,screenHeight*0.85);
    rotate(radians(cA));
    text("Credits", 0,0 );
    popMatrix();
    
    afterStateTriangles = new ArrayList<>();
    
    afterStateEnemy = new ArrayList<>();
    
    triangles = new ArrayList<>();
  
  }
  
  if (gameMode == 2) { //Instructions mode
    background(0);
    
    if (sAd == true) {
      sA += 0.3;
    } else {
      sA -= 0.3;
    }
    
    if (sA>=5) {
      sAd = false;
    }
    if (sA<=-5) {
      sAd = true;
    }
    
    if (mousePressed && (mouseButton == LEFT)) {
      if (mouseButton == LEFT) {
        if (mouseX >= 595 && mouseX <= 684 && mouseY >= 688 && mouseY<= 724) {
         gameMode = 0; 
        }
      }
    }
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.90);
    rotate(radians(sA));
    text("back", 0,0 );
    popMatrix();
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.20);
    text("This game is about shooting the enemy ship\n as many times as you can within\n a limited amout of time\n\nPress lM to shoot and AWSD to move.", 0,0 );
    popMatrix();
    
    menuEnemyRotation += 0.01;
    
    yRotationMatrixSetup(menuEnemyRotation, EmemyTextRotationMatX);
    xRotationMatrixSetup(3.3, EmemyTextRotationMatY);
    zRotationMatrixSetup(0, EmemyTextRotationMatZ);
    
    enemyScalingHorizontalFactor = (0.5*screenWidth)-10;
    enemyScalingVerticalFactor = (0.5*screenHeight)-10;
    
    ety = 2;
    for (triangle t : enemy.mesh.tris) {
     meshTextEnemyProjectionSetup(t, triangles, t.red, t.green, t.blue, 2, textEnemy);
    }
    
    sortTrianglesByMedianZ(triangles);
    
    for (triangle t : triangles) {
      rasterizeTriangle(t);
      drawTriangleOutline(t);
    }
    
    afterStateTriangles = new ArrayList<>();
    
    afterStateEnemy = new ArrayList<>();
    
    triangles = new ArrayList<>();
    
  }
  
  if (gameMode == 3) { //Credits mode
    background(0);
    
    if (sAd == true) {
      sA += 0.3;
    } else {
      sA -= 0.3;
    }
    
    if (sA>=5) {
      sAd = false;
    }
    if (sA<=-5) {
      sAd = true;
    }
    
    if (mousePressed && (mouseButton == LEFT)) {
      if (mouseButton == LEFT) {
        if (mouseX >= 595 && mouseX <= 684 && mouseY >= 688 && mouseY<= 724) {
         gameMode = 0; 
        }
      }
    }
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.90);
    rotate(radians(sA));
    text("back", 0,0 );
    popMatrix();
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.20);
    text("Made By Bruno Boscolo and Nicholas Apolinario\nFor a college project", 0,0 );
    popMatrix();
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.50);
    text("supervising professor: Jose Picolo", 0,0 );
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/picollo.png"),0,0);
    popMatrix();
  }
  
  if (gameMode == 4) { //History mode
    background(0);
    
    if (sAd == true) {
      sA += 0.3;
    } else {
      sA -= 0.3;
    }
    
    if (sA>=5) {
      sAd = false;
    }
    if (sA<=-5) {
      sAd = true;
    }
    
    if (mousePressed && (mouseButton == LEFT)) {
      if (mouseButton == LEFT) {
        if (mouseX >= 595 && mouseX <= 684 && mouseY >= 688 && mouseY<= 724) {
         gameMode = 0; 
        }
      }
    }
    
    text(nf(mouseX) + "," + nf(mouseY), mouseX,mouseY-10);
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.90);
    rotate(radians(sA));
    textFont(speakFont);
    text("back", 0,0 );
    popMatrix();
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.20);
    textFont(speakFont8);
    text("You are in a contest to be the brand new protagonist of the game Star Fox\n.The galaxy is in turmoil, and the Star Fox team is in need\nof a new leader, a new hero to take the reins and lead\nthem to victory against the forces of evil. This is your\nchance to prove your worth and show that you have what\nit takes to be the next great hero.\nThe winner is the person that gets\nmore points in the training chamber.\nThe training chamber is a state-of-the-art facility, designed\nto test every aspect of a pilot's skills. From sharp shooting\nto evasive maneuvers, every challenge you face will push\nyou to your limits. You'll be competing against the best\npilots in the galaxy, each one vying for the top spot. Only\nthe most skilled, the most determined, and the most\ncourageous will rise to the top and earn the title of\nStar Fox's new leader.\nGear up, pilot. The fate of the galaxy rests in your hands!\nAre you ready to take on the challenge and become the next\nlegendary hero of Star Fox? The training chamber awaits!", 0,0 );
    popMatrix();
    
  }
  
  if (gameMode == 5) { //Dificulty Selector Mode
    background(0);
    
    if (sAd == true) {
      sA += 0.3;
    } else {
      sA -= 0.3;
    }
    
    if (sA>=5) {
      sAd = false;
    }
    if (sA<=-5) {
      sAd = true;
    }
    
    if (cAd == true) {
      cA += 0.3;
    } else {
      cA -= 0.3;
    }
    
    if (cA>=7) {
      cAd = false;
    }
    if (cA<=-7) {
      cAd = true;
    }
    
    if (mousePressed && (mouseButton == LEFT)) {
      if (mouseButton == LEFT) {
        
      }
    }
    
    text(nf(mouseX) + "," + nf(mouseY), mouseX,mouseY-10);
    
    pushMatrix();
    translate(80,0);
    pushMatrix();
    translate(screenWidth/4,screenHeight*0.20);
    scale(2);
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/frame.png"),0,0);
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/speedIcon.png"),0,0);
    popMatrix();
    
    pushMatrix();
    translate(screenWidth/4,screenHeight*0.30);
    scale(2);
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/frame.png"),0,0);
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/timeIcon.png"),0,0);
    popMatrix();
    
    pushMatrix();
    translate(screenWidth/4,screenHeight*0.40);
    scale(2);
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/frame.png"),0,0);
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/bulletIcon.png"),0,0);
    popMatrix();
    
    pushMatrix();
    translate(screenWidth/4,screenHeight*0.50);
    scale(2);
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/frame.png"),0,0);
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/upIcon.png"),0,0);
    popMatrix();
    
    pushMatrix();
    fill(122,122,255);
    rect(405,163,120,56);
    rect(405,243,120,56);
    rect(405,323,120,56);
    rect(405,403,120,56);
    popMatrix();

    pushMatrix();
    fill(122,255,122);
    rect(550,163,120,56);
    rect(550,243,120,56);
    rect(550,323,120,56);
    rect(550,403,120,56);
    popMatrix();
    
    pushMatrix();
    fill(255,155,155);
    rect(695,163,120,56);
    rect(695,243,120,56);
    rect(695,323,120,56);
    rect(695,403,120,56);
    popMatrix();
    
    if (speedDif == 0) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,160+40);
      popMatrix();
    } 
    if (speedDif == 0) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,160+40);
      popMatrix();
    }
    if (speedDif == 0) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,160+40);
      popMatrix();
    }
    
    //Dif 1
    
    if (speedDif == 1) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("New",405+60,160+40);
      popMatrix();
    }
    if (speedDif == 1) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,160+40);
      popMatrix();
    }
    if (speedDif == 1) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,160+40);
      popMatrix();
    }
    
    //Dif 2
    
    if (speedDif == 2) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,160+40);
      popMatrix();
    }
    if (speedDif == 2) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("Ok",550+63,160+40);
      popMatrix();
    }
    if (speedDif == 2) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,160+40);
      popMatrix();
    }
    
    if (speedDif == 3) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,160+40);
      popMatrix();
    }
    if (speedDif == 3) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,160+40);
      popMatrix();
    }
    if (speedDif == 3) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("Real",695+65,160+40);
      popMatrix();
    }
    
     // Time setup
     
    if (timeDif == 0) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,243+40);
      popMatrix();
    } 
    if (timeDif == 0) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,243+40);
      popMatrix();
    }
    if (timeDif == 0) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,243+40);
      popMatrix();
    }
    
    //Dif 1
    
    if (timeDif == 1) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("New",405+60,243+40);
      popMatrix();
    }
    if (timeDif == 1) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,243+40);
      popMatrix();
    }
    if (timeDif == 1) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,243+40);
      popMatrix();
    }
    
    //Dif 2
    
    if (timeDif == 2) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,243+40);
      popMatrix();
    }
    if (timeDif == 2) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("Ok",550+63,243+40);
      popMatrix();
    }
    if (timeDif == 2) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,243+40);
      popMatrix();
    }
    
    if (timeDif == 3) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,243+40);
      popMatrix();
    }
    if (timeDif == 3) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,243+40);
      popMatrix();
    }
    if (timeDif == 3) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("Real",695+65,243+40);
      popMatrix();
    }
    
    //Bullet dif
    
    if (bulletDif == 0) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,323+40);
      popMatrix();
    } 
    if (bulletDif == 0) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,323+40);
      popMatrix();
    }
    if (bulletDif == 0) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,323+40);
      popMatrix();
    }
    
    //Dif 1
    
    if (bulletDif == 1) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("New",405+60,323+40);
      popMatrix();
    }
    if (bulletDif == 1) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,323+40);
      popMatrix();
    }
    if (bulletDif == 1) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,323+40);
      popMatrix();
    }
    
    //Dif 2
    
    if (bulletDif == 2) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,323+40);
      popMatrix();
    }
    if (bulletDif == 2) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("Ok",550+63,323+40);
      popMatrix();
    }
    if (bulletDif == 2) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,323+40);
      popMatrix();
    }
    
    if (bulletDif == 3) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,323+40);
      popMatrix();
    }
    if (bulletDif == 3) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,323+40);
      popMatrix();
    }
    if (bulletDif == 3) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("Real",695+65,323+40);
      popMatrix();
    }
    
    //Up dif
    
    if (upDif == 0) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,403+40);
      popMatrix();
    } 
    if (upDif == 0) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,403+40);
      popMatrix();
    }
    if (upDif == 0) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,403+40);
      popMatrix();
    }
    
    //Dif 1
    
    if (upDif == 1) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("New",405+60,403+40);
      popMatrix();
    }
    if (upDif == 1) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,403+40);
      popMatrix();
    }
    if (upDif == 1) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,403+40);
      popMatrix();
    }
    
    //Dif 2
    
    if (upDif == 2) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,403+40);
      popMatrix();
    }
    if (upDif == 2) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("Ok",550+63,403+40);
      popMatrix();
    }
    if (upDif == 2) {
      pushMatrix();
      fill(155,55,55);
      textFont(speakFont);
      text("Real",695+65,403+40);
      popMatrix();
    }
    
    if (upDif == 3) {
      pushMatrix();
      fill(55,55,155);
      textFont(speakFont);
      text("New",405+60,403+40);
      popMatrix();
    }
    if (upDif == 3) {
      pushMatrix();
      fill(55,155,55);
      textFont(speakFont);
      text("Ok",550+63,403+40);
      popMatrix();
    }
    if (upDif == 3) {
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text("Real",695+65,403+40);
      popMatrix();
    }
    popMatrix();
    
    
    if (mousePressed && (mouseButton == LEFT)) {
        
        if (mouseX >= 406+80 && mouseX <= 524+80) {
          
          if (mouseY >= 163 && mouseY<= 163+56) {
             speedDif = 1; 
          }
          if (mouseY >= 243 && mouseY<= 243+56) {
             timeDif = 1;
          }
          if (mouseY >= 323 && mouseY<= 323+56) {
             bulletDif = 1;
          }
          if (mouseY >= 403 && mouseY<= 403+56) {
             upDif = 1;
          }
        }
        
        if (mouseX >= 551+80 && mouseX <= 669+80) {
          
          if (mouseY >= 163 && mouseY<= 163+56) {
             speedDif = 2;
          }
          if (mouseY >= 243 && mouseY<= 243+56) {
             timeDif = 2;
          }
          if (mouseY >= 323 && mouseY<= 323+56) {
             bulletDif = 2;
          }
          if (mouseY >= 403 && mouseY<= 403+56) {
             upDif = 2;
          }
        }
        
        if (mouseX >= 696+80 && mouseX <= 815+80) {
          
          if (mouseY >= 163 && mouseY<= 163+56) {
             speedDif = 3;
          }
          if (mouseY >= 243 && mouseY<= 243+56) {
             timeDif = 3;
          }
          if (mouseY >= 323 && mouseY<= 323+56) {
             bulletDif = 3;
          }
          if (mouseY >= 403 && mouseY<= 403+56) {
             upDif = 3;
          }
        }
        
        if (mouseX >= 595 && mouseX <= 684 && mouseY >= 688 && mouseY<= 724) {
         gameMode = 0; 
        }
        if (mouseX >= 560 && mouseX <= 720 && mouseY >=520 && mouseY <=565) {
          if (speedDif != 0 && timeDif != 0 && bulletDif != 0 && upDif != 0) {
          //speed
          if (speedDif == 1){
            enemy.speed = 0.1;
          }
          if (speedDif == 2){
            enemy.speed = 0.15;
          }
          if (speedDif == 3){
            enemy.speed = 0.2;
          }
          //time
          if (timeDif == 1){
            countdownDuration = 20;
          }
          if (timeDif == 2){
            countdownDuration = 15;
          }
          if (timeDif == 3){
            countdownDuration = 10;
          }
          //bullet
          if (bulletDif == 1){
            bulletCountdown = 10;
          }
          if (bulletDif == 2){
            bulletCountdown = 12;
          }
          if (bulletDif == 3){
            bulletCountdown = 15;
            print("Real deal");
          }
          
          menuMusic.stop();
          delay(200);
          gameStart.play();
          startCountdown(countdownDuration);
          countdownStarted = true;
          println("final values: "+speedDif,timeDif,bulletDif,upDif);
          gameMode = 1;
        }
        }
    }
    
    println(speedDif,timeDif,bulletDif,upDif);
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.10);
    textFont(speakFont);
    text("Select the parameters of the simulation:", 0,0 );
    popMatrix();
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.90);
    rotate(radians(sA));
    textFont(speakFont);
    text("back", 0,0 );
    popMatrix();
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.70);
    rotate(radians(cA));
    textFont(speakFont64);
    text("play", 0,0 );
    popMatrix();
  }
  
  if (gameMode == 6) {
    background(0);
    
    if (sAd == true) {
      sA += 0.3;
    } else {
      sA -= 0.3;
    }
    
    if (sA>=5) {
      sAd = false;
    }
    if (sA<=-5) {
      sAd = true;
    }
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.70);
    textFont(speakFont64);
    text("Score: "+score, 0,0 );
    popMatrix();
    
    pushMatrix();
    fill(155,155,155);
    translate(screenWidth/2,screenHeight*0.90);
    rotate(radians(sA));
    textFont(speakFont);
    text("back", 0,0 );
    popMatrix();
    
    if (mouseX >= 595 && mouseX <= 684 && mouseY >= 688 && mouseY<= 724) {
         gameMode = 0; 
    }
  }
  
  if (gameMode == 1) {   //Playing mode
    
    if(playMusic.isPlaying() == false){
      playMusic.play();
    }
    
    enemyScalingHorizontalFactor = 0.5*screenWidth;
    enemyScalingVerticalFactor = 0.5*screenHeight;
    
    zRotationMatrixSetup(0.2, EmemyRotationMatZ);
    yRotationMatrixSetup(0, EmemyRotationMatY);
    xRotationMatrixSetup(3.3, EmemyRotationMatX);
    
    if (bgMode == true) {
      background(background);
    } else {
      background(0);
    }
    
    if (countdownStarted == true) {
      boolean timeIsUp = isTimeUp();
      remainingTime = getRemainingTime();
      pushMatrix();
      fill(255,255,255);
      textFont(speakFont);
      text(Integer.toString(remainingTime), 30, 30);
      popMatrix();
      if (timeIsUp) {
          gameMode=6;
          countdownStarted = false;
          score = 0;
      }
    }
    
    if (keyPressed) {
      if (key == 'q' || key == 'Q') {
        bxtheta += 0.1;
        xtheta+=0.1;
      }
      if (key == 'e' || key == 'E') {
        bxtheta -= 0.1;
      }
      if (key == 'w' || key == 'W') {
        if (ty>=-8.1) {
          ty -= 0.1;
        }
      }
      if (key == 's' || key == 'S') {
        if (ty<=8.1) {
          ty += 0.1;
        }
      }
      if (key == 'a' || key == 'A') {
        if (tx>=-15.100021) {
          tx -= 0.2;
        }
      }
      if (key == 'd' || key == 'D') {
        if (tx<=15.100021) {
          tx += 0.2;
        }
      }
      /*if (key == 'z' || key == 'Z') {
        tz -= 0.5;
      }
      if (key == 'x' || key == 'X') {
        tz += 1;
      }*/
      if (key == 'h' || key == 'H') {
        arwing.printMesh();
      }
      if (key == 't' || key == 'T') {
        if (rasterizerMode == true) {
          rasterizerMode = false;
        } else {
          rasterizerMode = true;
        }
      }
      if (key == 'b' || key == 'B') {
        if (bgMode == true) {
          bgMode = false;
        } else {
          bgMode = true;
        }
      }
      if (key == 'p' || key == 'P') {
        if (pointMode == true) {
          pointMode = false;
        } else {
          pointMode = true;
        }
      }
      if (key == 'x' || key == 'X') {
        gameMode = 0;
      }
    }
    
    Iterator<bullet> iterator = bullets.iterator();
    while (iterator.hasNext()) {
      bullet bullett = iterator.next();
      if (bullett.z > 50 || bullett.z < -200) {
        iterator.remove();
      }
    }
    
    zRotationMatrixSetup(ztheta, zRotMat);
    xRotationMatrixSetup(xtheta, xRotMat);  
    yRotationMatrixSetup(ytheta, yRotMat);
    
    zRotationMatrixSetup(xtheta, bulletRotationMat);
    
    bulletRotation(bxtheta);
    enemy.moviment();
    
    for (triangle t : arwing.tris) {
     meshProjectionSetup(t, triangles, t.red, t.green, t.blue);
    }
    
    for (triangle t : enemy.mesh.tris) {
     meshEnemyProjectionSetup(t, triangles, t.red, t.green, t.blue, enemy);
    }
  
    if (mousePressed && (mouseButton == LEFT)) {
      if (bulletTimeout == 0) {
        arwing.addSpawnPoint(arwing.getVertexWithMaxZ());
        bullet bullet = createBullet(arwing);
        bullets.add(bullet);
        laser.play();
        bulletTimeout = bulletCountdown;
      } 
      
      if (bulletTimeout != 0) {
        bulletTimeout -= 1;
      }
      for (bullet bullett : bullets) {
        if (bullett.exclude == true) {
            bullets.remove(bullets.indexOf(bullett));
        }
      }
    }
    
    arwing.currentTris = afterStateTriangles;
    arwing.addSpawnPoint(arwing.getVertexWithMaxZ());
    
    for (bullet bullet : bullets) {
      foward(bullet);
      //bullet.translate(bullet.objectOrigin);
      for (triangle t : bullet.mesh.tris) {
        meshBulletProjection(t, triangles, bullet, t.red,t.green,t.blue);
      }
      
      if (enemy.mesh.isCollidingBullet(bullet.mesh, afterStateEnemy, bullet.x,bullet.y,bullet.z)){
        fill(255,0,0);
        score += 1;
        hitting.play();
        } else {
        fill(255,255,255);
        }
    }
  
    sortTrianglesByMedianZ(triangles);
    
    if (pointMode == false) {
      if (rasterizerMode == true) {
        for (triangle t : triangles) {
           rasterizeTriangle(t);
        }
      }
      
      if (rasterizerMode == false) {
        for (triangle t : triangles) {
           drawTriangleOutline(t);
      }
    }
    
    } else {
        for (triangle t : triangles) {
           drawTriangleVertices(t);
        }
    }
    
    pushMatrix();
    translate(10,screenHeight-50);
    image(loadImage("C:/Users/bruno/Desktop/3d-game-engine-from-scratch-main/game_engine_3d/sprites/bar.png"),0,0);
    popMatrix();
    
    pushMatrix();
    textFont(speakFont);
    fill(255,255,255);
    translate(40,screenHeight-5);
    text(Integer.toString(score), 0,0);
    popMatrix();
    
    afterStateTriangles = new ArrayList<>();
    
    afterStateEnemy = new ArrayList<>();
    
    triangles = new ArrayList<>();
  }
}
