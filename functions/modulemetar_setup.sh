#!/bin/bash
##### Metar Info #####
airports=(EGLL,EGKK,EGCC,EGBB,EGSS,EGPF,EGPH,EGPD,EGPK,EGHH,EGHI,EGNT,EGNX,EGGW,EGGD,EGCN,EGNM,EGNS,EGAA,EGBD)
    


whiptail --title "Metar Info" --yesno "Do you wish to configure this module?" 10 60
    if [ $? -eq 0 ]; then
    whiptail --title "Metar Info" --checklist $airports 20 78 \
    "EGLL" "EGLL" OFF \
    "EGKK" "EGKK" OFF \
    "EGCC" "EGCC" OFF \
    "EGBB" "EGBB" OFF \
    "EGSS" "EGSS" OFF \
    "EGPF" "EGPF" OFF \
    "EGPH" "EGPH" OFF \
    "EGPD" "EGPD" OFF \
    "EGPK" "EGPK" OFF \
    "EGHH" "EGHH" OFF \
    "EGHI" "EGHI" OFF \
    "EGNT" "EGNT" OFF \
    "EGNX" "EGNX" OFF \
    "EGGW" "EGGW" OFF \
    "EGGD" "EGGD" OFF \
    "EGCN" "EGCN" OFF \
    "EGNM" "EGNM" OFF \
    "EGNS" "EGNS" OFF \
    "EGAA" "EGAA" OFF \
    "EGBD" "EGBD" OFF 3>&1 1>&2 2>&3
else
    exit 1
    fi
