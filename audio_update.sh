#!/bin/bash
echo “blacklist snd_bcm2835” > /etc/modprobe.d/raspbi-blacklist.conf
sudo sed -i "s/options snd-usb/#options snd-usb/g" /lib/modprobe.d/aliases.conf

