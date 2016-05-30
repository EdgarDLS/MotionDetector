class Particles
{
  float posX;
  float posY;
  float size;
  float amplitud;
  float periode;
  float empuje;
  float empujeLimite;
  float [] acceleration = new float[2];
  float [] velocity = new float[2];
  float angSpeed;
  float initPosX;

  Particles (float posX, float posY)
  {
    this.initPosX = posX;
    this.posY = posY;
    size = random(5, 20);

    this.amplitud = random(3, 5);
    this.periode = random(500, 750);
    this.angSpeed = 2 * PI / this.periode;
    
    if (this.amplitud < 3.75) this.empuje = 1.2;
    else if (this.amplitud >= 3.75 && this.amplitud < 4.5) this.empuje = 1.5;
    else this.empuje = 1.8;
  }

  void drawBubbles()
  {
    if (posY > 0)
    {
      fill (255);
      ellipse(posX, posY, size, size);
    }
  }

  void ParticleMovement()
  {    
    // en vertical
    this.acceleration[1] = -this.empuje;
    //La acceleracion va aumentando hasta llegar a un limite (cuando se igualarian fuerzas de friccion y empuje) en que la velocidad sera constante (a = 0), simulando una burbuja
    if(acceleration[1] < 0) this.acceleration[1] += 0.1;
    this.velocity[1] += acceleration[1] * 0.15;
    this.posY += this.velocity[1] * 0.15;
    
    // ondulaciones horizontales
    
    //this.acceleration[0] = (-this.angSpeed) * this.amplitud * cos(this.angSpeed * millis());       no s'usa, doncs mitjançant demostracions es modifica directament la posicio i ahorram calculs
    //this.velocity[0] = (-this.angSpeed) * this.amplitud * sin(this.angSpeed * millis());           no s'usa, doncs mitjançant demostracions es modifica directament la posicio i ahorram calculs
    this.posX = (this.amplitud * cos(this.angSpeed * millis())) + initPosX;                          // a la posicion que cambia por la ondulacion se le suma la inicial 
  }
}