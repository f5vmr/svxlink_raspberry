#!/bin/bash
# Installation automatique du logicel SVXlink
CONF=/etc/svxlink/svxlink.conf
GPIO=/etc/svxlink/gpio.conf
HOME=/home/pi/
OP=/etc/svxlink/
FLAG=.makescript
cd
sudo apt update
sudo apt upgrade -y
VERSIONS=svxlink/src/versions

if [ ! -f $FLAG ]; then
	echo `date` *** commence build ***
# Installing other packages
	echo `date` Installation des logiciels necessaires …
	sudo apt install g++ make cmake libsigc++-2.0-dev php8.0 libgsm1-dev libudev-dev libpopt-dev tcl-dev libgpiod-dev gpiod libgcrypt20-dev libspeex-dev libasound2-dev alsa-utils libjsoncpp-dev libopus-dev rtl-sdr libcurl4-openssl-dev libogg-dev librtlsdr-dev groff doxygen graphviz python3-serial toilet -y
        
	echo -n “Tapez l'indicactif du noeud : \n“
	
	read CallVar
	if [ “$CallVar” == “” ]; then
		echo “Désolé - Redemarré avec un indicatif valid ”
		exit 1
	fi
	CALL=${CallVar^^}
	echo `date` Creation du noeud $CALL
# Creating Groups and Users
	echo `date` Creating Groups and Users 
	sudo groupadd svxlink
	sudo useradd -g svxlink -d /etc/svxlink svxlink
	sudo usermod -aG audio,nogroup,svxlink,plugdev svxlink
	sudo usermod -aG gpio svxlink


# Downloading Source Code for SVXLink
	echo `date` téléchargement SVXLink source code …
	cd
	sudo git clone https://github.com/sm0svx/svxlink.git
	sudo mkdir svxlink/src/build
	fi
# Updating from repo and building software
#	echo `date` Updating from repo and building software …
#       cd
#	cd svxlink
#	VERSION=`sudo grep “SVXLINK=“ $VERSIONS | awk -F= '{print $2}'`
#	echo `date` Current Version: $VERSION
#	#
#	sudo git pull
#		if [ “$?” != 0 ]; then
#			echo `date` git pull request failed, aborting!
#			exit 1
#	fi
	NEWVERSION=`sudo grep “SVXLINK=“ $VERSIONS | awk -F= '{print $2}'`
	echo `date` New Version: $NEWVERSION
# Compilation
	cd
	cd svxlink/src/build
	sudo cmake -DUSE_QT=OFF -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc \ -DLOCAL_STATE_DIR=/var -DWITH_SYSTEMD=ON  ..
	sudo make
	sudo make doc
	echo `date` Installing SVXlink
	sudo make install
	cd /usr/share/svxlink/events.d
	sudo mkdir local
	sudo cp * local
	sudo ldconfig
# if [ ! -F $FLAG ]; then
	# Installation de la langue Française
	cd /usr/share/svxlink/sounds
	sudo wget https://g4nab.co.uk/wp-content/uploads/2022/11/fr_FR.tar.gz
	sudo tar -zxvf fr_FR.tar.gz
	sudo rm fr_FR.tar.gz

echo `date` backing up configuration to : $CONF.bak
	cd $OP
	sudo cp -p $CONF $CONF.bak
#
	cd
	echo `date` Downloading prepared configuration files from source …
	sudo cp -r svxlink_raspberry/svxlink.conf $CONF
	sudo cp -r svxlink_raspberry/gpio.conf $GPIO
#	sudo cp -r svxlink_raspberry/10-uname /etc/update-motd.d/
#
	echo `date` Setting Callsign to $CALL
	sudo sed -i "s/MYCALL/$CALL/g" $CONF
#
        echo 'date' Setting Language to French
	sudo sed -i "s/DEFAULT_LANG=en_GB/DEFAULT_LANG=fr_FR/g" $CONF
#
 	echo 'date' setting server to RRF
	sudo sed -i "s/HOSTS=svxportal-uk.ddns.net/docs.rrf.ovh/g" $CONF
	sudo sed -i "s/AUTH_KEY=\"ToBeChanged\"/AUTH_KEY=\"Magnifique123456789!\"/g" $CONF
	sudo sed -i "s/HOST_PORT=5300/HOST_PORT=5399/g" $CONF
	sudo sed -i "s/MONITOR_TGS=235,350,2351,23520,23590,23561/MONITOR_TGS=97,98,99,100,101,102/g" $CONF
	
#	echo `date` Setting Squelch Hangtime to 10
	sudo sed -i "s/SQL_HANGTIME=2000/SQL_HANGTIME=10/g" $CONF
#	
	echo `date` Disabling audio distortion warning messages
	sudo sed -i "s/PEAK_METER=1/PEAK_METER=0/g" $CONF
#
	echo `date` Updating SplashScreen on startup
#	sudo sed -i "s/MYCALL/$CALL/g" /etc/update-motd.d/10-uname
#	sudo chmod 0755 /etc/update-motd.d/10-uname
#	
	echo `date` enabling GPIO setup service and svxlink service …
	sudo systemctl enable svxlink_gpio_setup
	sleep 10
	sudo systemctl enable svxlink
	sleep 10
	sudo systemctl start svxlink_gpio_setup.service
	sleep 10
	sudo systemctl start svxlink.service
#fi
touch $FLAG
echo `date` Installation complete
echo `date` Reboot SVXLink
echo
sudo reboot

	
 
