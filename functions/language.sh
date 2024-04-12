#!/bin/bash
#### WHICH LANGUAGE ####
## lang_options en_GB or fr_FR ##

function which_language{
            set_locale() {
            locale=$1.UTF-8
            if [ ! -e "/usr/lib/locale/${locale}" ]; then
                sudo locale-gen ${locale}
            fi
}

          

    LANG_OPTION=$(whiptail --title "Language Option" --menu "Select Language" 10 78 2 \
        "1" "English - en_GB" \
        "2" "French - fr_FR" \
    
    # Set locale based on user's choice
    case ${LANG_OPTION} in
    1)
        set_locale "en_GB.UTF-8"
        ;;
    2)
        set_locale "fr_FR.UTF-8"
        ;;
    3)
        set_locale "es_ES.UTF-8"
        ;;
    *)
        echo "Invalid choice"
        ;;
    esac

    echo "${GREEN} #### Language set to $LANG_OPTION #### ${NORMAL}" | tee -a /var/log/install.log
    }




 



