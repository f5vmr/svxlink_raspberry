#!/bin/bash
function svxlink_source {
    cd /home/pi
    sudo git clone https://github.com/sm0svx/svxlink.git
	sudo mkdir svxlink/src/build
}