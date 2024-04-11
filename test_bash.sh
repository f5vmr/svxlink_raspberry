#!/bin/bash

    # Install en_GB.UTF-8 locale if not available
    sudo sh -c "locale-gen en_GB.UTF-8"
    # Install fr_FR.UTF-8 locale if not available
    sudo sh -c "locale-gen fr_FR.UTF-8"
    # Install en_US.UTF-8 locale if not available
    sudo sh -c "locale-gen en_US.UTF-8"
    # Install es_ES.UTF-8 locale if not available
    sudo sh -c "locale-gen es_ES.UTF-8"
    # Set en_GB.UTF-8 as the default locale
    localectl set-locale LANG=en_GB.UTF-8

    echo Done