#!/bin/bash
## here we install the dashboard to /var/www


function install_dash {
    ## install the dashboard
    cd /var/www
    sudo git clone https://github.com/f5vmr/SVXLink-Dash-V2 html
    ## change ownership of the dashboard
    sudo chown -R svxlink:svxlink html
    ## change permissions of the dashboard
    sudo chmod -R 755 html
    ## change Apache2 permissions
    cd /etc/apache2/
    sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=svxlink/g' envvars
    sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=svxlink/g' envvars
    cd /usr/lib/systemd/system/
    sed -i 's/PrivateTmp=true/PrivateTmp=false/g' apache2.service
    ## restart Apache2
    sudo systemctl daemon-reload
    sudo systemctl restart apache2.service
    ## Dashboard Permissions
    whiptail --title "Dashboard Permissions" --yesno "Do you want to add permissions to the dashboard?" 8 78
    if [ $? -eq 0 ]; then
    ## add permissions to the dashboard
    sudo chmod -R 777 /var/www/html/config.inc.php
    dashboard_user=$(whiptail --title "Dashboard User" --inputbox "Enter the username of the dashboard user" 8 78 svxlink 3>&1 1>&2 2>&3)
    dashboard_pass=$(whiptail --title "Dashboard Password" --passwordbox "Enter the password of the dashboard user" 8 78 3>&1 1>&2 2>&3)
    sed -i "s/"svxlink"/"$dashboard_user"/g" /var/www/html/include/config.inc.php
    sed -i "s/"svxlink"/"$dashboard_pass"/g" /var/www/html/include/config.inc.php
    ## permissions added

## Define the lines to add to sudoers
LINES=(
    "svxlink ALL=NOPASSWD: /usr/sbin/service"
    "svxlink ALL=NOPASSWD: /bin/cp"
    "svxlink ALL=NOPASSWD: /bin/chown"
    "svxlink ALL=NOPASSWD: /bin/chmod"
    "svxlink ALL=NOPASSWD: /bin/systemctl"
    "svxlink ALL=NOPASSWD: /bin/reboot"
    "svxlink ALL=NOPASSWD: /bin/shutdown"
)

## Backup sudoers file
sudo cp /etc/sudoers /etc/sudoers.bak

## Add each line to sudoers
for LINE in "${LINES[@]}"; do
    echo "$LINE" | sudo tee -a /etc/sudoers >/dev/null
done

## Check sudoers file syntax
sudo visudo -c

## Check if syntax check passed
if [ $? -eq 0 ]; then
    echo "Lines added to sudoers successfully."
else
    echo "Error: Failed to add lines to sudoers. Restoring backup."
    sudo cp /etc/sudoers.bak /etc/sudoers
fi
## Add permissions to Apache2

## Determine IP address of eth0 and Wifi interface


}