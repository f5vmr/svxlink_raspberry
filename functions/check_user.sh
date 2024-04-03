#!/bin/bash
# Function to check the user
#function get_current_user() {
#    echo $(logname)
#}
function usercheck {
    # Get the current user
    current_user=$(logname) >> /var/log/install.log
    
    # Check if the current user is 'pi'
    if [ "$current_user" != "pi" ]; then
        echo "This script is only for the pi user. Please re-install OS Bookworm with user pi."
        exit 1
    fi
}

