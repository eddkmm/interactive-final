class FBoxAR extends FBox
{
  
  FBoxAR(float width, float height)
  {
    super(width, height);
  }
  @Override
  public void draw(PGraphics applet)
  {
    try {
      augmentedRealityMarkers.detect(video);
      
      if (augmentedRealityMarkers.isExistMarker(0)) {
        pushStyle();
        pushMatrix();
        rectMode(CENTER);
        appletFillStroke(applet);
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(0));
        //scale(-1.0, 1.0);
        if (m_image != null)
          drawImage(applet);
        else
          rect(0, 0, getWidth(), getHeight());
          
        float xblah = modelX(0, 0, 0);
        float yblah = modelY(0, 0, 0);
        
        println(xblah + " | " + yblah);
          
        setPosition(xblah, yblah);
        
        popMatrix();
        popStyle();
      }
    } catch (Exception e) {
      println("Issue with AR detection ... resuming regular operation ..");
    }
  }
}
