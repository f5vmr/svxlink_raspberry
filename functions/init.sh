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
