#!/bin/bash
whiptail --title "SVXLink Build" --msgbox "The basic build requires that we remove the on-board Soundcard and the HDMI Soundcard. Hit OK to continue" 8 78
export LANGUAGE=en_GB.UTF-8
GREEN="\033[1;32m"
NORMAL="\033[0;39m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
echo blacklist snd_bcm2835 > /etc/modprobe.d/raspi-blacklist.conf
sudo sed -i "s/options snd-usb/#options snd-usb/g" /lib/modprobe.d/aliases.conf
sudo sed -i "s/dtoverlay=vc4-kms-v3d/dtoverlay=vc4-kms-v3d,noaudio/g" /boot/config.txt
sudo cp /home/pi/svxlink_raspberry/asound.conf /etc/modprobe.d/asound.conf
echo snd-aloop > /etc/modules
sudo cp /home/pi/svxlink_raspberry/loopback.conf /etc/asound.conf

card=false

if whiptail --title "USB Soundcard" --yesno "Do you have a modified CM108 Soundcard or Similar." 8 78; then
    echo "Ok, Let's add the updated rules"
                sudo cp svxlink_raspberry/cm-108.rules /etc/udev/rules.d/
                sudo udevadm control --reload-rules
                sudo udevadm trigger
                card=true
else
    echo "ok, then I will make no other changes"
                card=false
fi



                if [ "$card" = true ] ;
                then 
                echo "Modified CM-108 soundcard present"
                else
                echo "Normal USB soundcard present"
                fi
                
                echo "Audio Updates including Dummy Sound Card for Darkice complete."
				echo soundcard="$card"	
exit
#
# 
#

CONF="/etc/svxlink/svxlink.conf"
GPIO="/etc/svxlink/gpio.conf"
OP=/etc/svxlink

whiptail --title "Updating" --msgbox "Uprating repositories for nodejs and future expansion. Hit OK to continue" 8 78

	echo -e `date` " ${YELLOW}  *** updates and upgrades *** ${NORMAL}"
	sudo apt-get update
	sudo apt-get install -y ca-certificates curl gnupg
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
	NODE_MAJOR=20
	echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

	sudo apt update
	sudo apt upgrade -y
	VERSIONS=svxlink/src/versions

	echo -e `date` " ${YELLOW}  *** commence build *** ${NORMAL}"

whiptail --title "Build Essentials" --msgbox "Adding all the packages necessary for Svxlink. Hit OK to continue" 8 78

	echo -e `date` " ${YELLOW} Installing required software packages${NORMAL}"
	sudo apt install build-essential g++ make cmake libsigc++-2.0-dev php8.2 nodejs libgsm1-dev libudev-dev libpopt-dev tcl-dev libgpiod-dev gpiod libgcrypt20-dev libspeex-dev libasound2-dev alsa-utils libjsoncpp-dev libopus-dev rtl-sdr libcurl4-openssl-dev libogg-dev librtlsdr-dev groff doxygen graphviz python3-serial toilet -y
CallVar=$(whiptail --inputbox "What is the node Callsign?" 8 39 Blue --title "Node Callsign" 3>&1 1>&2 2>&3)
                                                                        # A trick to swap stdout and stderr.
# Again, you can pack this inside if, but it seems really long for some 80-col terminal users.
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $CallVar
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"         
	echo -e `date` "${GREEN} Enter the node callsign: \n ${NORMAL}"
	echo
	read CallVar
	if [ "$CallVar" == "" ]; then
		echo "Sorry - Start this program again with a valid callsign"
		exit 1
	fi
	CALL=${CallVar^^}
	echo
	echo `date` "${GREEN} Creating Node " $CALL " *** ${NORMAL}"
# Creating Groups and Users

	echo -e `date` "${YELLOW} Creating Groups and Users ${NORMAL}"
	sudo mkdir /etc/svxlink
    sudo groupadd svxlink
	sudo useradd -g svxlink -d /etc/svxlink svxlink
	sudo usermod -aG audio,nogroup,svxlink,plugdev svxlink
	sudo usermod -aG gpio svxlink


# Downloading Source Code for SVXLink
	echo -e `date` "${YELLOW} downloading SVXLink source code ... ${NORMAL}"
	cd
	sudo git clone https://github.com/sm0svx/svxlink.git
	sudo mkdir svxlink/src/build

	
	NEWVERSION=`sudo grep “SVXLINK=“ $VERSIONS | awk -F= '{print $2}'`
	echo `date` New Version: $NEWVERSION
# Compilation
	echo -e `date` "${YELLOW} Compiling ... ${NORMAL}"
	cd svxlink/src/build
	sudo cmake -DUSE_QT=OFF -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var -DWITH_SYSTEMD=ON  ..
	sudo make
	sudo make doc
	echo `date` "${GREEN}Installing SVXLink${NORMAL}"
	sudo make install
	cd /usr/share/svxlink/events.d
	sudo mkdir local
	sudo cp *.tcl ./local
	sudo ldconfig
# Installing United Kingdom Sound files
	echo -e `date` "${GREEN} Installing Voice Files ${NORMAL}"
	cd /usr/share/svxlink/sounds
	sudo wget https://g4nab.co.uk/wp-content/uploads/2023/08/en_GB.tar_.gz
	sudo tar -zxvf en_GB.tar_.gz
	sudo rm en_GB.tar_.gz
   	cd /etc/svxlink
    sudo chmod 777 -R *
# Backing up installed svxlink.conf and replacing it from the script.
	echo `date` backing up configuration to : $CONF.bak
	sudo cp -p $CONF $CONF.bak
#
	cd
	echo -e `date` "${RED} Downloading prepared configuration files from the script …${NORMAL}"
	sudo mkdir /home/pi/scripts
 	sudo cp -f svxlink_raspberry/10-uname /etc/update-motd.d/
	sudo cp -f svxlink_raspberry/svxlink.conf /etc/svxlink/
#	sudo cp -f svxlink_raspberry/gpio.conf /etc/svxlink/
#	sudo cp -f svxlink_raspberry/node_info.json /etc/svxlink/node_info.json
	sudo cp -f svxlink_raspberry/resetlog.sh scripts/resetlog.sh
	(sudo crontab -l 2>/dev/null; echo "59 23 * * * /home/pi/scripts/resetlog.sh ") | sudo crontab -
#
	echo `date` "${GREEN} Setting Callsign to "$CALL"${NORMAL}"
	sudo sed -i "s/MYCALL/$CALL/g" $CONF
	sudo sed -i "s/MYCALL/$CALL/g" /etc/svxlink/node_info.json
#
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


	
 
