#!/bin/bash

#### INITIALISE ####	 	
source "${BASH_SOURCE%/*}/functions/initialise.sh"
initialise
#### CHECK OS ####
source "${BASH_SOURCE%/*}/functions/check_os.sh"
check_os
#### Welcome Message ####
source "${BASH_SOURCE%/*}/functions/welcome_fr.sh"
welcome
#### NODE Selection ####
source "${BASH_SOURCE%/*}/functions/node_type_fr.sh"
nodeoption
##### USB SOUND CARD ####
source "${BASH_SOURCE%/*}/functions/sound_card_fr.sh"
soundcard
exit
#
# 
#
#### UPDATE ####
source "${BASH_SOURCE%/*}/functions/update.sh"
update
#### REQUEST CALLSIGN ####
source "${BASH_SOURCE%/*}/functions/callsign.sh"
callsign
#### GROUPS AND USERS ####
	echo -e "$(date)" "${YELLOW} Creating Groups and Users ${NORMAL}" | tee -a  /var/log/install.log
source "${BASH_SOURCE%/*}/functions/groups.sh"
make_groups

#### DOWNLOADING SOURCE CODE ####
source "${BASH_SOURCE%/*}/functions/source.sh"
	echo -e "$(date)" "${YELLOW} #### Téléchargements de codesource SVXLink #### ${NORMAL}" | tee -a  /var/log/install.log
	cd
svxlink_source	

	
	NEWVERSION=`sudo grep “SVXLINK=“ $VERSIONS | awk -F= '{print $2}'`
	echo -e "$(date)" New Version: $NEWVERSION | tee -a  /var/log/install.log

#### COMPILING ####
	echo -e "$(date)" "${YELLOW} #### Compilation #### ${NORMAL}" | tee -a  /var/log/install.log
	cd svxlink/src/build
	sudo cmake -DUSE_QT=OFF -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var -DWITH_SYSTEMD=ON  ..
	sudo make
	sudo make doc
	echo -e "$(date)" "${GREEN} #### Installation SVXLink #### ${NORMAL}" | tee -a  /var/log/install.log
	sudo make install
	cd /usr/share/svxlink/events.d
	sudo mkdir local
	sudo cp *.tcl ./local
	sudo ldconfig
##### CONFIGURATION VOICES ####
	echo -e "$(date)" "${GREEN} #### Installation de dossiers Voix #### ${NORMAL}" | tee -a  /var/log/install.log
	cd /usr/share/svxlink/sounds
	sudo wget https://g4nab.co.uk/wp-content/uploads/2023/08/fr_FR.tar_.gz
	sudo tar -zxvf fr_FR.tar_.gz
	sudo rm fr_FR.tar_.gz
   	cd /etc/svxlink
    sudo chmod 777 -R *

##### BACKUP CONFIGURATION ####
	echo -e "$(date)" "${GREEN} #### backing up configuration to : $CONF.bak #### ${NORMAL}"| tee -a  /var/log/install.log

	sudo cp -p $CONF $CONF.bak
#
	cd
	echo -e "$(date)" "${RED} #### Downloading prepared configuration files from the scripts #### ${NORMAL}" | tee -a  /var/log/install.log
	sudo mkdir /home/pi/scripts
 	sudo cp -f svxlink_raspberry/10-uname /etc/update-motd.d/
	sudo cp -f svxlink_raspberry/configs/svxlink.conf /etc/svxlink/
#	sudo cp -f svxlink_raspberry/configs/gpio.conf /etc/svxlink/
#	sudo cp -f svxlink_raspberry/addons/node_info.json /etc/svxlink/node_info.json
	sudo cp -f svxlink_raspberry/resetlog.sh scripts/resetlog.sh
	(sudo crontab -l 2>/dev/null; echo "59 23 * * * /home/pi/scripts/resetlog.sh ") | sudo crontab -

	echo -e "$(date)" "${GREEN} #### Setting Callsign to $CALL #### ${NORMAL}" |tee -a  /var/log/install.log
	sudo sed -i "s/MYCALL/$CALL/g" $CONF
	sudo sed -i "s/MYCALL/$CALL/g" /etc/svxlink/node_info.json

	echo -e "$(date)" "${YELLOW} #### Setting Squelch Hangtime to 10 mS #### ${NORMAL}" | tee -a  /var/log/install.log
	sudo sed -i "s/SQL_HANGTIME=2000/SQL_HANGTIME=10/g" $CONF 
#	
	echo -e "$(date)" "${YELLOW} #### Disabling audio distortion warning messages #### ${NORMAL}" | tee -a  /var/log/install.log
	sudo sed -i "s/PEAK_METER=1/PEAK_METER=0/g" $CONF
#
	echo -e "$(date)" "${GREEN} #### Updating SplashScreen on startup #### ${NORMAL}"  | tee -a  /var/log/install.log
	sudo sed -i "s/MYCALL/$CALL/g" /etc/update-motd.d/10-uname
	sudo chmod 0755 /etc/update-motd.d/10-uname
#
	echo -e "$(date)" "${GREEN} Changing Logfile suffix ${NORMAL}"| tee -a  /var/log/install.log 		
	sudo sed -i "s/log\/svxlink/log\/svxlink.log/g" /etc/default/svxlink
	#### INSTALLING DASHBOARD ####
	echo -e "$(date)" "${YELLOW} #### Installing Dashboard #### ${NORMAL}" | tee -a  /var/log/install.log
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
 	echo-e "$(date)" "${RED} #### Changing ModuleMetar Link #### ${NORMAL}" | tee -a  /var/log/install.log
  	sudo sed -i "s%#LINK=data/observations/metar/stations%LINK=/cgi-bin/data/dataserver.php?requestType=retrieve&dataSource=metars&hoursBeforeNow=3&stationString=
%g" /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
	echo -e "$(date)" "${RED} #### Authorise svxlink.service #### ${NORMAL}" | tee -a  /var/log/install.log
	sudo systemctl enable svxlink_gpio_setup
	sleep 3
	sudo systemctl enable svxlink
	sleep 3
	sudo systemctl start svxlink_gpio_setup.service
	sleep 3
	sudo systemctl start svxlink.service


echo -e "$(date)" "${RED} #### Installation complete #### ${NORMAL}" |tee -a  /var/log/install.log
echo -e "$(date)" "${GREEN} #### Reboot - Redémarrer #### ${NORMAL}" |tee -a  /var/log/install.log
echo
sleep 3

sudo reboot


	
 
