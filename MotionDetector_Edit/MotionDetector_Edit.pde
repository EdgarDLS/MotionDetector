import processing.sound.*;
import processing.video.*;


float MARGIN_ERROR = 15;                        // Margen de error para saber cuando hay movimiento en la camara.

int recTimer = millis();                               // Variable para que la bolita roja del REC aparezca y desaparezca.
boolean redDot = true;                                 // Booleana para saber si le toca mostrar o no la bolita.
String [] monthNames = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};  // Nombre de los meses que mostrar en el status de DATE de la camara.


// CAMARA
Capture cam;                                           // Camara.
PImage prevFrame;                                      // Frame anterior para hacer las comprovaciones.

// ESTADOS
boolean signal = true;                                 // Booleana para saber si tenemos señal de la camara.
boolean alarm = false;
boolean alarmPlaying = false;

// SONIDOS
SoundFile alarmSound;
SoundFile beepSound;
SoundFile quackSound;

// ICONOS
PImage settingsIcon;                                  // Variable donde guardare el icono de opciones.
PImage consoleIcon;                                   // Variable donde guardare el icono de codigos.
PImage consolaGrande;

// MENUS
boolean showConsole = false;
boolean showOptions = false;

int consoleStartingPosition = 340;
int consoleAlpha =  0;

int optionsStartingPosition = 340;
int optionsAlpha = 0;
int detectionBall = 270;
int lastDetectionBall = 0;
boolean detectionBar = false;
boolean squareDetection = true;
boolean particles = false;

ArrayList<String> code = new ArrayList<String>();
String showValue = "";

// PARTICLES
ArrayList<Particles> bubbleParticle = new ArrayList<Particles>();

void setup() 
{
  size(640, 480);
  noStroke();                                          // Para que el punto rojo de REC no tenga borde.

  String[] cameras = Capture.list();
  alarmSound = new SoundFile(this, "intruder.mp3");
  beepSound = new SoundFile(this, "beep.mp3");
  quackSound = new SoundFile(this, "quack.mp3");

  settingsIcon = loadImage("icons/settings.png");
  consoleIcon = loadImage("icons/console.png");
  consolaGrande = loadImage("icons/consolaGrande.png");

  // Si el ordenador no tiene camaras mostrar un mensaje diciendo que no hay camaras disponibles y se cerrara el programa.
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    signal = false;
  } else
  {
    cam = new Capture(this, width, height, 30);          // Creamos una nueva camara con el constructor de Capture (libreria de video de Processing).
    prevFrame = createImage(cam.width, cam.height, RGB); // Creamos una imagen para el primer frame de la camara.
    cam.start();                                         // Ponemos en marcha la camara.
  }
}


void draw() 
{
  background(0);

  if (alarm && !alarmPlaying) {
    alarmSound.loop();
    alarmPlaying = true;
  }

  if (signal) {
    CompareImages(cam, prevFrame);
  } else noSignal();

  showConsole();
  showOptions();
  cameraStatus();

  /*
  fill(255, 0 ,0);
   if (mouseX > width/2) textAlign(RIGHT);
   else textAlign(LEFT);
   text(mouseX + ", " + mouseY, mouseX, mouseY);
   */
}

/* 
 Cada vez que la camara este disponible llamara el evento de captureEvent
 y metera el frame anterior en prevFrame, prevFrame hara el update para que se muestre
 y volveremos a leer la camara para realizar otra vez el proceso.
 */
void captureEvent(Capture cam)
{
  prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height); 
  prevFrame.updatePixels();
  cam.read();
}

// Funcion para que nos muestre el cartelito de "NO SIGNAL" cuando no recibimos señal de ninguna camara.
void noSignal()
{
  fill(255);
  textSize(32);
  textAlign(CENTER);
  text("NO SIGNAL", width/2, height/2);
}

