#!/bin/bash

# Function to check if a locale is already available
is_locale_available() {
    locale=$1.UTF-8
    if locale -a | grep -q "^${locale}$"; then
        return 0  # Locale is available
    else
        return 1  # Locale is not available
    fi
}

# Function to install locales if not already available
install_locale() {
    locale=$1
    if ! is_locale_available "$locale"; then
        echo "Generating ${locale}.UTF-8 locale..."
        sudo locale-gen ${locale}.UTF-8
        return 0  # Locale generated
    else
        echo "${locale}.UTF-8 locale is already available."
        return 1  # Locale already available
    fi
}

# Install locales
locales=("en_GB" "fr_FR" "en_US" "es_ES")
locales_to_generate=()
for locale in "${locales[@]}"; do
    if ! is_locale_available "$locale"; then
        locales_to_generate+=("$locale")
    fi
done

if [ ${#locales_to_generate[@]} -gt 0 ]; then
    for locale in "${locales_to_generate[@]}"; do
        install_locale "$locale"
    done
fi

# Set en_GB.UTF-8 as the default locale
sudo localectl set-locale LANG=en_GB.UTF-8

echo "Locale setup completed. Rebooting..."

