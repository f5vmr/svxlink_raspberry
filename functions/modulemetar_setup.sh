#!/bin/bash

##### Metar Info #####

# Define options for the checklist
airports=("EGLL" "EGKK" "EGCC" "EGBB" "EGSS" "EGPF" "EGPH" "EGPD" "EGPK" "EGHH" "EGHI" "EGNT" "EGNX" "EGGW" "EGGD" "EGCN" "EGNM" "EGNS" "EGAA" "EGBD")
   
# Calculate the height of the checklist window
height=$(( ${#airports[@]} / 2 + 1)) # Add 1 to ensure height is at least 1
width=78

# Ask the user if they wish to configure the module
whiptail --title "Metar Info" --yesno "Do you wish to configure this module?" 10 60
if [ $? -eq 0 ]; then
    # Show the checklist with custom formatting
    selected=$(whiptail --title "Metar Info" --checklist \
        "Choose which Airports:" $height $width $((height - 1)) \
        "${airports[@]}" 3>&1 1>&2 2>&3)

    # Display selected options
    echo "Airports selected:"
    for choice in "${selected[@]}"; do
        echo "- $choice"
    done
else
    exit 1
fi
