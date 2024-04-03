logname=`whoami`
########## INITIALISE ##########	 	
clear
source "${BASH_SOURCE%/*}/functions/initialise.sh"
initialise
########## CHECK OS ##########
source "${BASH_SOURCE%/*}/functions/check_os.sh"
check_os
exit
########## CHECK USER ##########
#source "${BASH_SOURCE%/*}/functions/check_user.sh"
#usercheck
if [ "$logname" != "pi" ]; then echo "Please the reform the SDcard as user pi" ; exit; 
else whiptail --title "User check" --msgbox "User is pi" 8 78;
fi

sudo sh -c 'echo "OS is $OS_name and User is $current_user" >> /var/log/install.log'

sudo ./install_copy.sh