// Funcion para mostrar el estado de la camara (Si esta grabando, la hora, la fecha y las opciones que tiene).
void cameraStatus()
{
  // REC
  fill(255);
  textSize(15);
  textAlign(LEFT);
  text("REC", 15, 25);

  if (signal) {                                            // Dependiendo de si tenemos señal de la camara o no querremos mostrar la bolita conforome la camara esta en funcionamiento.
    fill(255, 0, 0);

    if (millis() - recTimer > 1000)                       // Esta condicion hara que muestre la bolita roja del REC se muestre 1 segundo si y 1 segundo no.
    {
      if (redDot) redDot = false;
      else redDot = true;

      recTimer = millis();
    }

    if (redDot) ellipse(58, 20, 13, 13);
  }

  // SIGNAL
  textAlign(CENTER);
  if (signal)
  {
    fill(0, 200, 0);
    text("ONLINE", width/2, 25);
  } else if (!signal)
  {
    fill(255, 0, 0);
    text("OFFLINE", width/2, 25);
  } else if (alarm) {
    fill (255, 0, 0);
    text("WARNING", width/2, 25);
  }

  // TIME
  fill(255);
  textSize(13);
  textAlign(RIGHT);
  int s = second();
  int m = minute();
  int h = hour();
  String clock = String.format("%02d", h) + ":" + String.format("%02d", m) + ":" + String.format("%02d", s);
  text(clock, width - 15, 25);


  // DATE
  textAlign(LEFT);
  int day = day();
  String month = monthNames[month() -1];
  int year = year();
  String calendar = String.format("%02d", day) + "/" + month + "/" + year;
  text(calendar, 15, height - 25);

  // OPTIONS
  imageMode(CENTER);
  tint(255);
  image(settingsIcon, width - 30, height - 30, 25, 25);
  image(consoleIcon, width - 65, height - 30, 25, 25);

  if (showConsole)
  {
    textAlign(RIGHT);
    String digits = "";
    for (int i = 0; i < code.size(); i++)
    {   
      digits += code.get(i);
      digits += "  ";
    }
    textSize(15);
    text(digits, 369, 160);
  }
}

// Funcion para mostrar la consola cuando se clicka en ella.
void showConsole()
{
  if (showConsole)
  {
    tint(255, consoleAlpha);
    image(consolaGrande, width/2, consoleStartingPosition, 180, 230);

    if (consoleStartingPosition > height/2)
    {
      consoleStartingPosition -= 3;
      consoleAlpha += 10;
    }
  } else if (!showConsole && consoleStartingPosition < 340)
  {
    tint(255, consoleAlpha);
    image(consolaGrande, width/2, consoleStartingPosition, 180, 230);

    consoleStartingPosition += 3;
    consoleAlpha -= 10;
  }
}

