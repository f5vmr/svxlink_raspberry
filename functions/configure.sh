#!/bin/bash
svxlink="$CONF"svxlink.conf
$(whiptail --title "SVXLink" --msgbox "$(cat config.txt)" 14 87 "OK" 2>&1 >/dev/null)

