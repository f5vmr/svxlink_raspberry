#!/bin/bash
# Auto run audio_update.sh
export LANGUAGE=fr_FR.UTF-8
VERT="\033[1;32m"
NORMAL="\033[1;39m"
ROUGE="\033[1;31m"
JAUNE="\033[1;33m"
sudo bash /home/pi/svxlink_raspberry/audio_update.sh
#
# Installation automatique du logicel SVXlink
#

CONF=/etc/svxlink/svxlink.conf
GPIO=/etc/svxlink/gpio.conf
HOME=/home/pi/
OP=/etc/svxlink/
cd
sudo curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt update
sudo apt upgrade -y
VERSIONS=svxlink/src/versions

	echo -e `date` "${JAUNE} *** Installation automatique du logicel SVXlink ***${NORMAL}"
	
# Installing other packages
	echo -e `date` "${JAUNE} Installation des logiciels nécessaires${NORMAL}"
	sudo apt install nodejs build-essential g++ make cmake libsigc++-2.0-dev php8.0 libgsm1-dev libudev-dev libpopt-dev tcl-dev libgpiod-dev gpiod libgcrypt20-dev libspeex-dev libasound2-dev alsa-utils libjsoncpp-dev libopus-dev rtl-sdr libcurl4-openssl-dev libogg-dev librtlsdr-dev groff doxygen graphviz python3-serial toilet -y
	echo
	echo -n “Tapez l\'indicactif du noeud : \n“
	echo
	read CallVar
	if [ “$CallVar” == “” ]; then
		echo “Désolé - Redemarré avec un indicatif valid ”
		exit 1
	fi
	CALL=${CallVar}
	echo
	echo `date` Création du noeud $CALL
# Creating Groups and Users
	echo -e `date` "${JAUNE} Création des Groupes et des Utilisateurs ${NORMAL}"
	sudo groupadd svxlink
	sudo useradd -g svxlink -d /etc/svxlink svxlink
	sudo usermod -aG audio,nogroup,svxlink,plugdev svxlink
	sudo usermod -aG gpio svxlink
	

# Downloading Source Code for SVXLink
	echo -e `date` "${JAUNE} Téléchargement du code source de svxlink${NORMAL}"
	cd
	sudo git clone https://github.com/sm0svx/svxlink.git
	sudo mkdir svxlink/src/build
	

	NEWVERSION=`sudo echo "$VERSIONS" | grep "SVXLINK=" | awk -F= '{print $2}'`
	echo `date` New Version: $NEWVERSION
# Compilation
	cd
	cd svxlink/src/build
	sudo cmake -DUSE_QT=OFF -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc \ -DLOCAL_STATE_DIR=/var -DWITH_SYSTEMD=ON  ..
	sudo make
	sudo make doc
	echo `date` Installation SVXlink
	sudo make install
	cd /usr/share/svxlink/events.d
	sudo mkdir local
	sudo cp *.tcl ./local
	sudo ldconfig
	# Installation des dossiers français
	cd /usr/share/svxlink/sounds
	sudo wget https://g4nab.co.uk/wp-content/uploads/2022/11/fr_FR.tar.gz
	sudo tar -zxvf fr_FR.tar.gz
	sudo rm fr_FR.tar.gz
	sudo chmod 777 *
	echo `date` back-up configuration à : $CONF.bak
	cd $OP
	sudo mv $CONF $CONF.bak
	#
	cd $HOME
	echo -e `date` "${ROUGE} Téléchargement des dossiers config${NORMAL}"
	sudo mkdir /home/pi/scripts
	sudo cp -r svxlink_raspberry/svxlink.conf.fr $CONF
	sudo cp -r svxlink_raspberry/gpio.conf $GPIO
	sudo cp -r svxlink_raspberry/node_info.json $OP/node_info.json
 	sudo cp -r svxlink_raspberry/resetlog.sh /home/pi/scripts/resetlog.sh
	(crontab -l 2>/dev/null; echo "59 23 * * * /home/pi scripts/resetlog.sh ") | crontab -
#
	echo `date` Setting Callsign to $CALL
	sudo sed -i "s/MYCALL/$CALL/g" $CONF
	sudo sed -i "s/MYCALL/$CALL/g" $OP/node_info.json

	sudo sed -i "s/DEFAULT_LANG=en_GB/DEFAULT_LANG=fr_FR/g" $CONF
#
	echo `date` Setting Squelch Hangtime to 10
	sudo sed -i "s/SQL_HANGTIME=2000/SQL_HANGTIME=10/g" $CONF
#
	echo `date` Disabling audio distorsion warning messages
	sudo sed -i "s/PEAK_METER=1/PEAK_METER=0/g" $CONF
 	echo `date` Setting svxlink log file
	sudo sed -i "/LOGFILE=/ s/$/.log/" /etc/default/svxlink
	if [$card=true]
	then
	sudo sed -i "/PTT_TYPE/iHID_DEVICE=\/dev\/hidraw0" $CONF
	sudo sed -i "s/PTT_TYPE=GPIO/PTT_TYPE=Hidraw/g" $CONF
	sudo sed -i "s/PTT_PORT=GPIO/PTT_PORT=\/dev\/hidraw0/g" $CONF
	sudo sed -i "s/PTT_PIN=gpio24/HID_PTT_PIN=GPIO3/g" $CONF
	sudo sed -i "s/\#MUTE/MUTE/g" /etc/svxlink/svxlink.d/ModuleEchoLink.conf
	sudo sed -i "s/\#DEFAULT_LANG=en_US/DEFAULT_LANG=en_GB/g" /etc/svxlink/svxlink.d/ModuleEchoLink.conf
	sudo sed -i "s/\#MUTE/MUTE/g" /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
	sudo sed -i "s/\#DEFAULT_LANG=en_US/DEFAULT_LANG=en_GB/g" /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
	
	fi
	echo `date` "${ROUGE} Authorise GPIO setup service and svxlink service${NORMAL}"
	sudo systemctl enable svxlink_gpio_setup
	sleep 10
	sudo systemctl enable svxlink
	sleep 10
	sudo systemctl start svxlink_gpio_setup.service
	sleep 10
	sudo systemctl start svxlink.service


echo -e `date` "${ROUGE}Installation complete\n${NORMAL}"
echo -e `date` "${VERT} Reboot - Redémarrer SVXLink\n\n\n${NORMAL}"
echo
sleep 10

sudo reboot

