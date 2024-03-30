#!/bin/bash
########## INITIALISE ##########
source "${BASH_SOURCE%/*}/functions/language.sh"
which_language
exit
source "${BASH_SOURCE%/*}/functions/initialise.sh"
source "${BASH_SOURCE%/*}/functions/check_os.sh"
check_os
########## Welcome Message ##########
source "${BASH_SOURCE%/*}/functions/welcome.sh"
welcome
########## Language Selection ##########
source "${BASH_SOURCE%/*}/functions/language.sh"
language
node_type
########### USB SOUND CARD ##########
source "${BASH_SOURCE%/*}/functions/soundcard.sh"
soundcard

#
# 
#
########## UPDATE ##########
source "${BASH_SOURCE%/*}/functions/update.sh"
update
########## REQUEST CALLSIGN ##########
source "${BASH_SOURCE%/*}/functions/callsign.sh"
callsign
exit
########## GROUPS AND USERS ##########
	echo -e `date` "${YELLOW} Creating Groups and Users ${NORMAL}"
	sudo mkdir /etc/svxlink
    sudo groupadd svxlink
	sudo useradd -g svxlink -d /etc/svxlink svxlink
	sudo usermod -aG audio,nogroup,svxlink,plugdev svxlink
	sudo usermod -aG gpio svxlink

########## DOWNLOADING SOURCE CODE ##########

	echo -e `date` "${YELLOW} ########## Downloading SVXLink source code ########## ${NORMAL}"
	cd
	sudo git clone https://github.com/sm0svx/svxlink.git
	sudo mkdir svxlink/src/build

	
	NEWVERSION=`sudo grep “SVXLINK=“ $VERSIONS | awk -F= '{print $2}'`
	echo `date` New Version: $NEWVERSION

########## COMPILING ##########
	echo -e `date` "${YELLOW} ########## Compiling ########## ${NORMAL}"
	cd svxlink/src/build
	sudo cmake -DUSE_QT=OFF -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var -DWITH_SYSTEMD=ON  ..
	sudo make
	sudo make doc
	echo `date` "${GREEN}########## Installing SVXLink ########## ${NORMAL}"
	sudo make install
	cd /usr/share/svxlink/events.d
	sudo mkdir local
	sudo cp *.tcl ./local
	sudo ldconfig
########### CONFIGURATION VOICES ##########
	echo -e `date` "${GREEN} ########## Installing Voice Files ########## ${NORMAL}"
	cd /usr/share/svxlink/sounds
	sudo wget https://g4nab.co.uk/wp-content/uploads/2023/08/en_GB.tar_.gz
	sudo tar -zxvf en_GB.tar_.gz
	sudo rm en_GB.tar_.gz
   	cd /etc/svxlink
    sudo chmod 777 -R *

########### BACKUP CONFIGURATION ##########
	echo `date` backing up configuration to : $CONF.bak
	sudo cp -p $CONF $CONF.bak
#
	cd
	echo -e `date` "${RED} ########## Downloading prepared configuration files from the scripts ##########${NORMAL}"
	sudo mkdir /home/pi/scripts
 	sudo cp -f svxlink_raspberry/10-uname /etc/update-motd.d/
	sudo cp -f svxlink_raspberry/configs/svxlink.conf /etc/svxlink/
#	sudo cp -f svxlink_raspberry/configs/gpio.conf /etc/svxlink/
#	sudo cp -f svxlink_raspberry/addons/node_info.json /etc/svxlink/node_info.json
	sudo cp -f svxlink_raspberry/resetlog.sh scripts/resetlog.sh
	(sudo crontab -l 2>/dev/null; echo "59 23 * * * /home/pi/scripts/resetlog.sh ") | sudo crontab -

	echo `date` "${GREEN} Setting Callsign to "$CALL"${NORMAL}"
	sudo sed -i "s/MYCALL/$CALL/g" $CONF
	sudo sed -i "s/MYCALL/$CALL/g" /etc/svxlink/node_info.json

	echo `date` Setting Squelch Hangtime to 10
	sudo sed -i "s/SQL_HANGTIME=2000/SQL_HANGTIME=10/g" $CONF
#	
	echo `date` Disabling audio distortion warning messages
	sudo sed -i "s/PEAK_METER=1/PEAK_METER=0/g" $CONF
#
	echo `date` Updating SplashScreen on startup
	sudo sed -i "s/MYCALL/$CALL/g" /etc/update-motd.d/10-uname
	sudo chmod 0755 /etc/update-motd.d/10-uname
#
	echo `date` Changing Log file
	sudo sed -i "s/log\/svxlink/log\/svxlink.log/g" /etc/default/svxlink
	########## INSTALLING DASHBOARD ##########
	echo `date` "${YELLOW} ######## Installing Dashboard ######## ${NORMAL}"
	if [ $card=true ] ;
	then
	sudo sed -i "s/PTT_TYPE=GPIO/PTT_TYPE=Hidraw/g" $CONF
	sudo sed -i "s/PTT_PORT=GPIO/PTT_PORT=\/dev\/hidraw0/g" $CONF
	sudo sed -i "s/PTT_PIN=gpio24/HID_PTT_PIN=GPIO3/g" $CONF
	fi
	sudo sed -i "s/\#MUTE/MUTE/g" /etc/svxlink/svxlink.d/ModuleEchoLink.conf
	sudo sed -i "s/\#DEFAULT_LANG=en_US/DEFAULT_LANG=en_GB/g" /etc/svxlink/svxlink.conf	
	sudo sed -i "s/\#DEFAULT_LANG=en_US/DEFAULT_LANG=en_GB/g" /etc/svxlink/svxlink.d/ModuleEchoLink.conf
	sudo sed -i "s/\#MUTE/MUTE/g" /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
	sudo sed -i "s/\#DEFAULT_LANG=en_US/DEFAULT_LANG=en_GB/g" /etc/svxlink/svxlink.d/ModuleMetarInfo.conf	
 	echo "${RED}Changing ModuleMetar Link${NORMAL}"
  	sudo sed -i "s%#LINK=data/observations/metar/stations%LINK=/cgi-bin/data/dataserver.php?requestType=retrieve&dataSource=metars&hoursBeforeNow=3&stationString=
%g" /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
	echo `date` "${RED} Authorise GPIO setup service (Unused) and svxlink service${NORMAL}"
	sudo systemctl enable svxlink_gpio_setup
	sleep 10
	sudo systemctl enable svxlink
	sleep 10
	sudo systemctl start svxlink_gpio_setup.service
	sleep 10
	sudo systemctl start svxlink.service


echo -e `date` "${RED}Installation complete\n${NORMAL}"
echo -e `date` "${GREEN} Reboot - Redémarrer SVXLink\n\n\n${NORMAL}"
echo
sleep 10

sudo reboot


	
 
