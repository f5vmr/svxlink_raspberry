#!/bin/bash
function make_groups {
   echo -e "$(date)" "${YELLOW} Création de Groups et Users ${NORMAL}" | tee -a  /etc/svxlink/install.log
	sudo mkdir /etc/svxlink
    sudo groupadd svxlink
	sudo useradd -g svxlink -d /etc/svxlink svxlink
	sudo usermod -aG audio,nogroup,svxlink,plugdev svxlink
	
}
	