// Funcion para mostrar las opciones cuando clickamos en ellas.
void showOptions()
{
  if (showOptions)
  {
    ellipseMode(CENTER);
    rectMode(CENTER);
    fill (230, optionsAlpha);
    rect (width/2, optionsStartingPosition, 300, 160, 10);

    // Barra de precision para detectar movimiento
    fill(0);
    textSize(12);
    textAlign(LEFT);
    text ("Precision de deteccion", width/2 - 130, optionsStartingPosition-50);

    stroke(0, 250);
    strokeWeight(1);
    line(width/2 - 130, optionsStartingPosition-15, width/2 + 130, optionsStartingPosition-15);

    if (detectionBall >= width/2 - 130 && detectionBall <= width/2 + 130)    // Para asegurarme que al dibujar la bola no se haya pasado de la linea establecida.
    {
      lastDetectionBall = detectionBall;
    }

    // Bola que marca el nivel de precision
    ellipse (lastDetectionBall, optionsStartingPosition-15, 15, 15);
    MARGIN_ERROR = (15 * lastDetectionBall) / 270;

    // Como se mostrara la deteccion
    text ("Cuadrada", width/2 - 130, optionsStartingPosition +35);
    text ("Circular", width/2 - 130, optionsStartingPosition +55);

    noFill();
    ellipse (width/2 - 55, optionsStartingPosition +30, 11, 11);
    ellipse (width/2 - 55, optionsStartingPosition +50, 11, 11);

    fill (0);
    if (squareDetection && !particles) ellipse (width/2 - 55, optionsStartingPosition +30, 5, 5);
    else if (!squareDetection && !particles) ellipse (width/2 - 55, optionsStartingPosition +50, 5, 5);

    textAlign(RIGHT);
    text ("Particulas", width/2 + 130, optionsStartingPosition +35);
    noFill();
    ellipse (width/2 + 55, optionsStartingPosition +30, 11, 11);
    fill (0);
    if (particles) ellipse (width/2 + 55, optionsStartingPosition +30, 5, 5);
    else

      if (optionsStartingPosition > height/2)
      {
        optionsStartingPosition -= 3;
        optionsAlpha += 10;
      }
  } else if (!showOptions && optionsStartingPosition < 340)
  {
    fill (230, optionsAlpha);
    rect (width/2, optionsStartingPosition, 300, 160, 10);

    fill(0);
    textSize(12);
    textAlign(LEFT);
    text ("Precision de deteccion", width/2 - 130, optionsStartingPosition-50); 

    stroke(0, 250);
    strokeWeight(1);
    line(width/2 + 130, optionsStartingPosition-15, width/2 - 130, optionsStartingPosition-15);
    ellipse (lastDetectionBall, optionsStartingPosition-15, 15, 15);

    text ("Cuadrado", width/2 - 130, optionsStartingPosition +35);
    text ("Circular", width/2 - 130, optionsStartingPosition +55);

    noFill();
    ellipse (width/2 - 55, optionsStartingPosition +30, 11, 11);
    ellipse (width/2 - 55, optionsStartingPosition +50, 11, 11);

    fill (0);
    if (squareDetection && !particles) ellipse (width/2 - 55, optionsStartingPosition +30, 5, 5);
    else if (!squareDetection && !particles) ellipse (width/2 - 55, optionsStartingPosition +50, 5, 5);

    textAlign(RIGHT);
    text ("Particulas", width/2 + 130, optionsStartingPosition +35);
    noFill();
    ellipse (width/2 + 55, optionsStartingPosition +30, 11, 11);
    fill (0);
    if (particles) ellipse (width/2 + 55, optionsStartingPosition +30, 5, 5);

    optionsStartingPosition += 3;
    optionsAlpha -= 10;
  }

  noStroke();
}

// Funcion para comparar el frame anterior y el actual y ver si hay diferencias.
void CompareImages (Capture camera, PImage prevCamera)
{
  // Cogemos la luminosidad de la captura y l aimagen a comparar
  float[] cameraLum = Luminosity(camera);
  float[] prevCameraLum = Luminosity(prevCamera);
  int[] changed = {camera.width, 0, camera.height, 0};                        //Provisional, para dibujar un cuadrado, contiene 4 de las posiciones de los pixeles que cambian para enmarcarlos todos 
  float [] midPoint = new float[2];
  boolean different = false;

  loadPixels();
  cam.loadPixels();                                  //Actualizaremos la camara directamente.

  for (int x = 0; x <  cameraLum.length; x++)
  {
    float averagePrevLum = 0;
    float averageLum = 0;
    if (x % camera.height != 0 && (x % camera.height) % 3 == 0) 
    {
      for (int y = 0; y < 3; y++) 
      {
        averagePrevLum += prevCameraLum[x - y];
        averageLum += cameraLum[x - y];
      }
      averagePrevLum /= 3;
      averageLum /= 3;
    }
    color current = cam.pixels[x];
    if (abs(averagePrevLum - averageLum) >= MARGIN_ERROR)    // Un margen de error en la deteccion del cambio de luminosidad en la imagen
    {
      //Actualiza los valores de la variable changed segun los pixeles que cambian
      if (x % camera.width < changed[0]) changed[0] = x % camera.width;
      if (x % camera.width > changed[1]) changed[1] = x % camera.width;
      if (x / camera.width < changed[2]) changed[2] = x / camera.width;
      if (x / camera.width > changed[3]) changed[3] = x / camera.width;

      different = true;

      alarm = true;

      //Actualiza el color de los pixeles cuya luminosisad ha variado mas que el margen permitido
      current = (int)cameraLum[x] - (int)prevCameraLum[x];
    }
    pixels[x] = current;
  }
  updatePixels();

  if (!different) {
    changed[0] = 0;
    changed[1] = 0;
    changed[2] = 0;
    changed[3] = 0;
  }

  midPoint[0] = changed[0] + (changed[1] - changed[0]);  
  midPoint[1] = changed[2] + (changed[3] - changed[2]);

  if (particles)             // Dibujamos unas burbujas como particulas donde hay movimiento
  {
    // PODEMOS METERLE UNA CONDICION DE QUE SOLO CREE BURBUJAS CADA X TIEMPO EN LUGAR DE CADA UPDATE
    // CUANDO LO TENGAMOS PUESTO YA VEREMOS DEPENDIENDO DE COMO QUEDE.
    bubbleParticle.add(new Particles(midPoint[0], midPoint[1]));
    drawBubbles();           // Dibuja las burbujas
  } else if (squareDetection)  //Se dibuja un rectangulo indicando la zona donde hay movimiento
  {
    noFill();
    stroke(255, 0, 0);
    strokeWeight(3);
    rectMode(CORNER);
    rect(changed[0], changed[2], changed[1] - changed[0], changed[3] - changed[2]);
  } else if (!squareDetection) //Se dibuja un circulo indicando la zona donde hay movimiento
  {
    noFill();
    stroke(255, 0, 0);
    strokeWeight(3);
    ellipseMode(CORNER);
    float radius;
    if (changed[1] - changed[0] > changed[3] - changed[2])
      radius = changed[1] - changed[0];
    else
      radius = changed[3] - changed[2];
    ellipse(changed[0], changed[2], radius, radius);
  }
}

