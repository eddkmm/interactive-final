// LEVEL CREATOR METHOD
// NOT A CLASS

void createRedemptionLevel()
{
  redemptionMain = new Main(redemptionWorld, width / 2, 0);
  redemptionMain.main.setRotatable(true);
  redemptionLevel = new Level();
  redemptionLevel.isScrolling = false;
  redemptionLevel.initHelper(redemptionWorld, 5, height);
  redemptionLevel.isRedemption = true;
  redemptionLevel.helper.limitRot = true;
  
  // Useless, unused goal
  redemptionLevel.addGoal(redemptionWorld, width + 50, height / 2);
}

void contactStarted(FContact contact) {
  if (contact.contains(level[currentLevel].helper.me, mischief[currentLevel].main)) {
    if (currentConfidence < maxConfidence && !overconfident)
      currentConfidence++;
  } else {
    if (currentConfidence > 0)
      currentConfidence--;
  }
}

void contactPersisted(FContact contact) {
  if (contact.contains(level[currentLevel].helper.me, mischief[currentLevel].main)) {
    if (currentConfidence < maxConfidence && !overconfident)
      currentConfidence++;
  } else {
    if (currentConfidence > 0)
      currentConfidence--;
  }
}

// void contactPersisted(FContact contact) {
// // Draw in blue an ellipse where the contact took place
// fill(0, 0, 170);
// ellipse(contact.getX(), contact.getY(), 10, 10);
// }
// 
// void contactEnded(FContact contact) {
// // Draw in blue an ellipse where the contact took place
// fill(0, 0, 170);
// ellipse(contact.getX(), contact.getY(), 10, 10);
// }

boolean levelCreator(int levelID)
{
  Platform p;
  float lastX = 0;
  
  switch(levelID) {
    case 0:
      mischief[0] = new Main(world[0], width / 2, 0);
      level[0] = new Level();
      level[0].initHelper(world[0], 75, 25);
      
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
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2), 300, 30, radians(40/*140*/));
      lastX += p.me.getWidth() + 250;
      p = level[0].addStaticPlatform(world[0], lastX, (height / 2), 300, 30, radians(40));
      lastX += p.me.getWidth() + 100;
      level[0].addGoal(world[0], lastX, height / 2);
      
      break;
    case 1:
      mischief[1] = new Main(world[1], width / 2, 0);
      level[1] = new Level();
      level[1].restitution = 0.5;
      level[1].initHelper(world[1], 75, 25);

      p = level[1].addStaticPlatform(world[1], lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[1].addStaticPlatform(world[1], lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[1].addStaticPlatform(world[1], lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_UP, lastX, (height / 2) + 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_UP, lastX, (height / 2) + 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_UP, lastX, (height / 2) + 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 250, 30, radians(40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 250, 30, radians(40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_UP, lastX, (height / 2) - 75, 250, 30, radians(40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 250, 30, radians(40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_UP, lastX, (height / 2) - 75, 250, 30, radians(140), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[1].addMovingPlatform(world[1], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 250, 30, radians(140), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      level[1].addGoal(world[0], lastX, height / 2);
      break;
    case 2:
      mischief[2] = new Main(world[2], width / 2, 0);
      level[2] = new Level();
      level[2].restitution = 0.5;
      level[2].initHelper(world[2], 75, 25);

      p = level[2].addStaticPlatform(world[2], lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[2].addStaticPlatform(world[2], lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      p = level[2].addStaticPlatform(world[2], lastX, (height / 2), 500, 30, 0);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_UP, lastX, (height / 2) + 75, 500, 30, 0, 2, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 500, 30, 0, 2, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_UP, lastX, (height / 2) + 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 250, 30, radians(40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_UP, lastX, (height / 2) + 75, 500, 30, 0, 2, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 250, 30, radians(-40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_UP, lastX, (height / 2) + 75, 250, 30, radians(40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 500, 30, 0, 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_UP, lastX, (height / 2) + 75, 250, 30, radians(-40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_DOWN, lastX, (height / 2) - 75, 250, 30, radians(40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      p = level[2].addMovingPlatform(world[2], PLATFORM_DIR_UP, lastX, (height / 2) + 75, 250, 30, radians(40), 1.5, 150);
      lastX += p.me.getWidth() + 250;
      
      level[2].addGoal(world[0], lastX, height / 2);
      break;
    case 3:
      break;
    case 4:
      break;
  }
  return true;
}
