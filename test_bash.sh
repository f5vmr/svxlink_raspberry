#!/bin/bash

# List of packages to install
PACKAGES=("app1" "app2" "app3" "app4" "app5")

# Total number of packages
TOTAL=${#PACKAGES[@]}

# Counter for progress
PROGRESS=0

# Function to update progress
update_progress() {
    PROGRESS=$((PROGRESS + 1))
    echo "$(($PROGRESS * 100 / $TOTAL))"
}

# Loop through packages and install them
for package in "${PACKAGES[@]}"; do
    sudo apt install -y "$package" > /dev/null 2>&1
    update_progress | whiptail --backtitle "Installing" --title "Installation Progress" --gauge "Installing $package" 6 60 0
done

# All packages installed
whiptail --backtitle "Installing" --title "Installation Progress" --msgbox "All packages installed successfully!" 6 60
