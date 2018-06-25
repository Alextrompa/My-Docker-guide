#!/usr/bin/bash

#Marca (no incluir en el script final)

pvcreate /dev/sdb /dev/sdc /dev/sdd
vgextend fedora /dev/sdb /dev/sdc /dev/sdd
lvextend -L +2.98G /dev/fedora/root
resize2fs /dev/fedora/root

dnf clean all

wget http://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo

dnf -y install VirtualBox-5.1

/usr/lib/virtualbox/vboxdrv.sh setup

#Marca

#Shell instalador de docker en Fedora

dnf -y update

dnf -y upgrade

dnf -y install dnf-plugins-core

dnf config-manager \
	--add-repo \
	https://download.docker.com/linux/fedora/docker-ce.repo
    
dnf -y install docker-ce

#Vamos a instalar docker compose, una herramienta de Docker
curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version

#Instalamos docker-machine, otra herramienta

base=https://github.com/docker/machine/releases/download/v0.14.0 &&
  curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine

docker-machine version

#Hacemos que se inicie siempre al arrancar la máquina
systemctl enable docker

#A partir de aquí iniciamos y probamos el docker con el hola mundo
systemctl start docker

docker run hello-world
