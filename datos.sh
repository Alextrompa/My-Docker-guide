# Cuando vaya a hablar de como hacer tu propio docker, hablaré sobre el comando build
# Comandos de los que no voy a hablar porque creo que no merece la pena: commit, container, push, pull, diff, help, image


#Una primera tarea que podriamos llevar a cabo con docker es activarlo para que se inicie durante el arranque. Para esto usamos:

	sudo systemctl enable docker

	# Si esto no nos gusta y queremos desactivar esto

	sudo systemctl disable docker


#Existen dos versiones de Docker
	# Docker CE (Comunity Edition) totalmente gratuita
	# Docker EE (Enterprise Edition), de pago y con más características


#Imagenes de las distintas aplicaciones
#	https://store.docker.com/search?source=verified&type=image


# Dos conceptos, Imagen y Contenedor

#	Imagen:		Instrucciones para crear un contenedor. Estas son solo de lectura.
#	Contenedor:	Es una instancia ejecutable de una imagen. Se pueden crear, poner
#			en marcha, parar, mover o borrar. Incluso se puede crear una
#			Imagen a partir del estado actual de un contenedor.

# Otro concepto, Volumen. NOTE Explicar que es.
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
# Borra contenedores
# Ejemplo
	
	docker rm -f ffce1fcbf302

	# Este comando borra el contenedor (que no la imagen), por lo que se puede relanzar cuantas veces se quiera
	# No puedo observar diferencia entre este comando y el kill.
# Opciones

	-f, --force

#		Fuerza la eliminación del contenedor elegido. Para esto envía la señal SIGKILL.

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


# Events NOTE esté sin acabar porque es muy largo y tiene muchos puntos
# Muestra todos los eventos correspondientes a TODOS los contenedores.
# Los eventos se muestran en tiempo real. Este comando es interesante para monitorizar los contenedores.
# Ejemplo

	docker events

# Opciones

	-f, --filter # Filtra la salida según las condiciones proporcionadas
			# Posibles filtros



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



# inspect
# load
# login
# logout
# logs
# network
# node
# plugin
# port
# ps
# rename
# restart
# rmi
# save
# search
# secret
# service
# stack
# stats
# swarm
# system
# tag
# top
# update
# version
# volume
# wait







