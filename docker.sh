#!/usr/bin/bash
#Shell instalador de docker en Fedora

dnf update

dnf -y install dnf-plugins-core

dnf config-manager \
	--add-repo \
	https://download.docker.com/linux/fedora/docker-ce.repo
    
dnf install docker-ce

#Hacemos que se inicie siempre al arrancar la máquina
systemctl enable docker

#A partir de aquí iniciamos y probamos el docker con el hola mundo
systemctl start docker

docker run hello-world
