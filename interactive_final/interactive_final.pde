import fisica.*;
//import gifAnimation.*;
//import java.awt.Button;
import processing.video.*;
// Augmented reality library
import jp.nyatla.nyar4psg.*;

// The Fisica "world" - this is the object that will
// hold all of our simulated bodies and perform collision
// detection on our behalf
FWorld[] world = new FWorld[5];
FWorld redemptionWorld;
FBox[] thePlatforms = new FBox[100];
//FBox helper;
int platformSpeed = 1;
FBox catbug;

PImage ctbg;

Main[] mischief = new Main[5];
Main redemptionMain;

// character's last Y position
float last;

PImage brick;

Button buttonBegin;

// AR marker object
MultiMarker augmentedRealityMarkers;

Capture video;

float rxPos;
float ryPos;
float byPos;
color wantedColor;
float screenColor;
float speed = 1.5;


int state = 1;
boolean began = false;

int failedDisplay = 0;

PImage[] ynp;
int ynpI;
long ynpLast;
boolean ynpReverse;

Level[] level = new Level[5];
Level redemptionLevel;
float scrollX;
float lastScrollX;

int globalState;
int currentLevel;

final int PLATFORM_DIR_RIGHT = 0;
final int PLATFORM_DIR_LEFT = 1;
final int PLATFORM_DIR_UP = 2;
final int PLATFORM_DIR_DOWN = 3;

int currentConfidence = 0;
int maxConfidence = 200;

boolean overconfident = false;
long lastOverconfidence;

PImage house;
PImage c_press;
PImage c_unpress;
PImage title;

long lastRedemptionEnter = 0;

