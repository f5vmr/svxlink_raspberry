#!/bin/bash
svxlink="$CONF"svxlink.conf
whiptail --title "SVXLink" --msgbox "$(cat config.txt)" 20 87 "OK" 2>&1 >/dev/null


