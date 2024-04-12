#!/bin/bash

# Function to install locales if not already available
install_locale() {
    locale=$1.UTF-8
    if ! locale -a | grep -q "^${locale}$"; then
        sudo locale-gen ${locale}
    fi
}

# Install locales
install_locale "en_GB"
install_locale "fr_FR"
install_locale "en_US"
install_locale "es_ES"

# Set en_GB.UTF-8 as the default locale
sudo localectl set-locale LANG=en_GB.UTF-8

echo "Locale setup completed. Rebooting..."
sudo reboot
