
class Goal extends Level
{
  FBox me;
  float x;
  float y;
  float speed;
  
  Goal(FWorld world, float x, float y) throws IllegalArgumentException
  {
//    if (!platforms.contains(home) || !platformsMoving.contains(home))
//      throw new IllegalArgumentException("Level platform does not exist");
      
    this.x = x;
    this.y = y;
    
    me = new FBox(10, height);
    me.setPosition(x, y);
    me.setStatic(true);
    me.setSensor(true);
    world.add(me);
  }
}
