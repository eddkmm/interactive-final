// LEVEL CREATOR METHOD
// NOT A CLASS

void createRedemptionLevel()
{
  redemptionMain = new Main(redemptionWorld, width / 2, 0);
  redemptionMain.main.setRotatable(true);
  redemptionLevel = new Level();
  redemptionLevel.isScrolling = false;
  redemptionLevel.initHelper(redemptionWorld, 5, 50);
  
  // Useless, unused goal
  redemptionLevel.addGoal(redemptionWorld, width + 50, height / 2);
}

boolean levelCreator(int levelID)
{
  switch(levelID) {
    case 0:
      mischief[0] = new Main(world[0], width / 2, 0);
      level[0] = new Level();
      level[0].initHelper(world[0], 75, 25);
      
      Platform p;
      float lastX = 0;
      
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2) + 100, 600, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2) + 100, 600, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2), 600, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2), 600, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2) - 75, 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2) - 75, 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2) + 150, 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2), 300, 30, radians(140));
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2), 300, 30, radians(40));
      lastX += p.me.getWidth() + 100;
      level[0].addGoal(world[0], lastX, height / 2);
      
      
      break;
  }
  return true;
}
