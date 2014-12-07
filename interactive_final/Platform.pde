
class Platform extends Level
{
  FBox me;
  int dir;
  float x;
  float y;
  int steps;
  float rot;
  float speed;
  boolean isMoving;
  
  int currentSteps;
  
  Platform(int dir, float x, float y, float w, float h, float rot, float speed, float restitution)
  {
    this.dir = dir;
    this.rot = rot;
    this.steps = 0;
    this.speed = speed;
    this.isMoving = false;
    this.currentSteps = 0;
    
    me = new FBox(w, h);
    me.setStatic(true);
    me.setRestitution(restitution);
    me.setPosition(x, y);
    me.setRotation(rot);
    world.add(me);
  }
  
  void setMoving(boolean isMoving)
  {
    this.isMoving = isMoving;
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
      case 0:
        x += speed;
        break;
      case 1:
        x -= speed;
        break;
      case 2:
        y -= speed;
        break;
      case 3:
        y += speed;
        break;
    }
    currentSteps++;
    if (currentSteps >= steps) {
      currentSteps = 0;
      switch(dir) {
        case 0:
          dir = 1;
          break;
        case 1:
          dir = 0;
          break;
        case 2:
          dir = 3;
          break;
        case 3:
          dir = 2;
          break;
      }
    }
    me.setPosition(x, y);
    
  }
  
  FBox getBody()
  {
    return me;
  }
}
