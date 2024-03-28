#!/bin/bash
######## WHICH LANGUAGE ########
## options en_GB or fr_FR ##
function which_language() {
    OPTION=$(whiptail --title "$TITLE" --menu "Select Default Language" 14 78 3 \
        "1" "English - en_GB" \
        "2" "French - fr_FR" 3>&1 1>&2 2>&3)

    case $OPTION in
        1) ENGLISH_install=true;;
        2) ENGLISH_install=false;;
        *)
            # Default action if no valid option is selected
            echo "No valid option selected."
            ;;
    esac

    echo "Default Language: $OPTION"
}

