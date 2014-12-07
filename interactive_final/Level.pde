
// Level Object
// Contains platform and enemy objects
class Level
{
//  FWorld world;
  float speed;
//  float scrollX;
  float restitution;
  boolean isScrolling;
  
  Helper helper;
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  ArrayList<Platform> platforms = new ArrayList<Platform>();
  ArrayList<Platform> platformsMoving = new ArrayList<Platform>();
  
  Level()
  {
//    world = new FWorld(-width, -height, width * 10, height * 2);
//    world.setEdges();
//    world.setGrabbable(false);
//    world.setGravity(0, 512);
    
    this.speed = 2;
//    this.scrollX = 0;
    this.restitution = 0;
    this.isScrolling = true;
  }
  
  void initHelper(float w, float h)
  {
    helper = new Helper(w, h);
  }
  
  void display()
  {
    pushMatrix();
    translate(-scrollX, 0);
    world.step();
    world.draw();
    popMatrix();
    
//    world.setEdges(scrollX, 0, scrollX + width, height);
//    world.setEdges(-width + scrollX, -height, width * 100, height);
    
    drawHelper();
    
    if (isScrolling)
      scrollX += speed;
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
        
        helper.me.setRotation(radians(180) - calculateAngle(mv[0].x, mv[0].y, mv[1].x, mv[1].y));
        
        if (mv[0].x > half)
          mv[0].x -= (mv[0].x - half) * 2;
        else
          mv[0].x += (half - mv[0].x) * 2;
          
        helper.lastX = mv[0].x;
        helper.lastY = mv[0].y;
        
        helper.me.setPosition(mv[0].x + scrollX, mv[0].y);
        helper.me.adjustPosition(-helper.me.getWidth(), helper.me.getHeight());
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
    if (!detected)
      helper.me.adjustPosition(speed, 0);
    return true;
  }
  
  Platform addStaticPlatform(float x, float y, float w, float h, float rot)
  {
    Platform p = new Platform(0, x, y, w, h, rot, 0, restitution);
    platforms.add(p);
    return p;
  }
  
  Platform addMovingPlatform(int dir, float x, float y, float w, float h, float rot, float speed)
  {
    Platform p = new Platform(dir, x, y, w, h, rot, speed, restitution);
    p.setMoving(true);
    platformsMoving.add(p);
    return p;
  }
  
  boolean addEnemy(Platform home, float w, float h, float speed)
  {   
    Enemy e = new Enemy(home, w, h, speed);
    
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
