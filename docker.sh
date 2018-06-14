#!/usr/bin/bash

#Marca (no incluir en el script final)

pvcreate /dev/sdb /dev/sdc /dev/sdd
vgextend fedora /dev/sdb /dev/sdc /dev/sdd
lvextend -L +2.98G /dev/fedora/root
resize2fs /dev/fedora/root

dnf clean all

#Marca

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
