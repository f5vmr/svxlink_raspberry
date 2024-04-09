#!/bin/bash
##### Metar Info #####
function modulemetar {
 airports=("EGLL" "EGKK" "EGCC" "EGBB" "EGSS" "EGPF" "EGPH" "EGPD" "EGPK" "EGHH" "EGHI" "EGNT" "EGNX" "EGGW" "EGGD" "EGCN" "EGNM" "EGNS" "EGAA" "EGBD")
 
metaryesno=(whiptail --title "Metar Info" --yesno "Do you wish to configure this module?" 8 78 3>&1 1>&2 2>&3)
    if [ metaryesno == "yes" ]; then
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
    #* sed -i "s/AIRPORTS/#AIRPORTS=/g" /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
    #* sudo sh -c 'echo "AIRPORTS=$selected"' >> /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
        sleep 1
        specific_airport=$(whiptail --title "Metar Info" --radiolist "Please specify the airport ICAO code for a default airport: " ${#airports} 27 78 20 \
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
        specific_airport=$(echo "$specific_airport" | sed 's/"//g')
        #* echo "STARTDEFAULT=$specific_airport" >> /etc/svxlink/svxlink.d/ModuleMetarInfo.conf
        #* sed -i "s/DEFAULT_LANG=en_US/DEFAULT_LANG=en_GB/g" /etc/svxlink/svxlink.d/ModuleMetarInfo.conf    
        echo -e "$(date)" "${GREEN} $selected Airports included with default Airport $specific_airport ${NORMAL}"
    fi
    else
    exit 1
    fi
}