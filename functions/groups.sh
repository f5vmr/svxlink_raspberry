#/bin/bash
function make_groups {
   echo $(date) ${YELLOW} Creating Groups and Users ${NORMAL} | tee /var/log/install.log
	sudo mkdir /etc/svxlink
    sudo groupadd svxlink
	sudo useradd -g svxlink -d /etc/svxlink svxlink
	sudo usermod -aG audio,nogroup,svxlink,plugdev svxlink
	
}
	