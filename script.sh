#Shell instalador de docker en Fedora

dnf -y update

dnf -y upgrade

dnf config-manager \
	--add-repo \
	https://download.docker.com/linux/fedora/docker-ce.repo
    
dnf -y install docker-ce

systemctl start docker
