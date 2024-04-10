#!/bin/bash
sudo touch /etc/sudoers.d/svxlink
LINES=("svxlink ALL=NOPASSWD: /usr/sbin/service" "svxlink ALL=NOPASSWD: /bin/cp" "svxlink ALL=NOPASSWD: /bin/chown" "svxlink ALL=NOPASSWD: /bin/chmod" "svxlink ALL=NOPASSWD: /bin/systemctl" "svxlink ALL=NOPASSWD: /bin/reboot" "svxlink ALL=NOPASSWD: /bin/shutdown" )
 
 ## Add each line to sudoers
 for item in "${LINES[@]}"; do
     echo "$item" | sudo tee -a /etc/sudoers.d/svxlink >/dev/null
 done

## Check sudoers file syntax
 sudo visudo -c

## Check if syntax check passed

    echo "Lines added to sudoers successfully."


