#!/bin/bash

    install_locales() {
    if ! locale -a | grep -q "en_GB.UTF-8"; then
    sudo locale-gen en_GB.UTF-8
    fi
    
    if ! locale -a | grep -q "fr_FR.UTF-8"; then
    sudo locale-gen fr_FR.UTF-8
    fi
}

# Install locales
    sudo install_locales
    LANG_OPTION=$(whiptail --title "Language Option" --menu "Select Default Language" 10 78 2 \
        "1" "English - en_GB" \
        "2" "French - fr_FR" 3>&1 1>&2 2>&3)

    case ${LANG_OPTION} in
        1)
            LC_ALL="en_GB.UTF-8"
            LANG="en_GB.UTF-8"
            LANGUAGE="en_GB:en"
            ;;
        2)
            LC_ALL="fr_FR.UTF-8"
            LANG="fr_FR.UTF-8"
            LANGUAGE="fr_FR:fr:en_GB:en"
            ;;
        *)
            echo "ALERT" "${FUNCNAME}: unknown language option '${LANG_OPTION}'"
            ;;
    esac
    LC_PAPER="en_GB.UTF-8"  # default paper locale
    LESSCHARSET="utf-8"      # independent from locale
    MM_CHARSET="utf-8"       # independent from locale
    echo "locale settings" "${LANG}"
    export LC_ALL LANG LANGUAGE LC_PAPER LESSCHARSET MM_CHARSET

