#!/bin/bash
## Assign the codename from the output of lsb_release -c to a variable
function check_os {
 
OS_name=$(lsb_release -c | grep -oP '(?<=Codename:\s)\w+')

## Print the value of the variable
if [ $OS_name != 'bookworm' ]; then
whiptail --title "SVXLink" --msgbox " Ce scénario est uniquement pour la distribution Linux Bookworm.\n\n Il faut re-faire la carte-SD au OS Bookworm, avec user pi." 8 78
fi
## Assign the current user of the terminal to a variable
current_user=$(whoami)

## Print the value of the variable
if [ $current_user != "pi" ]; then
whiptail --title "SVXLink" --msgbox "Ce scénario est uniquement pour le user pi. Il faut re-télécharger le OS BOOKWORM avec user pi" 8 78
fi
} 