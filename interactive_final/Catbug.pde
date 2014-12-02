class Catbug
{
  float x;
  float y;
  int ySize;
  int xSize;
  float speed;
  PImage catbug;
  
  FBox main;
  
  Catbug(float x, float y)
  {
    this.x = x;
    this.y = y;
    xSize = 75;
    ySize = 87;
    speed = 2;
    
    catbug = loadImage("catbug.png");
    
    main = new FBox(75, 87);
    main.setStatic(false);
    main.setPosition(x, y);
    main.attachImage(catbug);
    world.add(main);
  }
  
  void reset()
  {
    //x = 0;
    //y = 70;
    main.setPosition(width / 2, 0);
  }
  
  void display()
  {
    image(catbug, x, y, 75, 87);
  }
}
