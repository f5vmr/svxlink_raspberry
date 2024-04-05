#!/bin/bash
svxlink="$CONF"svxlink.conf
file=config_fr.txt
whiptail --title "SVXLink" --msgbox "$(cat $file)" 20 70 "OK" 2>&1 


