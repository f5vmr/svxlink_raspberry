#!/bin/bash
########## INIT ##########
source ./functions/init.sh
welcome_message
install_dependencies
kill_sound_cards
node_type
call_sign
query_network
menu_end

whiptail --title "SVXLink Build" --msgbox "The basic build requires that we remove the on-board Soundcard and the HDMI Soundcard. Hit OK to continue" 8 78
export LANGUAGE=en_GB.UTF-8
GREEN="\033[1;32m"
NORMAL="\033[0;39m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
#echo blacklist snd_bcm2835 > /etc/modprobe.d/raspi-blacklist.conf
#sudo sed -i "s/options snd-usb/#options snd-usb/g" /lib/modprobe.d/aliases.conf
#sudo sed -i "s/dtoverlay=vc4-kms-v3d/dtoverlay=vc4-kms-v3d,noaudio/g" /boot/config.txt
#sudo cp /home/pi/svxlink_raspberry/configs/asound.conf /etc/modprobe.d/asound.conf
#echo snd-aloop > /etc/modules
#sudo cp /home/pi/svxlink_raspberry/configs/loopback.conf /etc/asound.conf

card=false
######## SOUNDCARD CHECK #########
if whiptail --title "USB Soundcard" --yesno "Do you have a modified CM108 Soundcard or Similar." 8 78; then
    echo "Ok, Let's add the updated rules"
 #               sudo cp svxlink_raspberry/cm-108.rules /etc/udev/rules.d/
 #               sudo udevadm control --reload-rules
 #               sudo udevadm trigger
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
######## BUILDING ##########
whiptail --title "Updating" --infobox "Uprating repositories for nodejs and future expansion" 8 78 
######## BUILD ESSENTIALS ##########
whiptail --title "Build Essentials" --msgbox "Adding all the packages necessary for Svxlink. Hit OK to continue" 8 78


# Function to prompt user for name input
source ./functions/init.sh
get_CallVar
########## REQUEST CALLSIGN ##########
# Main loop


# Use the non-empty name
echo "Node Callsign is now $CALL!"
######## GROUPS AND USERS ##########

######## DOWNLOAD SOURCE CODE ##########

######## COMPILING ##########

######## CONFIGURING VOICES ##########
source ./functions/language.sh
which_language
exit
#