void setup()
{
  size(640, 480, OPENGL);
  smooth();
  
  house = loadImage("house.png");
  c_press = loadImage("c_press.png");
  c_unpress = loadImage("c_unpress.png");
  title = loadImage("title.png");
  
  video = new Capture(this, width, height);
  video.start();
  
  // init the world with a reference to our canvas
  Fisica.init(this);
  
  for (int i = 0; i < 5; i++) {
    world[i] = new FWorld(-width, -height, width * 100, height);
    world[i].setEdges(-width, -height, width * 100, height * 2);
    //world.setEdges();
    world[i].setGrabbable(false);
    world[i].setGravity(0, 512);
    levelCreator(i);
  }
  redemptionWorld = new FWorld(-width, -height, width * 2, height * 2);
  redemptionWorld.setEdges(-width, -height, width, height * 2);
  redemptionWorld.setGrabbable(false);
  redemptionWorld.setGravity(0, 256);
  createRedemptionLevel();
  scrollX = 0;
  
  //moving platform array
  int offset = 0;
  
  //mischief = new Main(width / 2, 0);
  
  brick = loadImage("brick.png");
  
  rxPos = 320;
  ryPos = 740;
  byPos = 155;
  
  wantedColor = color(195, 255, 106);
  
  // Buttons
  buttonBegin = new Button(width - 100, 25, 75, 50, #FFFF00, #FFA200, 0, "GO!", 24);

  augmentedRealityMarkers = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  augmentedRealityMarkers.addARMarker("patt.hiro", 80);
  
  //ynp = Gif.getPImages(this, "ynp.gif");
  ynp = new PImage[112];
  for (int i = 0; i < 112; i++)
    ynp[i] = loadImage("ynp/ynp-" + i + ".gif");
  ynpI = 0;
  ynpLast = 0;
  ynpReverse = false;
  
  globalState = 0;
  currentLevel = 0;
}

void mousePressed()
{
  if (buttonBegin.isMouseOver()) {
    buttonBegin.isPressed = true;
    // event begin level
    return;
  }
  // tell the tracker to grab the pixel that the user clicked on and store it
  //theTracker.trackColor(mouseX, mouseY);
  
  reset(currentLevel);
}

void mouseReleased()
{
  if (buttonBegin.isMouseOver()) {
      
    if (began) {
      // pause
      began = false;
      buttonBegin.setText("Unpause");
    } else {
      // unpause
      began = true;
      buttonBegin.setText("Pause");
    }
      
    buttonBegin.isPressed = false;
  }
}


void reset(int level)
{
  state = 1;
  
  mischief[level].reset();
  
  rxPos = 320;
  ryPos = 740;
  
  byPos = 155;
}

void draw()
{ 
  switch(globalState) {
    case 0:
      // TITLE SCREEN
      drawTitleScreen();
      break;
    case 1:
      // LEVEL
      drawLevel();
      break;
    case 2:
      // REDEMPTION LEVEL
      drawRedemptionLevel();
      break;
    case 3:
      // GAME OVER
      break;
  }
  
  //buttonBegin.display();

  if (keyPressed) {
    if (key == ' ') {
      reset(currentLevel);
    }
  }
  
}

void drawTitleScreen()
{
  image(house, 0, 0, 640, 480);
  image(title, 175, 25, 350, 173);
  textSize(20);
  
  image(c_press, 100, 350, 75, 75);
  fill(255,0,0);
  text("Click Courage to Play", 20, 325);
}

void mouseClicked()
{
  if (globalState == 0) {
    if (mouseX >= 100 && mouseX <= 175 && mouseY >= 350 && mouseY <= 425) {
      globalState = 1;
    }
  }
}

// Displays "You're Not Perfect" gif
void drawYNP()
{
  imageMode(CENTER);
  image(ynp[ynpI], width / 2, height / 2 + 50, width * 1.5, height * 1.5);
  
  if (ynpLast + 100 < millis()) {
    ynpLast = millis();
    ynpI += (ynpReverse) ? -1 : 1;
    if (ynpI >= ynp.length || ynpI < 0) {
      // Reverse frame direction
      ynpReverse = (ynpReverse) ? false : true;
      ynpI += (ynpReverse) ? -2 : 2;
    }
  }
}

void drawRedemptionLevel()
{
  if (redemptionMain.main.getY() > height) {
    // GAME OVER SON
    currentLevel = 0;
    scrollX = 0;
    globalState = 0;
    
    mischief[currentLevel].main.setPosition(width / 2 + scrollX, 0);
    mischief[currentLevel].main.setVelocity(0, 0);
    level[currentLevel].helper.me.setPosition(width / 2 + scrollX, height / 2);
    
    // Reset overconfidence meter
    currentConfidence = 0;
    overconfident = false;
    level[currentLevel].helper.me.setSensor(false);
    level[currentLevel].helper.me.setFill(255);
    
    redemptionMain.main.setPosition(width / 2, 0);
    redemptionMain.main.setRotation(0);
    redemptionMain.main.setVelocity(0, 0);
    return;
  }
  println("REDEMPTION - " + millis() + " | LAST ENTER - " + lastRedemptionEnter);
  if (lastRedemptionEnter + 10000 < millis()) {
    // REDEEMED
    scrollX = lastScrollX;
    mischief[currentLevel].main.setPosition(width / 2 + scrollX, 0);
    mischief[currentLevel].main.setVelocity(0, 0);
    level[currentLevel].helper.me.setPosition(width / 2 + scrollX, height / 2);
    globalState = 1;
    
    // Reset overconfidence meter
    currentConfidence = 0;
    overconfident = false;
    level[currentLevel].helper.me.setSensor(false);
    level[currentLevel].helper.me.setFill(255);
    
    redemptionMain.main.setPosition(width / 2, 0);
    redemptionMain.main.setRotation(0);
    redemptionMain.main.setVelocity(0, 0);
    println("REDEEMED!");
    return;    
  }
  background(0);
  drawYNP();
  if (!drawVideo()) {
    failedDisplay++;
    if (failedDisplay > 60) {
      // Pause the game and inform the user their video isn't displaying
      fill(0, 100);
      rectMode(CORNER);
      rect(0, 0, width, height);
      fill(255);
      textAlign(CENTER);
      textSize(12);
      text("Video is not displaying properly. The game will resume once your video displays again.", width / 2, height / 2);
      return;
    }
  }
  //background(255);
  failedDisplay = 0;
  
  redemptionLevel.display(redemptionWorld, redemptionMain);
  mischief[currentLevel].main.adjustPosition(level[currentLevel].speed, 0);
}

void drawLevel()
{
  background(255);
  //drawYNP();
  if (!drawVideo()) {
    failedDisplay++;
    if (failedDisplay > 60) {
      // Pause the game and inform the user their video isn't displaying
      fill(0, 100);
      rectMode(CORNER);
      rect(0, 0, width, height);
      fill(255);
      textAlign(CENTER);
      textSize(12);
      text("Video is not displaying properly. The game will resume once your video displays again.", width / 2, height / 2);
      return;
    }
  }
  //background(255);
  failedDisplay = 0;
  
  level[currentLevel].display(world[currentLevel], mischief[currentLevel]);
  mischief[currentLevel].main.adjustVelocity(level[currentLevel].speed, 0);
  drawGUI();
  //mischief[currentLevel].main.adjustPosition(level[currentLevel].speed, 0);
}

// Returns true if the video and AR fiducial marker are displaying properly, else false
// Also adds the updated fiducial marker FPoly object to the world
boolean drawVideo()
{
  boolean rtn = false;
  
  if (!video.available())
    rtn = true;
    
  video.read();
  
  // Flip the video output
  imageMode(CORNER);
  pushMatrix();
  scale(-1.0, 1.0);
  tint(255, 20);
  image(video, -width, 0);
  noTint();
  popMatrix();
  
  if (rtn)
    return false;
    
  return true;
}

void onEndLevel()
{
  println("YOU WIN");
  scrollX = 0;
  if (currentLevel < 5)
    currentLevel++;
  else {
    // GAME OVER STUFF
  }
}

// Calculates the angle from one 2d point to another
static float calculateAngle(float x1, float y1, float x2, float y2)
{
  float deltaX = x2 - x1;
  float deltaY = y2 - y1;

  return atan2(deltaY, deltaX);
}

float getMatrixRotation()
{
  float[] cmat = new float[6];
  PMatrix pm = getMatrix();
  pm.get(cmat);
  return atan2(cmat[3], cmat[0]);
}
