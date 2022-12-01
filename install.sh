#!/bin/bash
# automated install of SVXlink
CONF=/etc/svxlink/svxlink.conf
GPIO=/etc/svxlink/gpio.conf
HOME=/home/pi
OP=/etc/svxlink
FLAG=.makescript
cd
sudo apt update
sudo apt upgrade -y
VERSIONS=svxlink/src/versions

if [ ! -f $FLAG ]; then
	echo `date` *** commence build ***
# Installing other packages
	echo `date` Installing required software packages …
	sudo apt install g++ make cmake libsigc++-2.0-dev php8.0 libgsm1-dev libudev-dev libpopt-dev tcl-dev libgpiod-dev gpiod libgcrypt20-dev libspeex-dev libasound2-dev alsa-utils libjsoncpp-dev libopus-dev rtl-sdr libcurl4-openssl-dev libogg-dev librtlsdr-dev groff doxygen graphviz python3-serial toilet -y
        
	echo -n “Enter the node callsign: \n“
	
	read CallVar
	if [ “$CallVar” == “” ]; then
		echo “Sorry - Start this program again with a valid callsign”
		exit 1
	fi
	CALL=${CallVar^^}
	echo `date` Creating Node $CALL
# Creating Groups and Users
	echo `date` Creating Groups and Users 
	sudo groupadd svxlink
	sudo useradd -g svxlink -d /etc/svxlink svxlink
	sudo usermod -aG audio,nogroup,svxlink,plugdev svxlink
	sudo usermod -aG gpio svxlink


# Downloading Source Code for SVXLink
	echo `date` downloading SVXLink source code …
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
	# Installing United Kingdom Sound files
	cd /usr/share/svxlink/sounds
	sudo wget https://g4nab.co.uk/wp-content/uploads/2022/12/en_GB.tar.gz
	sudo tar -zxvf en_GB.tar.gz
	sudo rm en_GB.tar.gz
#.      for the French Language use sudo wget https://g4nab.co.uk/wp-content/uploads/2021/07/fr_FR.tar.gz and change the 2 lines below.      
#.      pour la langue française uilise cela dessus ^ et donc changé les deux lignes qui la suivent.
echo `date` backing up configuration to : $CONF.bak
	cd $OP
	sudo cp -p $CONF $CONF.bak
#
	cd
	echo `date` Downloading prepared configuration files from G4NAB …
	sudo cp -r svxlink_raspberry/svxlink.conf $OP
	sudo cp -r svxlink_raspberry/gpio.conf $OP
#	sudo cp -r svxlink_raspberry/10-uname /etc/update-motd.d/
#
	echo `date` Setting Callsign to $CALL
	sudo sed -i "s/MYCALL/$CALL/g" $CONF
#
	echo `date` Setting Squelch Hangtime to 10
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
echo `date` Rebooting to restart SVXLink
echo
sudo reboot

	
 
