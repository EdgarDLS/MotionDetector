import processing.video.*;

static final float MARGIN_ERROR = 15;                  // Margen de error para saber cuando hay movimiento en la camara.

int recTimer = millis();                               // Variable para que la bolita roja del REC aparezca y desaparezca.
boolean redDot = true;                                 // Booleana para saber si le toca mostrar o no la bolita.
String [] monthNames = {"JAN", "FEB" , "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};  // Nombre de los meses que mostrar en el status de DATE de la camara.

Capture cam;                                           // Camara.
PImage prevFrame;                                      // Frame anterior para hacer las comprovaciones.

boolean signal = true;                                 // Booleana para saber si tenemos señal de la camara.


void setup() 
{
  size(640, 480);
  noStroke();                                          // Para que el punto rojo de REC no tenga borde.

  String[] cameras = Capture.list();

  // Si el ordenador no tiene camaras mostrar un mensaje diciendo que no hay camaras disponibles y se cerrara el programa.
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    signal = false;
  }
  else
  {
    cam = new Capture(this, width, height, 30);          // Creamos una nueva camara con el constructor de Capture (libreria de video de Processing).
    prevFrame = createImage(cam.width, cam.height, RGB); // Creamos una imagen para el primer frame de la camara.
    cam.start();                                         // Ponemos en marcha la camara.
  }
}


void draw() 
{
  background(0);
  
  if(signal){
    CompareImages(cam, prevFrame);
  }
  else noSignal();
  
  cameraStatus();
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
  
  if (signal){                                            // Dependiendo de si tenemos señal de la camara o no querremos mostrar la bolita conforome la camara esta en funcionamiento.
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
  }
  else
  {
    fill(255, 0, 0);
    text("OFFLINE", width/2, 25);
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
  
  
}

void CompareImages (Capture camera, PImage prevCamera)
{
  // Cogemos la luminosidad de la captura y l aimagen a comparar
  float[] cameraLum = Luminosity(camera);
  float[] prevCameraLum = Luminosity(prevCamera);

  loadPixels();
  cam.loadPixels();                                  //Actualizaremos la camara directamente.

  for (int x = 0; x <  cameraLum.length; x++)
  {
    color current = cam.pixels[x];
    if (abs(prevCameraLum[x]-cameraLum[x]) >= MARGIN_ERROR)    // Un margen de error en la deteccion del cambio de luminosidad en la imagen
    {
      current = (int)cameraLum[x] - (int)prevCameraLum[x];
    }
    pixels[x] = current;
  }
  updatePixels();
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