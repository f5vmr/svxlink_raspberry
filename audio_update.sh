#!/bin/bash
echo blacklist snd_bcm2835 > /etc/modprobe.d/raspi-blacklist.conf
sudo sed -i "s/options snd-usb/#options snd-usb/g" /lib/modprobe.d/aliases.conf
sudo sed -i "s/dtoverlay=vc4-kms-v3d/dtoverlay=vc4-kms-v3d,noaudio/g" /boot/config.txt

while true; do
        echo "Do you have a modified CM-108 USB Card? - Y/N "
        read yn
        case $yn in
                [Yy]* )
                echo "Ok, Let's add the updated rules"
                sudo cp svxlink_raspberry/cm-108.rules /etc/udev/rules.d/
                sudo udevadm control --reload-rules
                sudo udevadm trigger
                card=true
                break
                ;;
                [Nn]* )
                echo "ok, then I will make no other changes"
                card=false
                break
                ;;
                * ) echo "Please answer Y or N."
                ;;
        esac
        
done


                if [ $card=true ] ;
                then 
                echo "Modified CM-108 soundcard present"
                else
                echo "Normal USB soundcard present"
                fi
                
                echo "Audio Updates complete."


