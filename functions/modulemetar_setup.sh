#!/bin/bash
##### Metar Info #####
 airports=("EGLL" "EGKK" "EGCC" "EGBB" "EGSS" "EGPF" "EGPH" "EGPD" "EGPK" "EGHH" "EGHI" "EGNT" "EGNX" "EGGW" "EGGD" "EGCN" "EGNM" "EGNS" "EGAA" "EGBD")
   
height=$(( ${airports[@]} / 2))
width=78
whiptail --title "Metar Info" --yesno "Do you wish to configure this module?" 10 60
    if [ $? -eq 0 ]; then
    selected=$(whiptail --title "Metar Info" --checklist \
    "choose which Airports:" $height $width $(height - 1)) \
    "${airports[@]}" 3>&1 1>&2 2>&3
else
    exit 1
    fi
