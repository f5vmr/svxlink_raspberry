#!/bin/bash
function svxlink_source {
    cd /home/pi
    echo -e "$(date)" "${YELLOW} Svxlink_source is SvxLink from SM0SVX ${NORMAL}" >> /var/log/install.log
    sudo git clone https://github.com/sm0svx/svxlink.git
	sudo mkdir svxlink/src/build
}