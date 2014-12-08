class Main extends Level
{
  float x;
  float y;
  int ySize;
  int xSize;
  float speed;
  PImage[] img = new PImage[4];
  int imgI;
  long imgLast;

  FBox main;

  Main(FWorld w, float x, float y)
  {
    super();
    this.x = x;
    this.y = y;
    xSize = 75;
    ySize = 87;
    speed = 2;
    imgI = 0;
    
    for (int i = 0; i < 4; i++) {
      img[i] = loadImage("courage/courage-" + i + ".gif");
    }

    main = new FBox(75, 78);
    main.setStatic(false);
    main.setPosition(x, y);
    main.setRotatable(false);
    main.attachImage(img[0]);
    w.add(main);
  }

  void reset()
  {
    //x = 0;
    //y = 70;
    main.setPosition(width / 2 + scrollX, 0);
  }

  void display()
  {
    //image(catbug, x + scrollX, y, 75, 87);
    
    //image(ynp[ynpI], width / 2, height / 2 + 50, width * 1.5, height * 1.5);
    main.attachImage(img[imgI]);
    
    if (imgLast + 250 < millis()) {
      imgLast = millis();
      imgI++;
      if (imgI >= img.length) {
        // Reset
        imgI = 1;
      }
    }
  }
}

