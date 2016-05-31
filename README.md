Edgar de Le�n
Miquel Oliver

-> A�adir biblioteca -> buscar por "sound" -> "Sound | Sound library based on MethCla for Processing - The Processing Foundation").
-> A�adir biblioteca -> buscar por "video" -> "Video | GStreamer-based video library for Processing - The Processing Foundation").


FUNCIONAMIENTO
-------------------
Al iniciar el programa en Processing se abrir� una ventana 640x480.

Lo primero que har� ser� buscar si el ordenador tiene una webcam con la que poder hacer uso del programa. 
En caso de no tenerla mostrar� un fondo negro con el mensaje "NO SIGNAL".

Al pasar por delante de la c�mara se detectar� movimiento y se encuadrara en color rojo el objeto o persona que se haya movido. 
Junto a ello, sonar� una alarma. 

En una capa superior se podran ver algunos aspectos como el estado de la c�mara, la hora y la fecha.

Podemos cambiar el tipo de detecci�n, as� como el margen de difer�ncia de luminosidad (sensibilidad), en el men� de opciones situado
en la parte inferior derecha de la pantalla. Estas opciones y el resto de controles estan explciados en el siguiente apartado.

Tambi�n se podran introducir ciertos c�digos en una peque�a consola como si de "contrase�as" se tratasen, los cuales estan tambi�n
explicados en el siguiente apartado.


CONTROLES
-------------------
Teclado
	- "FLECHA ARRIBA" para sacar la consola.
	- "FLECHA ABAJO" para esconder la consola.
	- "TECLADO NUMERICO" para indicar secuencia de n�meros.
	- "ENTER" para aceptar la secuencia de n�meros.
	- "RETROCESO" para eliminar un d�gito.
 
  CODIGOS
	- "7777" Introducir este c�digo para apagar la camara.
 	- "8989" Este codigo pondra en marcha la camara si anteriormente ha sido desconectada.
	- "4826" Sonido especial.
	- "2678" Para que se inicie la alarma.
	- "3214" Detendra la alarma en caso de que esta este activada (Al detener la alarma esta se volvera a activar en caso
		 de detectar movimiento).
	- "9935" Para encender la alarma (Encendida por defecto).
	- "5642" Para apagar la alarma.

Raton
  CONSOLA
	- Se podra clickar en el icono de la consola abajo a la izquierda (icono azul) para hacer que salga
		y en ella podremos clickar los n�meros e introducir los c�digos mostrados arriba.
  
  OPCIONES
	- Para abrir el men� de opciones tendremos que clickar en el icono de tuerca que hay en la esquina inferior derecha.
	- Al abrir el men� nos encontraremos con 2 opciones que son:
	- Margen de detecci�n, el cual nos mostrar� una barra con un n�mero que indica el margen de detecci�n (diferencia entre los grises) que tendra nuestro detector de movimiento.
		Cuanto m�s grande sea el valor mayor precision de deteccion tendr�. (Recomendamos dejarlo en 25 o m�s).
	- 3 opciones sobre como mostrar la detecci�n; 
		Cuadrada, remarcando el movimiento en un cuadrado.
		Circular, remarcando el movimiento en un c�rculo.
		Part�culas, se mostrar�n burbujas a partir del movimiento detectado.


IDEAS DESCARTADAS
-------------------
Antes de llegar a las burbujas, tuvimos diferentes ideas que descartamos debido a tiempo y, en tambi�n, complejidad (pues en tan pocos 
dias resultaban demasiadonelaboradas):
	- Nieve: nos planteamos hacer un sistema en que fuesen cayendo part�culas simulando nieve y al detectar que dos colores que se
		encuentran juntos son diferentes estas quedasen en ese punto y, al detectar movimiento siguiesen cayendo. Estas tendr�an
		masas aditivas de modo que al seguir cayendo lo har�an juntas y m�s r�pido. 
	- Arena: pensamos en hacer un sistema con una acceleraci�n horizontal que pudieses parar en alg�n punto mediante el movimiento 
		o hacer patrones de movimiento muy complejos. Adem�s, requer�a una cantidad enorme de part�culas en pantalla a la vez.


CONCLUSIONES
-------------------
Para esta segunda entrega, a dem�s de tratar los sistemas de part�culas como se nos hab�a exigido, fuimos capaces de a�adir lo que nos
hab�amos propuesto en la primera entrega: las opciones, la consola y diferentes modos de deteccion de movimiento.

Adem�s, aprovechamos la ocasi�n que se nos di� para trabajar con sistemas de part�culas y realidad aumentada para provar de a�adir alg�n
patr�n de movimiento interesante, de ah� sali� la idea de las burbujas, cuya acceleraci�n en el eje y es variable hasta llegar a una
velocidad l�mite (simulando el empuje del agua), mientras que en el eje x, para describir una ondulaci�n, usamos f�rmulas ya conocidas
de MVAS (Movimiento Vibrat�rio �rm�nico Simple).

Tambi�n hemos pasado todos los controles a una interf�cie, de forma que todo se pueda hacer con el rat�n sin causar mol�stias. En caso de
querer usar el teclado, eso es podible al estar usando la consola, mediante los n�meros y "enter", as� como mostrar y ocultar esta con las
flechas arriba y abajo respectivamente.
