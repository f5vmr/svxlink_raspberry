#!/bin/bash
install_locale() {
    locale=$1.UTF-8
    if [ ! -e "/usr/lib/locale/${locale}" ]; then
        sudo locale-gen ${locale}
    fi
}

# Install locales
install_locale "en_GB"
install_locale "fr_FR"
install_locale "en_US"
install_locale "es_ES"
