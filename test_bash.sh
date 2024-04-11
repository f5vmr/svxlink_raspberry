#!/bin/bash

install_locale() {
        locale=$1
        if ! locale -a | grep -q "${locale}"; then
            sudo sh -c "locale-gen ${locale}"
        fi
    }
    
    # Install en_GB.UTF-8 locale if not available
    install_locale "en_GB.UTF-8"
    # Install fr_FR.UTF-8 locale if not available
    install_locale "fr_FR.UTF-8"
    # Install en_US.UTF-8 locale if not available
    install_locale "en_US.UTF-8"
    # Install es_ES.UTF-8 locale if not available
    install_locale "es_ES.UTF-8"
    # Set en_GB.UTF-8 as the default locale
    localectl set-locale LANG=en_GB.UTF-8

    echo Done