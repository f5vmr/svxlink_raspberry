#### INSTALLATION SCRIPT ####
# Setting non-superuser elements #
#### INITIALISE ####
home=/home/pi
cd $home

 # clear
source "${BASH_SOURCE%/*}/functions/initialise.sh"
initialise
#### CHECK OS ####
source "${BASH_SOURCE%/*}/functions/check_os.sh"
check_os
#### CHECK USER ####
source "${BASH_SOURCE%/*}/functions/check_user.sh"
usercheck
echo -e "${GREEN} OS = $OS_name and Current user is $logname${NORMAL}" | tee -a  /var/log/install.log
#### SuperUser Install ####
sudo ./svxlink_raspberry/install_main.sh

