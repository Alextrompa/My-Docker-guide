# Cuando vaya a hablar de como hacer tu propio docker, hablaré sobre el comando build
# Comandos de los que no voy a hablar porque creo que no merece la pena: commit, container, push, diff, help, image, system
# Comando de los que por ahora no voy a hablar o no lo voy a hacer directamente: build, node, network, secret, service, stack, swarm y plugin.

#Una primera tarea que podriamos llevar a cabo con docker es activarlo para que se inicie durante el arranque. Para esto usamos:

	sudo systemctl enable docker

	# Si esto no nos gusta y queremos desactivar esto

	sudo systemctl disable docker


#Existen dos versiones de Docker
	# Docker CE (Comunity Edition) totalmente gratuita
	# Docker EE (Enterprise Edition), de pago y con más características


#Imagenes de las distintas aplicaciones
#	https://store.docker.com/search?source=verified&type=image


# Conceptos

#	Imagen:		Instrucciones para crear un contenedor. Estas son solo de lectura.

#	Contenedor:	Es una instancia ejecutable de una imagen. Se pueden crear, poner
#			en marcha, parar, mover o borrar. Incluso se puede crear una
#			Imagen a partir del estado actual de un contenedor.

#	Volumen:	Es la mejor forma para que los datos en un contenedor se almacenen de una manera persistente 
#			y se conserven aún después de eliminar el contenedor.
#			Facilita que varios contenedores compartan el sistema de ficheros.
#			Son administrados directmente por Docker, por lo que son sencillos de mantener.
#			El usuario puede crearlos, borrarlos y modificarlos.

#	Montaje ligado: Parecidos a los volúmenes, aunque tienen una funcionalidad más limitada.
#			Mientras que los volúmenes se almacenan de manera aislada, los montajes ligados consisten en
#			montar un fichero o directorio en un contenedor. El fichero es referenciado por su ruta.
#			Peligro: El sistema de ficheros de la máquina queda expuesto ante los programas del contenedor
#			por lo que podrían modificarlo.

#	Montaje tmpfs:	Esta opción solo se puede utilizar en linux, y se utiliza cuando no queremos que los datos del contenedor perduren en el tiempo.
#			Esto puede ser así por seguridad, porque el contenedor puede manejar una gran cantidad de datos o por cualquier otro motivo.


# 	Registry: 	Un registry es una base de datos de imágenes. O dicho de otra forma, un sitio donde guardar las imágenes, un hub.
#			El registry más famoso es el Docker Hub o DOcker Store, donde podemos crear una cuenta de usuario y subir nuestras imágenes (también descargarlas).
#			Registry es en sí otra imágen, por lo que sí, podemos descargarla, hacer un contenedor con ella y guardar en el mismo nuestras imágenes.


# NOTE, quizás haya que mejorar las explicaciones de los de algunos conceptos
# Debería explicar como crear y administrar volumenes, etc. Esto en la tercera parte.

# Nombres  o id de contenedor. Explicar la diferencia y que casi todos los comandos que he puesto son el id porque no conocia lo del nombre.




# Para ejecutar cualquier imagen se utiliza el comando "docker run Imagen"
# Este comando comprueba las librerias que utiliza la Imagen. En caso de que falte alguna, la descargará del repositorio (como si utilizara docker pull)
# Ejemplos
	docker run hello-world		# Esta Imagen suele ejecutarse para comprobar que la instalanción del programa funciona correctamente.
	docker run -it ubuntu bash	# Esta Imagen es el bash de ubuntu. Es como ejecutar el mismo programa en la susodicha distribución.
	docker run openjdk		# Sí, el kit de desarrollo de Java. Se utiliza para hacer contenedores de aplicaciones Java. (También existen para Haskell y Ruby entre otros)

# Opciones

	-a, --attach

#		Liga el terminal con la salida estandar, la entrada estandar o la salida de error estandar del programa ejecutado.
#		Esta opción debe ejecutarse en modo de primer plano y es la que se utiliza por defecto.
#		No es necesario ligar las tres salidas, sino que puede elejirse que salidas se ligan.

	-i

