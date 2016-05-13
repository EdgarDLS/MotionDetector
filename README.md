Edgar de León
Miquel Oliver

-> Añadir biblioteca -> buscar por "sound" -> "Sound | Sound library based on MethCla for Processing - The Processing Foundation").
-> Añadir biblioteca -> buscar por "video" -> "Video | GStreamer-based video library for Processing - The Processing Foundation").


FUNCIONAMIENTO
-------------------
Al iniciar el programa en Processing se abrirá una ventana 640x480.

Lo primero que hará será buscar si el ordenador tiene una webcam con la que poder hacer uso del programa. 
En caso de no tenerla mostrará un fondo negro con el mensaje "NO SIGNAL".

Al pasar por delante de la cámara se detectara movimiento y se encuadrara en color rojo el objeto o persona que se haya movido, además
dejará un pequeño rastro tras suyo durante un instante.


CONTROLES
-------------------
Teclado
	- "F" para desactivar la alarma.


FUTURAS INTENCIONES
-------------------
En la UI se añadirán dos opciones:
	- La primera será la de "settings", donde se podrá elegir como se seguirá el movimiento en la imagen y modificar el volumen.
	- La segunda será una consola en la que, mediante la introducción de un código se podran hacer diferentes cosas:
		· Resetear la alarma: si esta estaba sonando ("WARNING"), se podra reanudar, poniendola otra vez en "ONLINE".
		· Desactivar la alarma: ponerla en modo "OFFLINE".
		· "Hackear" la alarma: congelar la imagen, haciendo que ya no detecte movimiento y poder pasar por delante sin activarla.
Los diferentes modos de seguimiento de movimiento, para que el programa sea personalizable, serán el rectángulo que presentamos ya el 
primer prototipo, elipses y el rastro.


ERRORES DETECTADOS
-------------------
1. Actualmente el rectángulo se muestra todo el rato en pantalla. Deberiamos hacer que solo se muestre cuando aparece el movimiento.
	Ademàs, el seguimiento del movimiento no es fluido.
2. Si la el margen en la detección de movimiento es baja presenta problemas según la iluminación de la sala.
3. La alarma no entra en bucle una vez se activa.
4. Hay que ordenar el código, creando nuevas funciones, de modo que quede más claro.
	Esto será útil para poder hacer el apartado de la consola, así como los "settings", con mayor facilidad.
5. Si la cámara se activa o desactiva durante el uso del programa, la imagen queda congelada en lugar de cambiar de modo.