#!/bin/bash
TITLE="SVXLink Build" VERSION="24.02"

function welcome_message {
    WELCOME="Welcome to the SVXLink Build Script.\n\nThis script will install a build of SVXLink with user pi and password raspberry"
whiptail --title "$TITLE" --msgbox "$WELCOME\n\n Hit OK to continue" 8 78
}
###### install ######

function install_dependencies {
export LANGUAGE=en_GB.UTF-8
GREEN="\033[1;32m"
NORMAL="\033[0;39m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
}
#function kill_sound_cards {
#echo blacklist snd_bcm2835 > /etc/modprobe.d/raspi-blacklist.conf
#sudo sed -i "s/options snd-usb/#options snd-usb/g" /lib/modprobe.d/aliases.conf
#sudo sed -i "s/dtoverlay=vc4-kms-v3d/dtoverlay=vc4-kms-v3d,noaudio/g" /boot/config.txt
#sudo cp /home/pi/svxlink_raspberry/configs/asound.conf /etc/modprobe.d/asound.conf
#echo snd-aloop > /etc/modules
#sudo cp /home/pi/svxlink_raspberry/configs/loopback.conf /etc/asound.conf
#}
function get_CallVar {
CALL=$(whiptail --inputbox "Enter the node callsign:" 8 40 3>&1 1>&2 2>&3)    
while true; do
    #user_input=$(get_CallVar)
    
    # Check if input is empty
    if [ -z "$CALL" ]; then
        whiptail --msgbox "Node Callsign cannot be empty. Please try again." 8 40
    else
        # If input is not empty, break the loop
        break
    fi
done
CALL=${user_input^^} 
echo date "*** Node Callsign $CALL **** ">> /var/log/install.log

}




# Use the non-empty name

function node_type {
OPTION=$(whiptail --title "$TITLE" --menu "Select Node Type" 14 78 3 \
    "1" "Simplex Single Frequency Node" \
    "2" "Duplex Repeater Node" 3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ $exitstatus = 0 ]; then
    case $OPTION in
    1) SIMPLEX_INSTALL="true";;
    2) SIMPLEX_INSTALL="false";;
    esac
    else
    exit;
    fi
}
function query_network {
    NETWORK=$(whiptail --title "$TITLE" --menu "Select Network Type" 14 78 3 \
    "1" "Stand Alone" \
    "2" "Svxportal-UK" 3>&1 1>&2 2>&3)
    exitstatus=$?
    if [ $exitstatus = 0 ]; then
    case $OPTION in
    1) NETWORK="false";;
    2) NETWORK="true";;
    esac
    else
        exit;
    fi
}
function menu_end {
    END_MESSAGE="The build is complete. Please reboot the Pi to complete the installation"
    if (whiptail --title "$TITLE" --yes-button "REBOOT NOW" --no-button "CANCEL" --yesno "$END_MESSAGE" 8 78) then
    echo "Rebooting Now!";
    #sudo reboot;
    else
    echo "Exiting without a reboot";exit;
    fi
}

