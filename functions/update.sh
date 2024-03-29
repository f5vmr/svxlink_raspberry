#!/bin/bash
function update {
CONF="/etc/svxlink/svxlink.conf"
GPIO="/etc/svxlink/gpio.conf"
OP=/etc/svxlink

whiptail --title "Updating" --msgbox "Uprating repositories for nodejs and future expansion. Hit OK to continue" 8 78

	echo -e `date` " ${YELLOW}  *** updates and upgrades *** ${NORMAL}"
#	sudo apt-get update
#	sudo apt-get install -y ca-certificates curl gnupg
#	sudo mkdir -p /etc/apt/keyrings
#	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
#	NODE_MAJOR=20
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

#	sudo apt update
#	sudo apt upgrade -y
	VERSIONS=svxlink/src/versions

	echo -e `date` " ${YELLOW}  *** commence build *** ${NORMAL}"
############ BUILD ESSENTIALS ##########
whiptail --title "Build Essentials" --msgbox "Adding all the packages necessary for Svxlink. Hit OK to continue" 8 78

	echo -e `date` " ${YELLOW} Installing required software packages${NORMAL}"
#	sudo apt install build-essential g++ make cmake libsigc++-2.0-dev php8.2 nodejs libgsm1-dev libudev-dev libpopt-dev tcl-dev libgpiod-dev gpiod libgcrypt20-dev libspeex-dev libasound2-dev alsa-utils libjsoncpp-dev libopus-dev rtl-sdr libcurl4-openssl-dev libogg-dev librtlsdr-dev groff doxygen graphviz python3-serial toilet -y

}