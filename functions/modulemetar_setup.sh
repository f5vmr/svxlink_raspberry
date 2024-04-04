#!/bin/bash

##### Metar Info #####

# Define options for the checklist
airports=("EGLL" "EGKK" "EGCC" "EGBB" "EGSS" "EGPF" "EGPH" "EGPD" "EGPK" "EGHH" "EGHI" "EGNT" "EGNX" "EGGW" "EGGD" "EGCN" "EGNM" "EGNS" "EGAA" "EGBD")

# Calculate the height and width of the checklist window
height=$(( ${#airports[@]} + 2)) # Add 2 to account for title and button row
width=80

# Ask the user if they wish to configure the module
if whiptail --title "Metar Info" --yesno "Do you wish to configure this module?" 10 60; then
    # Construct the options list for whiptail with manual multicolumn formatting
    options=()
    for airport in "${airports[@]}"; do
        options+=("$airport" "$airport")
    done

    # Show the checklist with custom formatting
    selected=$(whiptail --title "Metar Info" --separate-output --checklist \
        "Choose which Airports:" $height $width $((height - 5)) \
        "${options[@]}" 3>&1 1>&2 2>&3)

    # Display selected options
    echo "Airports selected:"
    for choice in $selected; do
        echo "- $choice"
    done
else
    exit 1
fi


