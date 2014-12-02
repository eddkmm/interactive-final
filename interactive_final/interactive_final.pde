import fisica.*;
import java.awt.Button;
import processing.video.*;
// Augmented reality library
import jp.nyatla.nyar4psg.*;

// The Fisica "world" - this is the object that will
// hold all of our simulated bodies and perform collision
// detection on our behalf
FWorld world;
FBox[] thePlatforms = new FBox[100];
FBox helper;
int platformSpeed = 1;
FBox catbug;

PImage ctbg;

Catbug mischief;

// character's last Y position
float last;

PImage brick;

Button buttonBegin;

// this object does it all for us!
//MultipleColorTracker theTracker;

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

void setup()
{
  size(640, 480, OPENGL);
  smooth();
  
  video = new Capture(this, width, height);
  video.start();
  
  // init the world with a reference to our canvas
  Fisica.init(this);

  // set up the world
  world = new FWorld();
  
  // this sets the edge of the canvas as the edge of the world
  // if you didn't set this then the objects you create wouldn't be bound
  // by the size of your canvas and would move out beyond the edges
  world.setEdges();
  world.setGrabbable(false);
  
  world.setGravity(0, 300);
  
  //moving platform array
  int offset = 0;
  
  // The AR object that will help the character
  helper = new FBox(10, 300);
  helper.setStatic(true);
  helper.setFillColor(color(random(255), random(255), random(255)));
  helper.setPosition(width / 2, height / 2);
  world.add(helper);
  
  mischief = new Catbug(width / 2, 0);
  
  brick = loadImage("brick.png");
  
  rxPos = 320;
  ryPos = 740;
  byPos = 155;
  
  wantedColor = color(195, 255, 106);
  
  // Buttons
  buttonBegin = new Button(width - 100, 25, 75, 50, #FFFF00, #FFA200, 0, "GO!", 24);
  
   // set up our color tracker to track 3 colors
//  theTracker = new MultipleColorTracker(this, width, height, 1, 50);
//  theTracker.video.start();

  augmentedRealityMarkers = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  augmentedRealityMarkers.addARMarker("patt.hiro", 80);
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
  
  reset();
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


void reset()
{
  state = 1;
  
  mischief.reset();
  
  rxPos = 320;
  ryPos = 740;
  
  byPos = 155;
}

void draw()
{ 
//  if (state == 1) {
//    drawLevel();
//  }
  drawLevel();
  
  buttonBegin.display();

  if (keyPressed) {
    if (key == ' ') {
      reset();
    }
  }
  
}

void drawLevel()
{
  background(255);
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
  
  // important!  we have to tell the physics library to
  // compute what happens next in its simulation
  world.step();
  // now have it draw itself to the screen
  world.draw();
}

//@ Override void

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
  image(video, -width, 0);
  popMatrix();
  
  if (rtn)
    return false;
    
  try {
    augmentedRealityMarkers.detect(video);
    
    if (augmentedRealityMarkers.isExistMarker(0)) {
      
      PVector[] mv = augmentedRealityMarkers.getMarkerVertex2D(0);
      // Set the AR perspective
      augmentedRealityMarkers.setARPerspective();
      
      // Transformation
      pushMatrix();
      setMatrix(augmentedRealityMarkers.getMarkerMatrix(0));
      // flip the coordinate system around so that we can draw in a more intuitive way (if you don't do this
      // then the x axis will be flipped)
      scale(-1.0, 1.0);
      // we are now at 0,0,0 in the dead center of the marker
      // if we draw anything here it will be rotated and scaled accordingly
      // note that the marker is 80 x 80
      
      // get the width and height of the box by finding the difference of the the x and y vectors
      //helper.setWidth(80);//(abs(mv[0].x - mv[1].x) + abs(mv[2].x - mv[3].x)) / 2);
      //helper.setHeight(80);//(abs(mv[0].y - mv[1].y) + abs(mv[2].y - mv[3].y)) / 2);
      
//      float[] markerMatrix = new float[12];
//      PMatrix blah = getMatrix();
//      blah.get(markerMatrix);
//      println(markerMatrix);

//      mv[0].x += 80;
//      mv[0].y += 80;
      float half = float(width / 2);
      
//      if (mv[0].x > half)
//        mv[0].x -= (mv[0].x - half) * 2;
//      else
//        mv[0].x += (half - mv[0].x) * 2;
//      
//      helper.setPosition(mv[0].x, mv[0].y);
      //helper.setRotation(radians(

      // draw live video here
      //imageMode(CENTER);
      //image(video, 0, 0, 80, 80);
      
      // Clean Up
      perspective();
      popMatrix();
    }
  } catch (Exception e) {
    println("Issue with AR detection ... resuming regular operation ..");
    //return false;
  }
  return true;
}

float getMatrixRotation()
{
  float[] cmat = new float[6];
  PMatrix pm = getMatrix();
  pm.get(cmat);
  return atan2(cmat[3], cmat[0]);
}
