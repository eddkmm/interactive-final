class ColorInfo
{
  color desiredColor;
  int x, y;
  int numPixels;  
  
  int averageX, averageY;

  ColorInfo(color c)
  {
    this.desiredColor = c;
  }

  void clear()
  {
    this.x = 0;
    this.y = 0;
    this.numPixels = 0;
  }
  
  void setColor(color c)
  {
    this.desiredColor = c;
    println("Captured color: " + red(desiredColor) + ", " + green(desiredColor) + ", " + blue(desiredColor) );
  }    

  void checkPixel(color c, int x, int y, int threshold)
  {
    // compute distance
    float testDistance = dist( red(c), green(c), blue(c), 
                               red(desiredColor), green(desiredColor), blue(desiredColor));

    // is this less than the global threshold?
    if (testDistance < threshold)
    {
      this.x += x;
      this.y += y;
      this.numPixels++;
    }
  }

  void computeAveragePosition()
  {
    if (this.numPixels > 0)
    {
      this.averageX = this.x/this.numPixels;
      this.averageY = this.y/this.numPixels;
    }
  }
  
  void drawBox()
  {
    if (this.numPixels > 0)
    {
      rectMode(CENTER);
      strokeWeight(3);
      stroke(this.desiredColor);
      fill(255, 50);
      rect( this.x/this.numPixels, this.y/this.numPixels, 25, 25);
    }
  }
}

