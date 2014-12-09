
class Platform extends Level
{
  FBox me;
  int dir;
  float x;
  float y;
  int steps;
  float rot;
  PImage img;
  float speed;
  boolean isMoving;
  
  int currentSteps;
  
  Platform(FWorld world, int dir, float x, float y, float w, float h, float rot, float speed, float restitution, boolean isMoving, int steps)
  {
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.rot = rot;
    this.steps = steps;
    this.speed = speed;
    this.isMoving = isMoving;
    this.currentSteps = 0;
    
    img = loadImage("wood.png");
    
    me = new FBox(w, h);
    me.setStatic(true);
    me.setFillColor(color(random(255), random(255), random(255)));
    me.setRestitution(restitution);
    me.setPosition(x, y);
    me.setRotation(rot);
    me.setDensity(50);
    world.add(me);
  }
  
  void setMoving(boolean isMoving)
  {
    this.isMoving = isMoving;
//    if (dir == 2)
//      me.setRestition(speed);
  }
  
  void setSteps(int steps)
  {
    this.steps = steps;
  }
  
  void updateMovement()
  {
    if (!isMoving)
      return;
      
    switch(dir) {
      case PLATFORM_DIR_RIGHT:
        this.x += speed;
        break;
      case PLATFORM_DIR_LEFT:
        this.x -= speed;
        break;
      case PLATFORM_DIR_UP:
        this.y -= speed;
        break;
      case PLATFORM_DIR_DOWN:
        this.y += speed;
        break;
    }
    currentSteps++;
    if (currentSteps >= steps) {
      currentSteps = 0;
      switch(dir) {
        case PLATFORM_DIR_RIGHT:
          dir = PLATFORM_DIR_LEFT;
          break;
        case PLATFORM_DIR_LEFT:
          dir = PLATFORM_DIR_RIGHT;
          break;
        case PLATFORM_DIR_UP:
          dir = PLATFORM_DIR_DOWN;
          break;
        case PLATFORM_DIR_DOWN:
          dir = PLATFORM_DIR_UP;
          break;
      }
    }
    me.setPosition(this.x, this.y);
    
  }
  
  FBox getBody()
  {
    return me;
  }
}
