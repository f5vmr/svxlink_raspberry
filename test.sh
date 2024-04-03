#!/bin/bash
# Run aplay -l and capture the output

whiptail --scrolltext --title "SVXLink Configuration"  --txtbox "$(cat config.txt)" 8 80 
whiptail --title "Sound Card" --msgbox "This script will determine the USB soundcard's location. It will then display the location in the terminal." 8 78

output=$(aplay -l)

# Use grep to find the line containing the desired sound card
line=$(echo "$output" | grep "USB Audio")

# Extract the card number from the line
card_number=$(echo "$line" | awk '{print $2}' | tr -d ':')

echo "The USB soundcard is located at card $card_number."


#