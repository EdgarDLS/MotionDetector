Edgar de León
Miquel Oliver

-> Añadir biblioteca -> buscar por "sound" -> "Sound | Sound library based on MethCla for Processing - The Processing Foundation").
-> Añadir biblioteca -> buscar por "video" -> "Video | GStreamer-based video library for Processing - The Processing Foundation").


FUNCIONAMIENTO
-------------------
Al iniciar el programa en Processing se abrirá una ventana 640x480.

Lo primero que hará será buscar si el ordenador tiene una webcam con la que poder hacer uso del programa. 
En caso de no tenerla mostrará un fondo negro con el mensaje "NO SIGNAL".

Al pasar por delante de la cámara se detectará movimiento y se encuadrara en color rojo el objeto o persona que se haya movido. 
Junto a ello, sonará una alarma. 

En una capa superior se podran ver algunos aspectos como el estado de la cámara, la hora y la fecha.

Podemos cambiar el tipo de detección, así como el margen de diferéncia de luminosidad (sensibilidad), en el menú de opciones situado
en la parte inferior derecha de la pantalla. Estas opciones y el resto de controles estan explciados en el siguiente apartado.

También se podran introducir ciertos códigos en una pequeña consola como si de "contraseñas" se tratasen, los cuales estan también
explicados en el siguiente apartado.


CONTROLES
-------------------
Teclado
	- "FLECHA ARRIBA" para sacar la consola.
	- "FLECHA ABAJO" para esconder la consola.
	- "TECLADO NUMERICO" para indicar secuencia de números.
	- "ENTER" para aceptar la secuencia de números.
	- "RETROCESO" para eliminar un dígito.
 
  CODIGOS
	- "7777" Introducir este código para apagar la camara.
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
		y en ella podremos clickar los números e introducir los códigos mostrados arriba.
  
  OPCIONES
	- Para abrir el menú de opciones tendremos que clickar en el icono de tuerca que hay en la esquina inferior derecha.
	- Al abrir el menú nos encontraremos con 2 opciones que son:
	- Margen de detección, el cual nos mostrará una barra con un número que indica el margen de detección (diferencia entre los grises) que tendra nuestro detector de movimiento.
		Cuanto más grande sea el valor mayor precision de deteccion tendrá. (Recomendamos dejarlo en 25 o más).
	- 3 opciones sobre como mostrar la detección; 
		Cuadrada, remarcando el movimiento en un cuadrado.
		Circular, remarcando el movimiento en un círculo.
		Partículas, se mostrarán burbujas a partir del movimiento detectado.


IDEAS DESCARTADAS
-------------------
Antes de llegar a las burbujas, tuvimos diferentes ideas que descartamos debido a tiempo y, en también, complejidad (pues en tan pocos 
dias resultaban demasiadonelaboradas):
	- Nieve: nos planteamos hacer un sistema en que fuesen cayendo partículas simulando nieve y al detectar que dos colores que se
		encuentran juntos son diferentes estas quedasen en ese punto y, al detectar movimiento siguiesen cayendo. Estas tendrían
		masas aditivas de modo que al seguir cayendo lo harían juntas y más rápido. 
	- Arena: pensamos en hacer un sistema con una acceleración horizontal que pudieses parar en algún punto mediante el movimiento 
		o hacer patrones de movimiento muy complejos. Además, requería una cantidad enorme de partículas en pantalla a la vez.


CONCLUSIONES
-------------------
Para esta segunda entrega, a demàs de tratar los sistemas de partículas como se nos había exigido, fuimos capaces de añadir lo que nos
habíamos propuesto en la primera entrega: las opciones, la consola y diferentes modos de deteccion de movimiento.

Además, aprovechamos la ocasión que se nos dió para trabajar con sistemas de partículas y realidad aumentada para provar de añadir algún
patrón de movimiento interesante, de ahí salió la idea de las burbujas, cuya acceleración en el eje y es variable hasta llegar a una
velocidad límite (simulando el empuje del agua), mientras que en el eje x, para describir una ondulación, usamos fórmulas ya conocidas
de MVAS (Movimiento Vibratório Ármónico Simple).

También hemos pasado todos los controles a una interfície, de forma que todo se pueda hacer con el ratón sin causar moléstias. En caso de
querer usar el teclado, eso es podible al estar usando la consola, mediante los números y "enter", así como mostrar y ocultar esta con las
flechas arriba y abajo respectivamente.
