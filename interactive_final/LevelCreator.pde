// LEVEL CREATOR METHOD
// NOT A CLASS

boolean levelCreator(int levelID)
{
  switch(levelID) {
    case 0:
      thisLevel = new Level();
      thisLevel.initHelper(50, 50);
      
      Platform p;
      float lastX = 50;
      
      p = thisLevel.addStaticPlatform(lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = thisLevel.addStaticPlatform(lastX, (height / 2) + 100, 600, 30, 0);
      lastX += p.me.getWidth() + 300;
      p = thisLevel.addStaticPlatform(lastX, (height / 2) + 100, 600, 30, 0);
      lastX += p.me.getWidth() + 400;
      p = thisLevel.addStaticPlatform(lastX, (height / 2), 600, 30, 0);
      lastX += p.me.getWidth() + 300;
      p = thisLevel.addStaticPlatform(lastX, (height / 2), 600, 30, 0);
      lastX += p.me.getWidth() + 300;
      p = thisLevel.addStaticPlatform(lastX, (height / 2) - 100, 500, 30, 0);
      lastX += p.me.getWidth() + 300;
      p = thisLevel.addStaticPlatform(lastX, (height / 2) - 100, 500, 30, 0);
      lastX += p.me.getWidth() + 300;
      p = thisLevel.addStaticPlatform(lastX, (height / 2) + 150, 500, 30, 0);
      lastX += p.me.getWidth() + 300;
      p = thisLevel.addStaticPlatform(lastX, (height / 2), 300, 30, radians(135));
      lastX += p.me.getWidth() + 200;
      p = thisLevel.addStaticPlatform(lastX, (height / 2), 300, 30, radians(45));
      
      
      break;
  }
  return true;
}
