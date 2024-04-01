
# Function to check the user
usercheck() {
    # Get the current user
    local current_user
    current_user=$(get_current_user) >> /var/log/install.log 2>&1

    # Check if the current user is 'pi'
    if [ "$current_user" != "pi" ]; then
        echo "This script is only for the pi user. Please run with user pi."
        exit 1
    fi
}

