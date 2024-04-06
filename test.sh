#!/bin/bash
echo aplay -l 
sudo chmod 777 /etc/modules
# echo blacklist snd_bcm2835 > /etc/modprobe.d/raspi-blacklist.conf
# sudo sed -i "s/options snd-usb/#options snd-usb/g" /lib/modprobe.d/aliases.conf
# sudo sed -i "s/dtoverlay=vc4-kms-v3d/dtoverlay=vc4-kms-v3d,noaudio/g" /boot/firmware/config.txt
# sudo cp /home/pi/svxlink_raspberry/configs/asound.conf /etc/modprobe.d/asound.conf
# echo snd-aloop > /etc/modules
# sudo cp /home/pi/svxlink_raspberry/configs/loopback.conf /etc/asound.conf
# sudo /sbin/alsactl nrestore


# Run lsusb and filter lines containing "Audio Adapter"
audio_lines=$(lsusb | grep "Audio Adapter")

# Regular expression to extract IDs
pattern="ID (\w+):(\w+)"

# Extract IDs from each line
while read -r line; do
    if [[ $line =~ $pattern ]]; then
        vendor_id="${BASH_REMATCH[1]}"
        product_id="${BASH_REMATCH[2]}"
        echo "Vendor ID: $vendor_id, Product ID: $product_id"

        # Create or append to the 99-usb-sound.rules file
        echo "# Match USB sound card" > /etc/udev/rules.d/99-usb-sound.rules
        echo "SUBSYSTEM==\"sound\", ATTRS{idVendor}==\"$vendor_id\", ATTRS{idProduct}==\"$product_id\", SYMLINK+=\"usb_sound_card\"" >> /etc/udev/rules.d/99-usb-sound.rules
        echo "" >> /etc/udev/rules.d/99-usb-sound.rules

        # Reload udev rules
        sudo udevadm control --reload-rules
        sudo udevadm trigger

        echo "Rule created and udev rules reloaded."
    fi
done <<< "$audio_lines"
