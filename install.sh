########## INSTALLATION SCRIPT ##########
# Setting non-superuser elements #
########## INITIALISE ##########	 	
clear
source "${BASH_SOURCE%/*}/functions/initialise.sh"
initialise
########## CHECK OS ##########
source "${BASH_SOURCE%/*}/functions/check_os.sh"
check_os

########## CHECK USER ##########
source "${BASH_SOURCE%/*}/functions/check_user.sh"
usercheck
if [ "$logname" != "pi" ]; then echo "Please the reform the SDcard as user pi" ; exit; 
else whiptail --title "OS and user check" --msgbox "OS is $OS_name and User is $logname" 8 78;
fi
sudo ./install_main.sh
