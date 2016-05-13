Edgar de Le�n
Miquel Oliver

-> A�adir biblioteca -> buscar por "sound" -> "Sound | Sound library based on MethCla for Processing - The Processing Foundation").
-> A�adir biblioteca -> buscar por "video" -> "Video | GStreamer-based video library for Processing - The Processing Foundation").


FUNCIONAMIENTO
-------------------
Al iniciar el programa en Processing se abrir� una ventana 640x480.

Lo primero que har� ser� buscar si el ordenador tiene una webcam con la que poder hacer uso del programa. 
En caso de no tenerla mostrar� un fondo negro con el mensaje "NO SIGNAL".

Al pasar por delante de la c�mara se detectara movimiento y se encuadrara en color rojo el objeto o persona que se haya movido, adem�s
dejar� un peque�o rastro tras suyo durante un instante.


CONTROLES
-------------------
Teclado
	- "F" para desactivar la alarma.


FUTURAS INTENCIONES
-------------------
En la UI se a�adir�n dos opciones:
	- La primera ser� la de "settings", donde se podr� elegir como se seguir� el movimiento en la imagen y modificar el volumen.
	- La segunda ser� una consola en la que, mediante la introducci�n de un c�digo se podran hacer diferentes cosas:
		� Resetear la alarma: si esta estaba sonando ("WARNING"), se podra reanudar, poniendola otra vez en "ONLINE".
		� Desactivar la alarma: ponerla en modo "OFFLINE".
		� "Hackear" la alarma: congelar la imagen, haciendo que ya no detecte movimiento y poder pasar por delante sin activarla.
Los diferentes modos de seguimiento de movimiento, para que el programa sea personalizable, ser�n el rect�ngulo que presentamos ya el 
primer prototipo, elipses y el rastro.


ERRORES DETECTADOS
-------------------
1. Actualmente el rect�ngulo se muestra todo el rato en pantalla. Deberiamos hacer que solo se muestre cuando aparece el movimiento.
	Adem�s, el seguimiento del movimiento no es fluido.
2. Si la el margen en la detecci�n de movimiento es baja presenta problemas seg�n la iluminaci�n de la sala.
3. La alarma no entra en bucle una vez se activa.
4. Hay que ordenar el c�digo, creando nuevas funciones, de modo que quede m�s claro.
	Esto ser� �til para poder hacer el apartado de la consola, as� como los "settings", con mayor facilidad.
5. Si la c�mara se activa o desactiva durante el uso del programa, la imagen queda congelada en lugar de cambiar de modo.