float[] Luminosity (Capture camera)
{
  loadPixels();                                          // Le indicamos que vamos a leer los pixeles.
  camera.loadPixels();                                   // Leemos los pixeles de la camara que se le pasa.

  float[] luminosity = new float[camera.width * camera.height];    //Un array que almacenara la luminosidad de cada pixel

  for (int x=0; x < camera.width; x++)
  {
    for (int y =0; y < camera.height; y++)
    {
      int loc = x + y*camera.width;                          // La localizacion del pixel en el que estamos.
      color current = camera.pixels[loc];                    // Cogemos el color del pixel de esta localizacion (variable anterior).

      // Le metemos la formula para cambiar el color del pixel RGB a escala de grises.
      // (0.2126*R + 0.7152*G + 0.0722+B)
      // Esta no esta normalizada, por tanto nos da un resultado cuyos valores se encuentran entre 0 y 255.
      luminosity[loc] = (0.2126*red(current) + 0.7152*green(current) + 0.0722*blue(current));
    }
  } 
  return luminosity;                                         //Retornamos el array
}

// OVERLOAD para coger la luminosidad, no solo de capturas, sino tambien de imagenes
float[] Luminosity (PImage camera)
{
  loadPixels();
  camera.loadPixels();

  float[] luminosity = new float[camera.width * camera.height];

  for (int x=0; x < camera.width; x++)
  {
    for (int y =0; y < camera.height; y++)
    {
      int loc = x + y*camera.width;
      color current = camera.pixels[loc];

      luminosity[loc] = (0.2126*red(current) + 0.7152*green(current) + 0.0722*blue(current));
    }
  } 
  return luminosity;
}

void drawBubbles()
{
  for (int i = 0; i < bubbleParticle.size(); i++)
  {
    bubbleParticle.get(i).drawBubbles();
  }
}

void keyPressed()
{
  if (key == 'f') {
    alarm = false;
    alarmPlaying = false;
    alarmSound.stop();
  }
}

void mouseDragged()
{
  line(width/2 - 130, optionsStartingPosition-15, width/2 + 130, optionsStartingPosition-15);

  if (mouseX > width/2 - 130 && mouseX < width/2 + 130 && mouseY > optionsStartingPosition - 30 && mouseY < optionsStartingPosition)
  {
    detectionBar = true;
  }

  if (detectionBar) detectionBall = mouseX;
}

void mouseReleased ()
{
  detectionBar = false;
}

