
class Helper extends Level
{
  FBox me;
  float lastX;
  float lastY;
  float lastR;
  boolean limitRot;
  
  Helper(FWorld world, float w, float h)
  {
    me = new FBox(w, h);
    me.setStatic(true);
    me.setFillColor(color(255, 255, 255));//color(random(255), random(255), random(255)));
    me.setPosition(width / 2, height / 2);
    world.add(me);
    limitRot = false;
  }
}
