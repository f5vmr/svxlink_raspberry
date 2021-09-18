#!/bin/bash
# automated install of SVXlink
CONF=/etc/svxlink/svxlink.conf
GPIO=/etc/svxlink/gpio.conf
HOME=/home/pi/
FLAG=/$HOME/.makescript
sudo apt update
VERSIONS=$HOME/svxlink/src/versions

if [ ! -f $FLAG ]; then
	echo `date` *** commence build ***
	echo
	echo -n “Enter the node callsign: “
	read CallVar
	if [ “$CallVar” == “” ]; then
		echo “Sorry - Start this program again with a valid callsign”
		exit 1
	fi
	CALL=${CallVar^^}

# Creating Groups and Users
	echo `date` Creating Groups and Users 
	sudo groupadd svxlink
	sudo useradd -g svxlink -d /etc/svxlink svxlink
	sudo usermod -aG audio,nogroup,svxlink,plugdev svxlink
	sudo usermod -aG gpio svxlink

# Installing other packages
	echo `date` Installing required software packages …
	sudo apt-get -y install g++ make libsigc++ libgsm1-dev libpopt-dev tcl-dev libgcrypt-dev libspeex-dev libasound2-dev alsa-utils libqt4-dev git cmake libsigc++ libjsoncpp-dev libopus-dev rtl-sdr libcurl4-openssl-dev libogg-dev librtlsdr-dev groff doxygen graphviz python-serial

# Downloading Source Code for SVXLink
	echo `date` downloading SVXLink source code …
	cd $HOME
	sudo git clone https://github.com/f5vmr/svxlink.git
	sudo mkdir svxlink/src/build
	fi
# Updating from repo and building software
#	echo `date` Updating from repo and building software …
#	cd $HOME/svxlink
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
	cd svxlink/src/build
	sudo cmake -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc \ -DLOCAL_STATE_DIR=/var ..
	sudo make
	sudo make doc
	echo `date` Installing SVXlink
	sudo make install
	cd /usr/share/svxlink/events.d
	sudo mkdir local
	sudo cp * local
	sudo ldconfig
If [ ! -F $FLAG ]; then
	# Installing United Kingdom Sound files
	cd /usr/share/svxlink/sounds
	sudo wget http://g4nab.co.uk/wp-content/uploads/2021/09/en_GB.tar.gz
	sudo tar -zxvf en_GB.tar.gz
#
	echo `date` backing up configuration to : $CONF.bak
	sudo cp -p $CONF $CONF.bak
#
	echo `date` Downloading prepared configuration files from G4NAB …
	sudo wget -q0 $CONF https://g4nab.co.uk/wp-content/uploads/2021/09/svxlink.conf
#
	echo `date` Setting Callsign to $CALL
	sudo sed -i “s/MYCALL/$CALL/g” $CONF
#
	echo `date` Setting Squelch Hangtime to 10
	sudo sed -i ’s/SQL_HANGTIME=2000/SQL_HANGTIME=10/‘ $CONF
#	
	echo `date` Disabling audio distortion warning messages
	sudo sed -i ’s/PEAK_METER=1/PEAK_METER=0/‘ $CONF
#
	echo `date` enabling GPIO setup service and svxlink service …
	sudo systemctl enable svxlink_gpio_setup
	sudo systemctl enable svxlink
Fi
touch $FLAG
echo `date` Installation complete
echo `date` Reboot to restart SVXLink
echo


	
 
