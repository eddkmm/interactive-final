class Catbug
{
  float xPos;
  float yPos;
  int ySize;
  int xSize;
  float speed;
  PImage catbug;
  float d;
  
  Catbug(float x, float y)
  {
    xPos = x;
    yPos = y;
    xSize = 75;
    ySize = 87;
    speed = 2;
  }
  
  void reset()
  {
    xPos = 50;
    yPos = 0;
  }
  
  void move() 
  {
    xPos+=1;
  }
  
  boolean checkDistance(float platX, float platY) {
   d = dist(xPos,yPos,platX,platY);
   if (d < 100) {
     return true;
   }
   else {
     return false;
   }
  }
}

