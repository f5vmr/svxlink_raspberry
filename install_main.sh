#!/bin/bash

#### LANGUAGE ####
clear
source "${BASH_SOURCE%/*}/functions/language.sh"
#which_language
if [ $LANG == "fr_FR.UTF8" ]; then sudo sh ./install_copy_fr.sh;  fi

#### Welcome Message ####
source "${BASH_SOURCE%/*}/functions/welcome.sh"
welcome
#### NODE Selection ####
source "${BASH_SOURCE%/*}/functions/node_type.sh"
nodeoption
echo -e "$(date)" "${YELLOW} #### Node Type: $NODEOPTION #### ${NORMAL}" | tee -a  /var/log/install.log
##### USB SOUND CARD ####
source "${BASH_SOURCE%/*}/functions/sound_card.sh"
soundcard
echo -e "$(date)" "${YELLOW} #### Sound Card: $HID $GPIOD $card #### ${NORMAL}" | tee -a  /var/log/install.log	
echo -e "$(date)" "${YELLOW} #### Checking Alsa #### ${NORMAL}" | tee -a  /var/log/install.log
#### UPDATE ####
source "${BASH_SOURCE%/*}/functions/update.sh"
update
#### REQUEST CALLSIGN ####
source "${BASH_SOURCE%/*}/functions/callsign.sh"
callsign
#### GROUPS AND USERS ####
clear
echo -e "$(date)" "${YELLOW} #### Creating Groups and Users #### ${NORMAL}" | tee -a  /var/log/install.log
source "${BASH_SOURCE%/*}/functions/groups.sh"
#make_groups

#### DOWNLOADING SOURCE CODE ####

echo -e "$(date)" "${YELLOW} #### Downloading SVXLink source code #### ${NORMAL}" | tee -a  /var/log/install.log
source "${BASH_SOURCE%/*}/functions/source.sh"
#svxlink_source	
#### INSTALLATION ####
clear
#	NEWVERSION = `sudo grep -r "SVXLINK=" $VERSIONS * | awk -F= '{print $2}'
	echo -e "$(date)" "${GREEN} #### New Version: $NEWVERSION #### ${NORMAL}" | tee -a  /var/log/install.log
sleep 3
	
#### COMPILING ####
clear
	echo -e "$(date)" "${YELLOW} #### Compiling #### ${NORMAL}" | tee -a  /var/log/install.log
sleep 3
#	cd svxlink/src/build
#	sudo cmake -DUSE_QT=OFF -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var -DWITH_SYSTEMD=ON  ..
#	sudo make
#	sudo make doc
#	echo -e "$(date)" "${GREEN} #### Installing SVXLink #### ${NORMAL}" | tee -a  /var/log/install.log
#	sudo make install
#	cd /usr/share/svxlink/events.d
#	sudo mkdir local
#	sudo cp *.tcl ./local
#	sudo ldconfig
##### CONFIGURATION VOICES ####
clear
	echo -e "$(date)" "${GREEN} #### Installing Voice Files #### ${NORMAL}" | tee -a  /var/log/install.log
sleep 3
#	cd /usr/share/svxlink/sounds
#	sudo wget https://g4nab.co.uk/wp-content/uploads/2023/08/en_GB.tar_.gz
#	sudo tar -zxvf en_GB.tar_.gz
#	sudo rm en_GB.tar_.gz
#  	cd /etc/svxlink
#   sudo chmod 777 -R *
#
##### BACKUP CONFIGURATION ####
clear
	echo -e "$(date)" "${GREEN} #### Backing up configuration to : $CONF.bak #### ${NORMAL}"| tee -a  /var/log/install.log
sleep 3
#	sudo cp -p $CONF $CONF.bak
##
#	cd
#	echo -e "$(date)" "${RED} #### Downloading prepared configuration files from the scripts #### ${NORMAL}" | tee -a  /var/log/install.log
#	sudo mkdir /home/pi/scripts
# 	sudo cp -f svxlink_raspberry/10-uname /etc/update-motd.d/
#	sudo cp -f svxlink_raspberry/configs/svxlink.conf /etc/svxlink/
#	sudo cp -f svxlink_raspberry/configs/gpio.conf /etc/svxlink/
#	sudo cp -f svxlink_raspberry/addons/node_info.json /etc/svxlink/node_info.json
#	sudo cp -f svxlink_raspberry/resetlog.sh /home/pi/scripts/resetlog.sh
#	(sudo crontab -l 2>/dev/null; echo "59 23 * * * /home/pi/scripts/resetlog.sh ") | sudo crontab -
clear
	echo -e "$(date)" "${GREEN} #### Setting Callsign to $CALL #### ${NORMAL}" | tee -a  /var/log/install.log