#		Mantiene abierta la entrada estándar en el terminal aunque esta no esté abierta por la opción -a.

	-t

#		Asgina un pseudo -TTY, lo que hace que sea correcto su uso para la utilización de un shell interactivo.
#		Esta opción es incompatible con la redirección de la entrada estándar.

	--add-host=[]

#		Añade un host IP custom con el formato host:ip
#		También añade una línea a /etc/hosts.
#		Esta opción se puede usar varias veces.

	-c=X, --cpu-shares=X

#		Por defecto se utiliza la opción -c=1024.
#		El parámetro X se utiliza para repartir de manera proporcional el tiempo de CPU entre todos los contenedores cuando estos intentan utilizar más del 100%.
#		Si por ejemplo tenemos tres contenedores ejecutándose en el sistema con 512, 512 y 1024 respectivamente, el tiempo se repartirá de la siguiente forma: 25%, 25% y 50%.
#		Nota: Si se disponen de varios nucleos, el sistema repartirá el tiempo de CPU llevando en cuenta todos ellos.


	--cpu-count=X

#		Limita el número de CPUs disponibles para la ejecución de contenedores a X.
#		En Windows Server se aproxima al porcentaje de uso de la CPU.

	--cpu-percent=X

#		Limita el porcentaje de uso de CPU disponible para la ejecución de contenedores a X.

	--cpu-period=X

#		Esta opcíon se utiliza para modificar el tiempo de CPU que el planificador concede a los procesos de los contenedores.

	--cpu-rt-period=X

#		Con esta opción podemos limitar el periodo de uso de CPU a un determinado tiempo real en microsegundos.

	--dns=[]

#		Utiliza un servidor de DNS diferente al por defecto.

#		Esta opción puede ser usada para sobrescribir la configuración que se le proporciona al contenedor.
#		Normalmente esta opción es necesaria cuando la configuración DNS falla. En este caso, siempre que se ejecute algo habrá que utilizarla.

	-m, --memory=""

#		Permite añadir una restricción de memoria al contenedor con el formato <número>[<unidad>], donde unidad puede ser b, k, m o g.
#		Si el sistema soporta memoria swap, esta restricción puede ser mayor que la propia memoria física.

	--memory-reservation=""

#		Mismo formato que el anterior.
#		Al añadir este flag, si el sistema detecta que hay poca memoria restante, el sistema obliga a los contenedores a limitar su consumo a
#		lo que se les haya reservado con este comando.
#		Cuando hagamos uso de esta opción deberiamos establecer un límite por debajo del de la opción anterior (pues la anterior opción es como
#		un límite hard y esta como uno soft). Por defecto, la memoria reservada es la misma que la establecida con la opción anterior.

	--memory-swap=""

#		Establece el límite de memoria swap que puede utilizar un contenedor. Esta opción debe ser siempre utilizada con la opción -m.
#		El formato utilizado con esta opción es el mismo que el de las dos opciones anteriores, pero si no especificamos unidad se utiliza b.
#		El límite establecido debería ser mayor que el de la opción -m.
#		Por defecto se establece al doble de la opción -m.
#		Si no queremos limitar la memoria swap, utilizaremos -1 como límite.

	--name

#		Establece un nombre para el contenedor que se va a poner en ejecución

# Un contenedor ya en ejecución se puede unir a un terminal (como si hubiesemos utilizado la opción -a del run) con 
# el comando attach
#Ejemplo

	docker attach cassandra

# Opciones

	--detach-keys

#		Anula la secuencia de teclas para separarla del contenedor

	--no-stdin

#		No liga la entrada estandar

	--sig-proxy

#		Atrapa todas las señales del proceso



# Al igual que cualquier programa, los contenedores tienen sus propios sistemas de ficheros y también se pueden administrar.

