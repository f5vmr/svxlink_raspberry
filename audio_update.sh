#!/bin/bash
echo blacklist snd_bcm2835 > /etc/modprobe.d/raspi-blacklist.conf
sudo sed -i "s/options snd-usb/#options snd-usb/g" /lib/modprobe.d/aliases.conf

while true; do
	echo -e "Do you have a modified CM-108 USB Card?}"
	read -p "Yes I have (y/N) " yn
	case $yn in
		[Yy] ) echo ok, Let's add the updated rules - ; 
		sudo cp cm-108.rules /etc/udev/rules.d/
		sudo udevadm control --reload-rules
		sudo udevadm trigger
    CM=1
		break
	esac
done
break

if $CM=1 then echo "Modified CM-108 soundcard present"
fi
echo "Audio Updates complete."


