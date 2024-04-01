#!/bin/bash


function get_current_user() {
    if [ -n "$SUDO_USER" ]; then
        user=$SUDO_USER
    else
        echo "$(logname)"
    fi
}
