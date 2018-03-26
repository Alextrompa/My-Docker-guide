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
	docker run hello-world		# Esta Imagen suele ejecutarse para comprpobar que la instalanción del programa funciona correctamente.
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
