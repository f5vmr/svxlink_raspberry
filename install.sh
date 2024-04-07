#### INSTALLATION SCRIPT ####
# Setting non-superuser elements #
#### INITIALISE ####
home=/home/pi/svxlink_raspberry
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
cd $home
#### SuperUser Install ####
sudo ./install_main.sh