# cp
# Copia ficheros entre contenedores y el sistema de ficheros local.
# Ejemplo

	docker cp 0dd182904e13:/holafichero .
	# Este comando (sabiendo que el contenedor 0dd182904e13 es una instancia del SO Ubuntu) ha copiado el fichero /holafichero del contenedor a mi directorio actual.
	# Si el fichero que se va a copiar es un directorio, este se copiará recursivamente (por lo que podemos decir que docker cp equivale al cp -a de Unix).

# Opciones

	-a, --archive 

#		Copia también los UID y GID de los ficheros.

	-L, --follow-link

#		Si en alguna de las rutas, se utiliza un enlance simbólico a un directorio, este se sigue.


# rm
# Borra contenedores que estén parados.
# Si se borran, ya no se podrán volver a activar.
# Ejemplo
	
	docker rm -f ffce1fcbf302

	# Este comando borra el contenedor (que no la imagen).
# Opciones

	-f, --force

#		Fuerza la eliminación del contenedor elegido. Para esto envía la señal SIGKILL.
#		Aunque los contenedores deben estar parados, pueden estar corriendo si usamos esta opción.

	-l, --link

#		Borra los enlaces especificados.

	-v, --volumes

#		Borra los volúmenes asociados a los contenedores


# Create
# Crea un contenedor a partir de una imagen
# Ejemplo

	docker create -it ubuntu bash

# Este comando es como utilizar docker run -d(detach, segundo plano), con la diferencia que este no se inicia
# Para iniciarlo debemos utilizar la orden docker start de la que hablaré ahora.
# La orden create tiene gran cantidad de opciones, pero estas están todas 
# incluidas (o al menos no he visto ninguna que no lo estuviese) en la orden run, por lo que considero innecesario abordarlas de nuevo.

# Start
# Activa contenedores que están parados.
# Pueden ser contenedores que se les haya detenido desde fuera.
# También pueden ser contenedores que se hayan creado pero no se hayan puesto en marcha.
# Ejemplo

	docker start -a -i 6020b75cbd61

# Opciones

	-a, --attach # Igual que en el comando run

	--detach-keys # Igual que en el comando attach

	-i, --interactive # Une el terminal con la entrada estándar del contenedor

# Stop
# Para contenedores que estén en marcha
# Tras un periodo de tiempo de gracia, los mata (desconozco
#Ejemplo

	docker stop 70d8bf22abb5

# Opciones

	-t, --time # Tiempo en segundos que se espera hasta matar a los contedores.
	# Si no se especifica el tiempo que acompaña a esta opción son diez segundos.
	# Desconozco el tiempo que se espera por defecto si no se usa esta opción (creo que infinito, pero no puedo asegurarlo).



# Pause
# Suspende todos los procesos de un contenedor
#Ejemplo	

	docker pause 2d97a9c94feb

# Opciones
# No hay

# Unpause
# Es el comando opuesto a pause. Reanuda todos los procesos parados en un contenedor

	docker unpause 2d97a9c94feb

# Opciones
# No hay

# Events
# Muestra todos los eventos correspondientes a TODOS los contenedores.
# Los eventos se muestran en tiempo real. Este comando es interesante para monitorizar los contenedores.
# Ejemplo

	docker events

# Opciones

	--format # Podemos utilizar una plantilla Go para formatear la salida.
	
	--since # Solo muestra eventos ocurridos desde la marca de tiempo que se le proporcione.
	
	--until # Solo muestra eventos ocurridos antes de la marca de tiempo proporcionada.

	-f, --filter # Filtra la salida según las condiciones proporcionadas
			# De todos los comandos con filtro, este es el más complejo y completo.
			# Una aclaración, si se pone más de un tipo de filtro igual (por ejemplo, dos ID), la condición se evaluará como OR.
			# Si se ponen varios filtros de tipos diferentes, su condición se evalua como AND
			# Posibles filtros:
			#	config, container,daemon, event, image, label, network, node, plugin, scope, secret, service, type y volume



