#!/bin/bash
#### WHICH LANGUAGE ####
## lang_options en_GB or fr_FR ##
function which_language {

    LANG_OPTION=$(whiptail --title "Language Option" --menu "Select Default Language" 10 78 2 \
        "1" "English - en_GB" \
        "2" "French - fr_FR" 3>&1 1>&2 2>&3)

    if [ "$LANG_OPTION" -eq 1 ]; then
    #*        sudo sed -i 's/^# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen
    #*        sudo sed -i 's/^ fr_FR.UTF-8 UTF-8/# fr_FR.UTF-8 UTF-8/' /etc/locale.gen
    #*        sudo locale-gen
    #*        sudo update-locale LANG=en_GB.UTF-8
            echo "Language set to en_GB" | tee -a   /var/log/install.log
    elif [ "$LANG_OPTION" -eq 2 ]; then
    #*        sudo sed -i 's/^ en_GB.UTF-8 UTF-8/# en_GB.UTF-8 UTF-8/' /etc/locale.gen
    #*        sudo sed -i 's/^# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen
    #*        sudo locale-gen
    #*        sudo update-locale LANG=fr_FR.UTF-8
            echo "Langue maintenant fr_FR" | tee -a   /var/log/install.log
    else
        ## Default action if no valid option is selected
        echo "No valid option selected."
    fi

}


 



