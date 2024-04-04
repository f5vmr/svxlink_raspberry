#!/bin/bash
##### Metar Info #####
 airports=("EGLL" "EGKK" "EGCC" "EGBB" "EGSS" "EGPF" "EGPH" "EGPD" "EGPK" "EGHH" "EGHI" "EGNT" "EGNX" "EGGW" "EGGD" "EGCN" "EGNM" "EGNS" "EGAA" "EGBD")
 
whiptail --title "Metar Info" --yesno "Do you wish to configure this module?" 10 60
    if [ $? -eq 0 ]; then
selected[@]=$(whiptail --title "Metar Info" --checklist "choose which Airports:" $airports 10 78  \
        "EGLL" "London Heathrow" OFF \
        "EGKK" "London Gatwick" OFF \
        "EGCC" "Manchester" OFF \
        "EGBB" "Birmingham" OFF \
        "EGSS" "London Stansted" OFF \
        "EGPF" "Glasgow" OFF \
        "EGPH" "Edinburgh" OFF \
        "EGPD" "Aberdeen Dyce" OFF \
        "EGPK" "Prestwick" OFF \
        "EGHH" "Bournemouth" OFF \
        "EGHI" "Southampton" OFF \
        "EGNT" "Newcastle" OFF \
        "EGNX" "East Midlands" OFF \
        "EGGW" "London Luton" OFF \
        "EGGD" "Bristol" OFF \
        "EGCN" "Sheffield" OFF \
        "EGNM" "Leeds Bradford" OFF \
        "EGNS" "Ronaldsway" OFF \
        "EGAA" "Belfast Aldergrove" OFF \
        "EGBD" "Belfast City" OFF 3>&1 1>&2 2>&3)
      
    else
    exit 1
    fi
