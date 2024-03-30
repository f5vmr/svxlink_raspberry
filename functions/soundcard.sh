#!/bin/bash
function soundcard {
card=false
#!/bin/bash

# Run lsusb and filter the output to check for a USB sound card
lsusb_output=$(lsusb)

# Check if the USB sound card is present in the lsusb output
if echo "$lsusb_output" | grep -q "your_sound_card_identifier"; then
    echo "USB sound card is present."
    USB_sound_card_present=true
else
    echo "USB sound card is not present."
    USB_sound_card_present=false
fi

# Assign the presence of the USB sound card to a variable
if [ "$USB_sound_card_present" = true ]; then
    # If USB sound card is present, assign some value to a variable
    sound_card_variable="your_value_for_sound_card_present"
else
    # If USB sound card is not present, assign another value to the variable
    sound_card_variable="your_value_for_sound_card_absent"
fi

# Print the assigned variable value
echo "Variable assigned: $sound_card_variable"
exit
if whiptail --title "USB Soundcard" --yesno "Do you have a modified CM108 Soundcard or Similar." 8 78; then
    echo "Ok, Let's add the updated rules"
                sudo cp svxlink_raspberry/cm-108.rules /etc/udev/rules.d/
                sudo udevadm control --reload-rules
                sudo udevadm trigger
                card=true
else
    echo "ok, then I will make no other changes"
                card=false
fi



                if [ "$card" = true ] ;
                then 
                echo "Modified CM-108 soundcard present"
                else
                echo "Normal USB soundcard present"
                fi
                
                echo "Audio Updates including Dummy Sound Card for Darkice complete."
				echo soundcard="*** $card ***"	>> /var/log/install.log
}