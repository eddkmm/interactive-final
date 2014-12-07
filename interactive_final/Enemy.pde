
class Enemy extends Level
{
  FBox me;
  float x;
  float y;
  float speed;
  
  Enemy(Platform home, float w, float h, float speed) throws IllegalArgumentException
  {
    super();
    if (!platforms.contains(home) || !platformsMoving.contains(home))
      throw new IllegalArgumentException("Level platform does not exist");
      
    x = home.me.getX();
    y = home.me.getY() - home.me.getHeight();
    
    me = new FBox(w, h);
    me.setStatic(true);
    world.add(me);
  }
}