sleep 3
#	sudo sed -i "s/MYCALL/$CALL/g" $CONF
#	sudo sed -i "s/MYCALL/$CALL/g" /etc/svxlink/node_info.json

#	echo -e "$(date)" "${GREEN} #### Setting Squelch Hangtime to 10 mS ${NORMAL}" | tee -a  /var/log/install.log
#	sudo sed -i "s/SQL_HANGTIME=2000/SQL_HANGTIME=10/g" $CONF
#
clear	
	echo -e "$(date)" "${YELLOW} #### Disabling audio distortion warning messages #### ${NORMAL}"| tee -a  /var/log/install.log

sleep 3
#	sudo sed -i "s/PEAK_METER=1/PEAK_METER=0/g" $CONF
#
clear
	echo -e "$(date)" "${GREEN} #### Updating SplashScreen on startup #### ${NORMAL}" | tee -a  /var/log/install.log
sleep 3
#	sudo sed -i "s/MYCALL/$CALL/g" /etc/update-motd.d/10-uname
#	sudo chmod 0755 /etc/update-motd.d/10-uname
#
clear
	echo -e "$(date)" "${YELLOW} #### Changing Log file suffix ${NORMAL}" | tee -a  /var/log/install.log
sleep 3
#	sudo sed -i "s/log\/svxlink/log\/svxlink.log/g" /etc/default/svxlink
	#### INSTALLING DASHBOARD ####
clear
	echo -e "$(date)" "${YELLOW} #### Checking IP Addresses #### ${NORMAL}" | tee -a  /var/log/install.log
	sleep 3
	source "${BASH_SOURCE%/*}/functions/get_ip.sh"
	ipaddress
clear
	echo -e "$(date)" "${YELLOW} #### Installing Dashboard #### ${NORMAL}" | tee -a  /var/log/install.log
sleep 3
	source "${BASH_SOURCE%/*}/functions/dash_install.sh"
dashboard
clear
	echo -e "$(date)" "${GREEN} #### Dashboard installed #### ${NORMAL}" | tee -a  /var/log/install.log
	whiptail --tile "IP Addresses" --msgbox "Dashboard installed. Please note your IP address is $eth_ip or $wan_ip" 8 78

sleep 3
	clear
	echo -e "$(date)" "${GREEN} #### Setting up Node #### ${NORMAL}" | tee -a  /var/log/install.log
source "${BASH_SOURCE%/*}/functions/node_setup.sh"
nodesetup
	clear
 	echo -e "$(date)" "${RED} #### Changing ModuleMetar Link #### ${NORMAL}" | tee -a  /var/log/install.log
source "${BASH_SOURCE%/*}/functions/modulemetar_setup.sh"
modulemetar
	sleep 3
	clear
	echo -e "$(date)" "${RED} #### Changing ModuleEchoLink Link #### ${NORMAL}" | tee -a  /var/log/install.log
source "${BASH_SOURCE%/*}/functions/echolink_setup.sh"
echolink_setup
	sleep 3
	clear
	echo -e "$(date)" "${RED} #### Changing ModulePropagationMonitor #### ${NORMAL}" | tee -a  /var/log/install.log
	source "${BASH_SOURCE%/*}/functions/propagationmonitor_setup.sh"
	propagationmonitor
	sleep 3
	clear
	echo -e "$(date)" "${RED} #### Setting up svxlink.service #### ${NORMAL}" | tee -a  /var/log/install.log
sleep 3
#	sudo systemctl enable svxlink_gpio_setup
	sleep 3
#	sudo systemctl enable svxlink
	sleep 3
#	sudo systemctl start svxlink_gpio_setup.service
	sleep 3
#	sudo systemctl start svxlink.service


echo -e "$(date)" "${GREEN} #### Installation complete #### ${NORMAL}" | tee -a  /var/log/install.log
sleep 3 
#echo -e "$(date)" "${GREEN} #### Now to configure SVXLink #### ${NORMAL}" | tee -a  /var/log/install.log
#source "${BASH_SOURCE%/*}/functions/configure.sh"
#config

echo -e "$(date)" "${RED} #### Rebooting SVXLink #### ${NORMAL}" | tee -a  /var/log/install.log
sleep 3
exit


#sudo reboot


	
 
