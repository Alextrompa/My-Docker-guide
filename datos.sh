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

	
