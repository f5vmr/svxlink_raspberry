#!/bin/bash
function initialise {
CONF_DIR=/etc/svxlink/
LOG_DIR=/var/log/
PID_DIR=/var/run/
WWW_PATH=/var/www/
GUI_IDENTIFIER="SVXlink"
SVXLINK_VER="24.02"
SOUNDS_DIR=/usr/share/svxlink/sounds/
username=$USER
echo $usename
logname=$(whoami)
echo $logname
sudo touch /var/log/install.log
sudo chmod 777 /var/log/install.log
sudo setfacl -R -m u:$username:rwx /var/log/install.log
ls -l /var/log/install.log
echo "Commencing initialisation" 
}