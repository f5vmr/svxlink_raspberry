#!/bin/bash
##### Metar Info #####
 airports=("EGLL" "EGKK" "EGCC" "EGBB" "EGSS" "EGPF" "EGPH" "EGPD" "EGPK" "EGHH" "EGHI" "EGNT" "EGNX" "EGGW" "EGGD" "EGCN" "EGNM" "EGNS" "EGAA" "EGBD")
 
whiptail --title "Metar Info" --yesno "Do you wish to configure this module?" 8 78
    if [ $? -eq 0 ]; then
selected=$(whiptail --title "Metar Info" --checklist "choose which Airports:" 27 78 20 \
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
        selected=$(echo "$selected" | sed 's/"//g')
        selected=$(echo "$selected" | tr ' ' ',')
    sed -i "s/airports=/#airports=/g" /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
    echo "airports=$selected" >> /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
    specifyairport(whiptail --title "Metar Info" --radiolist "Please specify the airport ICAO code for a default airport: " ${#airports} 27 78 20)
    

      
      
      #$selected 
    else
    exit 1
    fi
