
class Button
{
  float x, y;
  int w, h;
  int buttonColor;
  int buttonOverColor;
  int textColor;
  String content;
  int buttonTextSize;
  boolean isPressed;
  
  // Class constructor
  Button(float xPos, float yPos, int wSize, int hSize, int bColor1, int bColor2, int bTextColor, String bText, int bTextSize)
  {
    x = xPos;
    y = yPos;
    w = wSize;
    h = hSize;
    buttonColor = bColor1;
    buttonOverColor = bColor2;
    textColor = bTextColor;
    content = bText;
    buttonTextSize = bTextSize;
    isPressed = false;
  }
  
  void display()
  {
    if (isPressed) {
      strokeWeight(2);
      stroke(255);
    } else {
      strokeWeight(1);
      stroke(0);;
    }
      
    rectMode(CORNER);
    fill((!isMouseOver()) ? buttonColor : buttonOverColor);//, (abs((y + (h / 2)) - mouseY) < h * 2) ? 255 : 50);
    rect(x, y, w, h);
    textAlign(CENTER, CENTER);
    textSize(buttonTextSize);
    fill(textColor);
    text(content, x + (w / 2), y + (h / 2) - 2);
  }
  
  boolean isMouseOver()
  {
    return (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h)
    ? true : false;
  }
  
  void setText(String bText)
  {
    content = bText;
  }
}
