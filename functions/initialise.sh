#!/bin/bash
function initialise {
clear  
CONF_DIR=/etc/svxlink/
LOG_DIR=/var/log/
PID_DIR=/var/run/
WWW_PATH=/var/www/
GUI_IDENTIFIER="SVXlink"
SVXLINK_VER="24.02"
SOUNDS_DIR=/usr/share/svxlink/sounds/
username=$USER
sudo touch /var/log/install.log
setfacl -R -m u:$username:rwx $LOG_DIR
echo "Commencing initialisation" 


}