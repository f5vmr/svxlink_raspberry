logname=`whoami`
########## CHECK OS ##########
source "${BASH_SOURCE%/*}/functions/check_os.sh"
check_os
########## CHECK USER ##########
#source "${BASH_SOURCE%/*}/functions/check_user.sh"
#usercheck
if [ "$logname" != "pi" ]; then echo "Please the reform the SDcard as user pi" ; exit; 
else whiptail --title "User check" --msgbox "User is pi" 8 78;
fi


sudo ./install_copy.sh
