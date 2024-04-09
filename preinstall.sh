#/bin/bash
    home="/home/pi/svxlink_raspberry"
    echo $home
    cd $home  
    sudo apt install -y acl
    sudo touch /var/log/install.log
    sudo chmod 777 /var/log/install.log
    sudo setfacl -R -m u:pi:rwx /var/log/install.log
#*    
#*    sudo chmod 777 /etc/modules
#*    sudo sh -c 'echo "blacklist snd_bcm2835" > /etc/modprobe.d/raspi-blacklist.conf'
#*
#*    sudo sed -i "s/options snd-usb/#options snd-usb/g" /lib/modprobe.d/aliases.conf
#*    sudo sed -i "s/dtoverlay=vc4-kms-v3d/dtoverlay=vc4-kms-v3d,noaudio/g" /boot/firmware/config.txt
#*    sudo cp /home/pi/svxlink_raspberry/configs/asound.conf /etc/modprobe.d/asound.conf
#*    echo snd-aloop > /etc/modules
#*    sudo cp /home/pi/svxlink_raspberry/configs/loopback.conf /etc/asound.conf
#*    sudo mkdir /etc/alsa
#*    sudo touch /etc/alsa/state-daemon.conf
#*    sudo systemctl restart alsa-state.service
#*    echo "rebooting after soundcard configuration" >> /var/log/install.log
#*
#*    sudo shutdown -r now