void mousePressed()
{
  if (mouseX > 590 && mouseX < 625 && mouseY > 430 && mouseY < 465)          // Si estamos entre los pixeles del icono de las opciones
  {
    showOptions = !showOptions;
    if (showConsole && showOptions) showConsole = false;
  } else if (mouseX > 560 && mouseX < 590 && mouseY > 430 && mouseY < 465)    // Si estamos entre los pixeles del icono de la consola
  {
    showConsole = !showConsole; 
    if (showConsole && showOptions) showOptions = false;
  } else if (showConsole)
  {
    // FIRST ROW
    if (code.size() < 5)
    {
      if (mouseX > 260 && mouseX < 300 && mouseY > 200 && mouseY < 235)
      {
        code.add("7");
        beepSound.play();
        println(code);
      } else if (mouseX > 300 && mouseX < 340 && mouseY > 200 && mouseY < 235)
      {
        code.add("8");
        beepSound.play();
        println(code);
      } else if (mouseX > 340 && mouseX < 380 && mouseY > 200 && mouseY < 235)
      {
        code.add("9");
        beepSound.play();
        println(code);
      }

      // SECOND ROW
      else if (mouseX > 260 && mouseX < 300 && mouseY > 235 && mouseY < 275)
      {
        code.add("4");
        beepSound.play();
        println(code);
      } else if (mouseX > 300 && mouseX < 340 && mouseY > 235 && mouseY < 275)
      {
        code.add("5");
        beepSound.play();
        println(code);
      } else if (mouseX > 340 && mouseX < 380 && mouseY > 235 && mouseY < 275)
      {
        code.add("6");
        beepSound.play();
        println(code);
      }

      // THIRD ROW
      else if (mouseX > 260 && mouseX < 300 && mouseY > 275 && mouseY < 310)
      {
        code.add("1");
        beepSound.play();
        println(code);
      } else if (mouseX > 300 && mouseX < 340 && mouseY > 275 && mouseY < 310)
      {
        code.add("2");
        beepSound.play();
        println(code);
      } else if (mouseX > 340 && mouseX < 380 && mouseY > 275 && mouseY < 310)
      {
        code.add("3");
        beepSound.play();
        println(code);
      }
    }

    // FOURTH ROW
    if (mouseX > 255 && mouseX < 300 && mouseY > 325 && mouseY < 350)
    {
      try {
        code.remove(code.size()-1);
      }
      catch (Exception e) {
        println("There are no digits to delete");
      }
      println(code);
    } else if (mouseX > 340 && mouseX < 385 && mouseY > 325 && mouseY < 350)
    {
      beepSound.play();
      checkCode();    // Comprobamos el codigo que estamos escribiendo para ver si ya tiene 4 digitos y si es correcto.
    }




    // NECESITO UN BOTON PARA QUE LLAME AL CHECKCODE Y NO QUE LO MIRE CADA VEZ QUE SE PULSA UNO CUALQUIERA
  } else if (showOptions)
  {
    if (mouseX > width/2 - 62 && mouseX < width/2 - 48 && mouseY > optionsStartingPosition +20 && mouseY < optionsStartingPosition +40)
    {
      squareDetection = true;
    } else if (mouseX > width/2 - 62 && mouseX < width/2 - 48 && mouseY > optionsStartingPosition +40 && mouseY < optionsStartingPosition +60)
    {
      squareDetection = false;
    } else if (mouseX < width/2 + 62 && mouseX > width/2 + 48 && mouseY > optionsStartingPosition +20 && mouseY < optionsStartingPosition +40)
    {
      particles = !particles;
    }
  }
}

void checkCode() {
  if (code.size() >= 4)
  {
    for (int i = 0; i < code.size(); i++)
    {   
      showValue += code.get(i);
    }

    if (showValue.equals("7777")) signal = false;
    else if (showValue.equals("8989")) signal = true;
    else if (showValue.equals("6969")) quackSound.play();
    else if (showValue.equals("2678")) alarm = true;
    else if (showValue.equals("3214"))
    {
      alarm = false; 
      alarmSound.stop();
      alarmPlaying = false;
    } else println("INVALID CODE");
  } else println("INVALID CODE");

  code.clear();
  showValue = "";
}