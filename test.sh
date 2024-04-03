#!/bin/bash
# Run aplay -l and capture the output
config_file="functions/config.txt"
whiptail  --title "SVXLink Configuration"  --textbox $config_file 8 78 --scrolltext --ok-button "OK" 10 78
whiptail --title "Sound Card" --msgbox "This script will determine the USB soundcard's location. It will then display the location in the terminal." 8 78

output=$(aplay -l)

# Use grep to find the line containing the desired sound card
line=$(echo "$output" | grep "USB Audio")

# Extract the card number from the line
card_number=$(echo "$line" | awk '{print $2}' | tr -d ':')
whiptail --title "Sound Card" --msgbox "The USB soundcard is located at card $card_number." 8 78



#