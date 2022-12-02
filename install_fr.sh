#!/bin/bash
export LANGUAGE=fr_FR.UTF-8
VERT="\\033[32m"
NORMAL="\\033[39m"
ROUGE="\\033[31m"
JAUNE="\\033[33m"

#
# Installation automatique du logicel SVXlink
#

# Automatic exit from Bash shell script on error
set -e

CONF=/etc/svxlink/svxlink.conf
GPIO=/etc/svxlink/gpio.conf
HOME=/home/pi/
OP=/etc/svxlink/
FLAG=.makescript
cd $HOME
echo `pwd`

while true; do
	echo -e "${JAUNE}Update & Upgrade Raspberry Pi OS${NORMAL}"
	read -p "Do you want to proceed? (y/N) " yn
	case $yn in
		[Yy] ) echo ok, we will proceed;
		sudo apt update
		sudo apt upgrade -y
		sudo sync
		sudo reboot
		break;;
	* ) break;;
	esac
done

if [ ! -f $FLAG ]; then
	echo -e "${JAUNE}Installation automatique du logicel SVXlink${NORMAL}"
	echo `date` *** commence le build ***

# Installing other packages
	echo -e "${JAUNE}Installation des logiciels nécessaires${NORMAL}"
	echo `date` Installing required software packages …
	sudo apt install g++ make cmake libsigc++-2.0-dev php8.0 libgsm1-dev libudev-dev libpopt-dev tcl-dev libgpiod-dev gpiod libgcrypt20-dev libspeex-dev libasound2-dev alsa-utils libjsoncpp-dev libopus-dev rtl-sdr libcurl4-openssl-dev libogg-dev librtlsdr-dev groff doxygen graphviz python3-serial toilet -y

	echo -n “Tapez l\'indicactif du noeud : \n“

	read CallVar
	if [ “$CallVar” == “” ]; then
		echo “Désolé - Redemarré avec un indicatif valid ”
		exit 1
	fi
	CALL=${CallVar}
	echo `date` Création du noeud $CALL

# Creating Groups and Users
	echo -e "${JAUNE}Création des Groupes et des Utilisateurs${NORMAL}"
	echo `date` Creating Groups and Users 
	if [ ! $(getent group svxlink) ]; then
	sudo groupadd svxlink
	sudo useradd -g svxlink -d /etc/svxlink svxlink
	sudo usermod -aG audio,nogroup,svxlink,plugdev svxlink
	sudo usermod -aG gpio svxlink
	fi

# Downloading Source Code for SVXLink
	echo -e "${JAUNE}Téléchargement du code source de svxlink${NORMAL}"
	echo `date` Load SVXLink source code …

	DIR=${HOME}svxlink
	echo $DIR
	if [ ! -d "$DIR" ]; then
  	# Take action if $DIR exists. #
  	echo "Installing SVXLink in ${DIR}..."
	sudo apt install git -y
	sudo git clone https://github.com/sm0svx/svxlink.git
	sudo mkdir svxlink/src/build
	fi

	VERSIONS=`sudo cat svxlink/src/versions`
#	NEWVERSION=`sudo grep “SVXLINK=“ $VERSIONS | awk -F= '{print $2}'`
	NEWVERSION=`sudo echo "$VERSIONS" | grep "SVXLINK=" | awk -F= '{print $2}'`
	echo `date` New Version: $NEWVERSION

# Compilation
	echo -e "${JAUNE}Compilation${NORMAL}"
	FILE=svxlink/src/build/make_output
	if [ ! -f "$FILE" ]; then
	cd svxlink/src/build
	sudo cmake -DUSE_QT=OFF -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc \ -DLOCAL_STATE_DIR=/var -DWITH_SYSTEMD=ON  ..
	sudo make | tee make_output
	sudo make doc
	echo `date` Installing SVXlink
	sudo make install
	cd /usr/share/svxlink/events.d
	sudo mkdir local
	sudo cp *.tcl ./local
	sudo ldconfig
	fi

	echo -e "${JAUNE}Installation de la langue Française${NORMAL}"
	# Installing French Sound files
	cd /usr/share/svxlink/sounds
	sudo wget https://g4nab.co.uk/wp-content/uploads/2022/11/fr_FR.tar.gz
	sudo tar -zxvf fr_FR.tar.gz
	sudo rm fr_FR.tar.gz
	sudo chmod 777 *
	fi

	echo `date` backing up configuration to : $CONF.bak
	cd $OP
	sudo cp -p $CONF $CONF.bak
#
	echo `date` Setting Callsign to $CALL
	sudo sed -i "s/MYCALL/$CALL/g" $CONF
#
        echo `date` Setting Language to French
	sudo sed -i "s/DEFAULT_LANG=en_GB/DEFAULT_LANG=fr_FR/g" $CONF
#
 	echo `date` setting server to RRF
	sudo sed -i "s/HOSTS=svxportal-uk.ddns.net/docs.rrf.ovh/g" $CONF
	sudo sed -i "s/AUTH_KEY=\"ToBeChanged\"/AUTH_KEY=\"Magnifique123456789!\"/g" $CONF
	sudo sed -i "s/HOST_PORT=5300/HOST_PORT=5399/g" $CONF
	sudo sed -i "s/MONITOR_TGS=235,350,2351,23520,23590,23561/MONITOR_TGS=97,98,99,100,101,102/g" $CONF

	echo `date` Setting Squelch Hangtime to 10
	sudo sed -i "s/SQL_HANGTIME=2000/SQL_HANGTIME=10/g" $CONF
#
	echo `date` Disabling audio distorsion warning messages
	sudo sed -i "s/PEAK_METER=1/PEAK_METER=0/g" $CONF
#
        echo `date` Add ReflectorLogic in LOGICS
	sudo sed -i "/LOGICS=SimplexLogic/ s/$/,ReflectorLogic/" $CONF
#
	echo `date` Setting svxlink log file
	sudo sed -i "/LOGFILE=/ s/$/.log/" /etc/default/svxlink
#
	echo `date` enabling GPIO setup service and svxlink service …
	sudo systemctl enable svxlink_gpio_setup
	sleep 10
	sudo systemctl enable svxlink
	sleep 10
	sudo systemctl start svxlink_gpio_setup.service
	sleep 10
	sudo systemctl start svxlink.service
fi

touch $FLAG
echo `date` Installation complete
echo `date` Reboot SVXLink
echo
sudo reboot