# kill
# Mata un contenedor. El proceso principal del mismo recibe, por defecto, la señal SIGKILL.
# Ejemplo

	docker kill boring_meninsky

# Opciones

	-s, --signal # Se envía la señal especificada en lugar de SIGKILL

# Exec
# Ejecuta un comando dentro de un contenedor.
# El comando utilizado solo estará activo mientras el proceso principal del contenedor lo esté.
# El comando no se reiniciará si el contenedor es reiniciado.
# Por defecto se utilizará el directorio del contenedor.
# Si la imagen subyacente tiene especificado un directorio diferente, se usará este en su lugar. 
# El comando deberá ser ejecutable.
# Ejemplo

	docker exec -d boring_meninsky touch /home/hola/mundo

# Opciones

	-d, --detach # Ejecutar en segundo plano con respecto a este terminal
	-i, --interactive # Mantiene la entrada estándar abierta aunque no se haya ligado
	--privileged # Da privilegios extendidos al comando
	-t, --tty # Establece un pseudo-tty
	-u, --user # UID


# Export
# Exporta el contenido del sistema de ficheros de un contenedor como un fichero tar
# Este comando es interesante para la realización de copias de seguridad
# No funciona con volúmenes
# Ejemplo

	docker export kind_mcclintock > comprimido.tar

# Opciones

	-o, --output # Mete la salida en el fichero especificado en vez de en la salida estándar
	#Viendo esto se puede decir que utilza la sintaxis de cpio	


# Import
# Importa el contenido de fichero comprimido para crear el sistema de ficheros de una imagen
# No le termino de ver mucho la utilidad, ni siquiera he podido probarlo sin errores.
# Ejemplo

	docker import http://example.com/exampleimage.tgz

# Opciones

	-c, --change # Utiliza las instrucciones del Dockerfile (ya se hablará de él) para crear la imagen
	-m, --message # Establece un mensaje de confirmación para la imagen importada

# History
# Muestra el historial de una imagen
# La salida tiene los siguientes campos:
	# ID . ID de la imagen
	# CreatedSince. Intervalo de tiempo que ha pasado desde que se creó la imagen
	# CreatedAt. Cuando se creó la imagen
	# CreatedBy. Comando utilizado para crear la imagen
	# Size. Tamaño que ocupa la imagen en disco
	# Comment. Comentario de la imagen
# Ejemplo

	docker history debian

# Opciones

	--format # Utiliza una platilla Go para dibujar la salida
	-H, --human # Los datos numéricos se muestran en un formato legible
	--no-trunc # No trunca la salida
	-q, --quit # Solo muestra IDs numericos


# Info
# Muestra información sobre el sistema y la instalación de Docker.
# Muestra información tal como la versión del kernel o el número de contenedores e imágenes (únicas)
# Ejemplo

	docker info

# Opciones

	-f, --format # Puedes proporcionarle una plantilla Go para que la salida se adapte a esta


# Inspect
# Muestra información de bajo de nivel del objeto (imagenes, contenedores, volumenes, etc) analizado.
# La información suele mostrarse utilizando un array JSON

	docker inspect inspiring_johnson

# Opciones

	-f, --format # Puedes proporcionarle una plantilla Go para que la salida se adapte a esta
#		Esta opción puede ser interesante, pues la salida suele generar una gran cantidad de datos y puedes omitir información con ella.
	-s, --size # Si el objeto es un contenedor, se muestra el tamaño total de sus ficheros

# Save
# Guarda una imagen en un archivo .tar
# La salida la produce por la salida estándar
# Ejemplo

	docker save hello-world > imagen.tar
	
# Opciones
	
	-o, --output # Manda la salida a un fichero


# Load
# Carga una imagen de un archivo .tar o de la entrada estándar

	docker load < archivo.tar

# Opciones 

	-i, --input # Lee de un fichero en lugar de la entrada estandar
	-q, --quiet # No muestra salida, se calla


