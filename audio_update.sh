#!/bin/bash
echo “blacklist snd_bcm2835” > /etc/modprobe.d/raspbi-blacklist.conf
sudo sed -i ’s/options snd-usb-audio index=-2/#options snd-usb-audio index=-2/‘ /lib/modprobe.d/aliases.conf

