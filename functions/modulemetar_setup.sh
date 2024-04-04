#!/bin/bash
##### Metar Info #####
 airports=("EGLL" "EGKK" "EGCC" "EGBB" "EGSS" "EGPF" "EGPH" "EGPD" "EGPK" "EGHH" "EGHI" "EGNT" "EGNX" "EGGW" "EGGD" "EGCN" "EGNM" "EGNS" "EGAA" "EGBD")
 
whiptail --title "Metar Info" --yesno "Do you wish to configure this module?" 10 60
    if [ $? -eq 0 ]; then
selected=$(whiptail --title "Metar Info" --checklist \
    "choose which Airports:" 30 78  \
        1 "EGLL" \
        2 "EGKK" \
        3 "EGCC" \
        4 "EGBB" \
        5 "EGSS" \
        6 "EGPF" \
        7 "EGPH" \
        8 "EGPD" \
        9 "EGPK" \
        10 "EGHH" \
        11 "EGHI" \
        12 "EGNT" \
        13 "EGNX" \
        14 "EGGW" \
        15 "EGGD" \
        16 "EGCN" \
        17 "EGNM" \
        18 "EGNS" \
        19 "EGAA" \
        20 "EGBD"  3>&1 1>&2 2>&3)

    

else
    exit 1
    fi
