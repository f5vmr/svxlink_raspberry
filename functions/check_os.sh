#!/bin/bash

function check_os {
    # Retrieve the OS codename
    OS_name=$(lsb_release -c | grep -oP '(?<=Codename:\s)\w+')

    # Check if the OS is Bookworm
    if [ "$OS_name" != 'bookworm' ]; then
        whiptail --title "SVXLink" --msgbox "This script is only for the Bookworm Linux distribution.\n\n Shutdown and Change to OS Bookworm, with user pi." 8 78
        exit 1  # Exit the script if the OS is not Bookworm
        else
        whiptail --title "SVXLink" --msgbox "Success - You have OS $OS_name and user $LOGNAME" 8 78
    fi
}

