#!/bin/bash
########## INIT ##########
source ./functions/init.sh
welcome_message
install_dependencies
#kill_sound_cards
get_CallVar
echo $CALL
node_type
echo $OPTION
query_network
source ./functions/language.sh
which_language
source  ./functions/init.sh
menu_end
exit
#