# Login
# Este comando se utiliza para conectarse a un "registry", que bien puede ser local o puede estar alojada en otro sitio.

	docker login localhost:8080

# Opciones

	-p, --password # Contraseña en el siguiente campo (NO RECOMENDABLE)
	--password-stdin # Lee la contraseña de la entrada estándar
	-u, --username # Usuario en el siguiente campo
# NOTE no se si debería profundizar un poco más en este comando. Veo un poco complicado todo lo relativo a almacenamiento de contraseñas
# https://docs.docker.com/engine/reference/commandline/login/

# Logout
# Te desconecta de un registry

	docker logout localhost:8080



# Logs  FIXME
# No termino de entender este comando
# Muestra las últimas salidas del contenedor seleccionado.
# Con la opción --follow se queda imprimiendo las salidas del contenedor
https://docs.docker.com/engine/reference/commandline/logs/


# Port
# Muestra los puertos en los que está utilizando un contenedor.
# Estos puertos no están separados de los de la máquina real.
# Ejemplo:

	# Ejemplo con la imagen de la documentacion de Docker
	docker run -it -p 4000:4000 docs/docker.github.io:latest
	docker port jovial_yallow
	# Mostrará que está usando el puerto 4000

# Ps
# Lista los contenedores
# Ejemplo

	docker ps
	docker ps -a --filter status=running #Ejemplo redundante, pero muy bueno para esto

# Opciones
	-a, --all # Muestra todos los contenedores, ya que por defecto solo muestra los que están corriendo
	-s, --size # Muestra el tamaño de los ficheros del contenedor
	-q, --quiet # Solo muestra los IDs de los contenedores
	--no-trunc # No recorta el tamaño de la salida
	-n X, --last X # Muestra sólo los X últimos contenedores creados
	--latest, -l # Muestra sólo el último contenedor creado. Si no me equivoco, equivale a "-n 1"
	--format # Usando una plantilla Go, podemos formatear la salida
	-f, --filter # Con esta opción, podemos añadir condiciones. En la salida solo se mostrarán los contenedores que las cumplan.
		# Las condiciones que podemos poner pueden abarcar cosas como el id, el nombre o las networks que utilizan.

# Rename
# Cambia el nombre de un contenedor
# Ejemplo

	docker rename ecstatic_ptolemy nombre_nuevo #Ahora el contenedor se llama nombre_nuevo

# Restart
# Reinicia o relanza un contenedor.
# Este comando puede ser interesante si un contenedor da problemas.
# Este comando no afecta al espacio de memoria de un contenedor, por lo que no se pierden cambios.
# Ejemplo

	docker restart nombre_nuevo
	
# Opciones

	-t X, --time X # FIXME 
		       # Solo tiene esta opción, pero no termino de entender el uso
		       # Literalmente: Seconds to wait for stop before killing the container
		        https://docs.docker.com/engine/reference/commandline/restart/

# Rmi
# Elimina una imagen.
# Ejemplo

	docker rmi hello-world

# Opciones

	-f, --force # Si una imagen tiene varias etiquetas, si no usamos esta opción, borramos solo la etiqueta seleccionada.
		# Si por el contrario utilizamos esta opción Y el ID de la imagen, borramos todas las etiquetas también
	--no-prune # No elimina los padres sin etiquetar
			# NOTE Do not delete untagged parents. No termino de entender esto, creo que todo tiene alguna etiqueta


# Tag
# A veces trabajamos con varias versiones de la misma imagen.
# Para diferenciar estas diferentes versiones, recurrimos a las etiquetas.
# Así, este comando añade una etiqueta a una version de una imagen.
# La versión se puede especificar con Image:Version pero si no se especifica, se utiliza la versión "latest"
# Ejemplo:

	docker tag hello-world version1
	

# Search
# Este comando se utiliza para buscar imágenes en la Docker Store.
# Ejemplo

	docker search database

