#### INSTALLATION SCRIPT ####
# Setting non-superuser elements #
#### INITIALISE ####
home=/home/pi/svxlink_raspberry 	
cd $home
    sudo touch /var/log/install.log
    sudo chmod 777 /var/log/install.log
    sudo setfacl -R -m u:$username:rwx /var/log/install.log
    command 2>> /var/log/install.log
clear
source "${BASH_SOURCE%/*}/functions/initialise.sh"
initialise
#### CHECK OS ####
source "${BASH_SOURCE%/*}/functions/check_os.sh"
check_os
#### CHECK USER ####
source "${BASH_SOURCE%/*}/functions/check_user.sh"
usercheck
#### SuperUser Install ####
sudo ./install_main.sh
