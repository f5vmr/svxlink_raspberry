#!/bin/bash
# Assign the codename from the output of lsb_release -c to a variable
codename=$(lsb_release -c | grep -oP '(?<=Codename:\s)\w+')

# Print the value of the variable
if[$codename !="bookworm"] then
whiptail --title "SVXLink" --msgbox "This script is only for the Bookworm Linux distribution.\n\n Shutdown and Change to OS Bookworm, with user pi." 10 60
exit
fi
# Assign the current user of the terminal to a variable
current_user=$(whoami)

# Print the value of the variable
if[$current_user != "pi"] then
whiptail --title "SVXLink" --msgbox "This script is only for the pi user. Shutdown and reload the OS with user pi" 10 60
exit
fi