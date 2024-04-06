#!/bin/bash
#### Kill OnBoard Soundcards ####
    sudo touch /var/log/install.log
    sudo chmod 777 /var/log/install.log
    sudo setfacl -R -m u:$username:rwx /var/log/install.log
    sudo cp svxlink_install/install.sh ../
    echo -e "$(date)" "${YELLOW} #### On Board Sound Cards Removed #### ${NORMAL}" | tee -a  /var/log/install.log
    sudo chmod 777 /etc/modules
    echo blacklist snd_bcm2835 > /etc/modprobe.d/raspi-blacklist.conf
    sudo sed -i "s/options snd-usb/#options snd-usb/g" /lib/modprobe.d/aliases.conf
    sudo sed -i "s/dtoverlay=vc4-kms-v3d/dtoverlay=vc4-kms-v3d,noaudio/g" /boot/firmware/config.txt
    sudo cp /home/pi/svxlink_raspberry/configs/asound.conf /etc/modprobe.d/asound.conf
    echo snd-aloop > /etc/modules
    sudo cp /home/pi/svxlink_raspberry/configs/loopback.conf /etc/asound.conf
    sudo /sbin/alsactl force-reload
    echo -e "$(date)" "${YELLOW} #### Reboot - login and run ./install.sh #### ${NORMAL}" | tee -a  /var/log/install.log
    sudo shutdown -r now