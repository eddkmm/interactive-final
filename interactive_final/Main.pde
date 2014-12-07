class Main extends Level
{
  float x;
  float y;
  int ySize;
  int xSize;
  float speed;
  PImage catbug;

  FBox main;

  Main(float x, float y)
  {
    super();
    this.x = x;
    this.y = y;
    xSize = 75;
    ySize = 87;
    speed = 2;

    catbug = loadImage("courage_scared_small.png");

    main = new FBox(75, 78);
    main.setStatic(false);
    main.setPosition(x, y);
    main.attachImage(catbug);
    world.add(main);
  }

  void reset()
  {
    //x = 0;
    //y = 70;
    main.setPosition(width / 2 + scrollX, 0);
  }

  void display()
  {
    image(catbug, x + scrollX, y, 75, 87);
  }
}

