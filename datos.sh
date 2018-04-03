# Cuando vaya a hablar de como hacer tu propio docker, hablaré sobre el comando build


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


# Para ejecutar cualquier imagen se utiliza el comando "docker run Imagen"
# Este comando comprueba las librerias que utiliza la Imagen. En caso de que falte alguna, la descargará del repositorio (como si utilizara docker pull)
# Ejemplos
	docker run hello-world		# Esta Imagen suele ejecutarse para comprobar que la instalanción del programa funciona correctamente.
	docker run -it ubuntu bash	# Esta Imagen es el bash de ubuntu. Es como ejecutar el mismo programa en la susodicha distribución.
	docker run openjdk		# Sí, el kit de desarrollo de Java. Se utiliza para hacer contenedores de aplicaciones Java. (También existen para Haskell y Ruby entre otros)

# Opciones

	-a, --attach

#		Liga el terminal con la salida estandar, la entrada estandar o la salida de error estandar del programa ejecutado
#		Esta opción debe ejecutarse en modo de primer plano y es la que se utiliza por defecto.
#		No es necesario ligar las tres salidas, sino que puede elejirse que salidas se ligan.

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






Ahora paso de todo y no 
