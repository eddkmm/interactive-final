
void drawGUI()
{
  // Courage bar
  rectMode(CORNER);
  noStroke();
  fill(56, 245, 255);
  rect(((width / 2) - 115) - (250 / 2), height - 25, (float(currentConfidence) / float(maxConfidence)) * 250, 10, 7);
  stroke(0);
  //println("health / fullHealth: " + float(mainBattle.health) / float(mainBattle.fullHealth) + " " + millis());
  strokeWeight(1);
  noFill();
  rect(((width / 2) - 115) - (250 / 2), height - 25, 250, 10, 7);
}
