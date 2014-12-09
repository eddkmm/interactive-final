
// Level Object
// Contains platform and enemy objects
class Level
{
//  FWorld world;
  float speed;
//  float scrollX;
  float restitution;
  boolean isScrolling;
  boolean isRedemption;
  
  Goal goal;
  Helper helper;
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  ArrayList<Platform> platforms = new ArrayList<Platform>();
  ArrayList<Platform> platformsMoving = new ArrayList<Platform>();
  
  Level()
  {
    
    this.speed = 2;
//    this.scrollX = 0;
    this.restitution = 0;
    this.isScrolling = true;
    this.isRedemption = false;
  }
  
  void initHelper(FWorld world, float w, float h)
  {
    helper = new Helper(world, w, h);
  }
  
  void display(FWorld world, Main m)
  {
    if (globalState == 2 && !isRedemption)
      return;
      
    if (isScrolling) {
      pushMatrix();
      translate(-scrollX, 0);
      for (Platform p : platformsMoving)
        p.updateMovement();
      world.step();
      world.draw();
      popMatrix();
    } else {
      for (Platform p : platformsMoving)
        p.updateMovement();
      world.step();
      world.draw();
    }
    
//    world.setEdges(scrollX, 0, scrollX + width, height);
//    world.setEdges(-width + scrollX, -height, width * 100, height);
    
    m.display();
    drawHelper();
    
    if (isScrolling) {
      scrollX += speed;
      if (mischief[currentLevel].main.getX() > scrollX + width - 100) {
        mischief[currentLevel].main.setVelocity(0, 0);
        //mischief[currentLevel].main.addForce(mischief[currentLevel].main.getX() - 10, mischief[currentLevel].main.getY());
      }
      if (mischief[currentLevel].main.getX() < scrollX + 100) {
        mischief[currentLevel].main.adjustVelocity(10, 0);
        //mischief[currentLevel].main.addForce(mischief[currentLevel].main.getX() - 10, mischief[currentLevel].main.getY());
      }
    }
    
    if (overconfident) {
      if (lastOverconfidence + 3000 < millis()) {
        overconfident = false;
        helper.me.setSensor(false);
        helper.me.setFill(255);
      }
    }
    
    if (currentConfidence >= maxConfidence && !overconfident) {
      overconfident = true;
      lastOverconfidence = millis();
      helper.me.setSensor(true);
      helper.me.setFill(0, 100);
    }
      
    if (fellOffMap() && !isRedemption) {
      //println("YOU DED");
      lastScrollX = scrollX;
      scrollX = 0;
      lastRedemptionEnter = millis();
      globalState = 2;
      return;
    }
      
    if (isTouchingGoal() && !isRedemption)
      onEndLevel();
  }
  
  boolean drawHelper()
  {
    boolean detected = false;   
    try {
      augmentedRealityMarkers.detect(video);
      if (augmentedRealityMarkers.isExistMarker(0)) {
        detected = true;
        PVector[] mv = augmentedRealityMarkers.getMarkerVertex2D(0);
        // Set the AR perspective
        augmentedRealityMarkers.setARPerspective();
        
        // Transformation
        pushMatrix();
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(0));
        // flip the coordinate system around so that we can draw in a more intuitive way (if you don't do this
        // then the x axis will be flipped)
        scale(-1.0, 1.0);
        // we are now at 0,0,0 in the dead center of the marker
        // if we draw anything here it will be rotated and scaled accordingly
        // note that the marker is 80 x 80
        
        float half = float(width / 2);
        float rot = radians(180) - calculateAngle(mv[0].x, mv[0].y, mv[1].x, mv[1].y);
        
        if (!helper.limitRot)
          helper.me.setRotation(rot);
        else {
          float deg = degrees(rot);
          //println("deg: " + deg);
          if (deg > 135 && deg < 225)
            helper.lastR = rot;
            
          helper.me.setRotation(helper.lastR);
        }
        
        if (mv[0].x > half)
          mv[0].x -= (mv[0].x - half) * 2;
        else
          mv[0].x += (half - mv[0].x) * 2;
          
        helper.lastX = mv[0].x;
        helper.lastY = mv[0].y;
        
        helper.me.setPosition(mv[0].x + ((isScrolling) ? scrollX : 0), mv[0].y);
        if (!helper.limitRot)
          helper.me.adjustPosition(-helper.me.getWidth(), helper.me.getHeight() + 50);
        else
          helper.me.adjustPosition(-50, 100);
        //println("X: " + mv[0].x + " | Y: " + mv[0].y + " " + millis());
        //helper.setRotation(calculateAngle(mv[0].x, mv[0].y, mv[1].x, mv[1].y));
  
        // draw live video here
        //imageMode(CENTER);
        //image(video, 0, 0, 80, 80);
        
        // Clean Up
        perspective();
        popMatrix();
      }
    } catch (Exception e) {
      println("Issue with AR detection ... resuming regular operation ..");
      //return false;
    }
    if (!detected && isScrolling)
      helper.me.adjustPosition(speed, 0);
    return true;
  }
  
  boolean fellOffMap()
  {
    return (mischief[currentLevel].main.getY() >= height
    || mischief[currentLevel].main.getX() > scrollX + width
    || mischief[currentLevel].main.getX() < scrollX) ? true : false;
  }
  
  boolean isTouchingGoal()
  {
    return (mischief[currentLevel].main.getX() >= goal.x) ? true : false;
  }
  
  void setRestitution(float restitution)
  {
    this.restitution = restitution;
  }
  
  Goal addGoal(FWorld world, float x, float y)
  {
    goal = new Goal(world, x, y);
    return goal;
  }
  
  Platform addStaticPlatform(FWorld world, float x, float y, float w, float h, float rot)
  {
    Platform p = new Platform(world, 0, x, y, w, h, rot, 0, restitution, false, 0);
    platforms.add(p);
    return p;
  }
  
  Platform addMovingPlatform(FWorld world, int dir, float x, float y, float w, float h, float rot, float speed, int steps)
  {
    Platform p = new Platform(world, dir, x, y, w, h, rot, speed, restitution, true, steps);
    //p.me.setBullet(true);
    p.setMoving(true);
    platformsMoving.add(p);
    return p;
  }
  
  boolean addEnemy(FWorld world, Platform home, float w, float h, float speed)
  {   
    Enemy e = new Enemy(world, home, w, h, speed);
    
    if (e == null)
      return false;
    else {
      enemies.add(e);
      return true;
    }
  }
  
  boolean removeEnemy(Enemy e)
  {
    return enemies.remove(e);
  }
  
  void clearAll()
  {
    enemies.clear();
    platforms.clear();
    platformsMoving.clear();
  }
}
