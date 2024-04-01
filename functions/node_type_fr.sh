#!/bin/bash
node=false
function nodeoption {
    NODE_OPTION=$(whiptail --title "Svxlink" --menu "SVP choisir le type de noed vous desirez?" 8 78 5 \
            "1" " Simplex Noed sans SvxReflecteur" \
            "2" " Simplex Noed avec SvxReflecteur" \
            "3" "Repeater Noed sans SvxReflecteur" \
            "4" "Repeater Noed avec SvxReflecteur" 3>&1 1>&2 2>&3)

    if [ "$NODE_OPTION" -eq 1 ]; then
        echo "Choisi Noed Simplex sans SvxReflecteur"
    elif [ "$NODE_OPTION" -eq 2 ]; then
        echo "Choisi Noed Simplex avec SvxReflecteur"
    elif [ "$NODE_OPTION" -eq 3 ]; then
        echo "Choisi Noed Répéteur sans SvxReflecteur"
    elif [ "$NODE_OPTION" -eq 4 ]; then
        echo "Coisi Noed Répéteur avec SvxReflecteur"
    else 
        echo "N'aucune option choisie"
fi
node=true
}
            
