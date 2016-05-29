class Particles
{
  float posX;
  float posY;
  float size;
  float amplitud;
  float periode;
  float empuje;
  float empujeLimite;
  
  Particles (float posX, float posY)
  {
    this.posX = posX;
    this.posY = posY;
    size = random(5, 20);
  }
  
  void drawBubbles()
  {
    if (posY > 0)
    {
      fill (255);
      ellipse(posX, posY, size, size);
    }
  }
}