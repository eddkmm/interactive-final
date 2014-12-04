import fisica.*;

// The Fisica "world" - this is the object that will
// hold all of our simulated bodies and perform collision
// detection on our behalf
FWorld world;
FBox[] thePlatforms = new FBox[50];
int platformSpeed = 1;
int offset;

//Level Handler - remembers what level the player is on. Increases by increments of 1.
int levelCount = 1;

//perlin noise variables
float perlinX; float perlinR;

FBox catbug;

PImage ctbg;

Catbug mischief;

//character's last Y position
float last;

void setup() 
{
  size(640, 480);
  smooth();
  
  mischief = new Catbug(110, 0);
  
  //load character image
  ctbg = loadImage("catbug.png");

  // init the world with a reference to our canvas
  Fisica.init(this);

  // set up the world
  world = new FWorld(-width, -height, 10*width, 2*height);
  
  // this sets the edge of the canvas as the edge of the world
  // if you didn't set this then the objects you create wouldn't be bound
  // by the size of your canvas and would move out beyond the edges
  world.setEdges();
  world.setGrabbable(false);
  
  world.setGravity(0, 150);
  
  //moving platform array
  offset = 0;
  
  for (int i = 0; i < thePlatforms.length; i++)
  {
    thePlatforms[i] = new FBox(150, 30);
    thePlatforms[i].setStatic(true);
    thePlatforms[i].setFillColor(   color(random(255), random(255), random(255) )   );
    thePlatforms[i].setPosition(offset, height/2);
    offset += 200; //distance between platforms
    world.add(thePlatforms[i]);
  }
  
  //catbug
  catbug = new FBox(75,87);
  catbug.setStatic(false);
  catbug.setPosition(mischief.xPos,mischief.yPos);
  catbug.attachImage(ctbg);
  world.add(catbug);
  
  //perlin noise handler
  perlinX = noise(10);
  perlinR = map(perlinX, 0, 1, -5, 5);
  
}

void draw() 
{
  // erase the bg
  background(255);

  //move the platforms
  for (int i = 0; i < thePlatforms.length; i++)
  {
    // tell each platform to move to the left
    thePlatforms[i].setPosition( thePlatforms[i].getX() - platformSpeed, thePlatforms[i].getY());
    
    if (levelCount > 1) 
    {
      //randomly rotates platforms

      for (int j = 0; j < thePlatforms.length; j++)
      {
        if ((j % 2) == 0){
        thePlatforms[j].setRotation(thePlatforms[j].getRotation() + radians(perlinR));
        }
      }
    }
    
    //check level clear    
    float clear  = dist(catbug.getX(), catbug.getY(), thePlatforms[5].getX(),thePlatforms[5].getY());
    println(clear);
    if (clear < 100) {
      fill(0);
      text("Level Cleared!", 20,20);
      resetLevel();
      catbug.setPosition(mischief.xPos,mischief.yPos);
      levelCount += 1;
    }
  }
  // important!  we have to tell the physics library to
  // compute what happens next in its simulation
  world.step();
  
  // now have it draw itself to the screen
  world.draw();
  
  


}

void resetLevel()
{
   offset = 0;
  
  for (int i = 0; i < thePlatforms.length; i++)
  {
    thePlatforms[i].setPosition(offset, height/2);
    offset += 200;
  } 
}




