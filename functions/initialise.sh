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
logname=$(whoami)

echo -e $(date) "Commencing initialisation" >> /var/log/install.log
}