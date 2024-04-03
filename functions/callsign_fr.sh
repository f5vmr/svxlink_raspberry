#!/bin/bash
function callsign {
get_CallVar() {
    call=$(whiptail --inputbox "Taper l'indicatif du noed:" 8 78 3>&1 1>&2 2>&3)
    echo "$call"
}


while true; do
    user_input=$(get_CallVar)
    
    # Check if input is empty
    if [ -z "$user_input" ]; then
        whiptail --msgbox "L'indicatif du Noed ne doit pas vide. Essayé encore une fois." 8 78
    else
        # If input is not empty, break the loop
        break
    fi
done
CALL=${user_input^^}
# Use the non-empty name

	sudo sh -c 'echo $(date) ${GREEN} *** Creation du Noed " $CALL " *** ${NORMAL} >> /var/log/install.log'  
}