# Opciones (Algunas están obsoletas, por lo que no las voy a comentar)

	-f, --filter # Igual que con el comando ps, aquí también podemos añadir filtros a la salida.
		 # Estos filtros pueden ser, el número mínimo de estrellas, si la imagen es oficial y si está automatizada.

	--format # Podemos formatear la salida utilizando una plantilla Go.
	
	--limit X # Limita la salida a las X imágenes con más estrellas (starred).
	
	--no-trunc # No recorta la salida.
	

# Stats
# Muestra en tiempo real las estadísticas de consumo de un contenedor.
# Ejemplo

	docker stats cont
	
# Opciones

	-a, --all # Muestra la información de todos los contenedores (sin esta opción, solo los que están corriendo).
	
	--format # Como siempre, podemos formatear la salida utilizando una plantilla Go.
	
	--no-stream # No monitoriza los contenedores, solo muestra la primera impresión de datos.
	
	--no-trunc # No recorta la salida.


# Top
# Muestra los procesos que se estén ejecutando dentro de un contenedor
# Ejemplo

	docker top cont

# Opciones
# Las del comando ps (que no docker ps).


# Update
# Actualiza la configuración de un contenedor
# Ejemplo

	docker update --cpus 1 cont
	
# Opciones (muestro sólo unas cuantas que son interesantes)


	--cpu-period # Modifica el tiempo de CPU que el planificador concede a los procesos de los contenedores.

	--cpu-quota # Modifica el porcentaje de tiempo de CPU que el planificador concede a los procesos contenedores.

	--cpus # Limita el número de CPUs que puede utilizar el contenedor

	-m, --memory # Limita la memoria que puede usar el contenedor
	
	--memory-reservation # Cuando se detecta que queda poca memoria restante
		#	       el sistema obliga a los contenedores a utilizar como mucho esta cantidad de memoria.
		# 	       Evidentemente, esta debe ser menor que la memoria límite.
		
	--memory-swap # Establece el limite de memoria swap que puede utilizar un contenedor


# Version
# Muestra la información sobre la versión del sistema Docker
# Ejemplo

	docker version
	
# Opciones

	-f, --format # Podemos formatear la salida con una plantilla Go

# Wait
# Bloquea la terminal hasta que el contenedor (o contenedores) seleccionados terminen.
# Cuando se pare la ejecución del contenedor seleccionado, el terminal mostrará el código de salida y se desbloqueará.
# Ejemplo

	docker wait cont


# Images
# Lista las imágenes
# Ejemplo

	docker images
	
# Opciones

	-a, --all # Muestra todas las imágenes (incluyendo las intermedias).
	
	--digest # Muestra una columna extra llamada digest, no sé lo que es, pues es un código raro.

	--format # Se puede formatear la salida con una plantilla Go, como siempre.
	
	-q, --quiet # Solo muestra los IDs númericos de las imágenes.
	
	--no-trunc # No recorta la salida.
	
	-f, --filter # Como es habitual en este tipo de comandos, podemos filtrar la salida.
			# Las condiciones de filtrado en esta ocasión abarcan campos como la etiqueta o cuando fueron creadas.


# Pull
# Descarga una imagen o repositorio de un registry
# Ejemplo

	docker pull hello-world
	
# Opciones

	-a, --all # Si hay varias etiquetas de la imagen, se las descarga todas.
	
	--disable-content-trust # No verifica el contenido de la imagen.


# BIBLIOGRAFÍA ACTUAL

https://docs.docker.com/get-started/#containers-and-virtual-machines
https://docs.docker.com/engine/docker-overview/#the-docker-daemon
https://medium.freecodecamp.org/an-introduction-to-docker-tags-9b5395636c2a
https://docs.docker.com/storage/
https://docs.docker.com/storage/volumes/#choose-the--v-or---mount-flag
https://docs.docker.com/storage/bind-mounts/
https://docs.docker.com/storage/tmpfs/
https://docs.docker.com/engine/reference/commandline/docker/ # Esta página y sus enlaces





