#!/bin/bash
#### Recall options
function nodeset {
    if [ $NODE_OPTION  == "1" ]; then 
    node="Simplex without Svxreflector"
    elif [ $NODE_OPTION  == "2" ]; then
    node="Simplex with Svxreflector"
    elif [ $NODE_OPTION  == "3" ]; then
    node="Repeater without Svxreflector"
    elif [ $NODE_OPTION  == "4" ]; then
    node="Repeater with Svxreflector"
    else    
    node="unset"
fi
whiptail --title "Node" --msgbox "You have select node-type $node" 8 78 --defaultyes
# Time to change the node
if [ $NODE_OPTION  == "1" ]; then
sed -i 's/LOGICS=SimplexLogic,ReflectorLogic/LOGICS=SimplexLogic/g' /etc/svxlink/svxlink.conf
sed -i 's/LINKS=/#LINKS=/g' /etc/svxlink/svxlink.conf
elif [ $NODE_OPTION  == "2" ]; then
auth_key=$(whiptail --passwordbox "Please enter your SvxReflector Key" 8 78 --title "password dialog" 3>&1 1>&2 2>&3)
sed -i 's/AUTH_KEY="GET YOUR OWN KEY"/AUTH_KEY="$auth_key"/g' /etc/svxlink/svxlink.conf 
elif [ $NODE_OPTION  == "3" ]; then
sed -i 's/set for SimplexLogic/set for RepeaterLogic/g' /etc/svxlink/svxlink.conf
sed -i 's/LOGICS=SimplexLogic,ReflectorLogic/LOGICS=RepeaterLogic/g' /etc/svxlink/svxlink.conf
sed -i 's/LINKS=/#LINKS=/g' /etc/svxlink/svxlink.conf
elif [ $NODE_OPTION  == "4" ]; then
sed -i 's/set for SimplexLogic/set for RepeaterLogic/g' /etc/svxlink/svxlink.conf
sed -i 's/LOGICS=SimplexLogic/LOGICS=RepeaterLogic/g' /etc/svxlink/svxlink.conf
auth_key=$(whiptail --passwordbox "Please enter your SvxReflector Key" 8 78 --title "password dialog" 3>&1 1>&2 2>&3)
sed -i 's/AUTH_KEY="GET YOUR OWN KEY"/AUTH_KEY="$auth_key"/g' /etc/svxlink/svxlink.conf 
else
node="unset"
fi
#That's the Logics taken care of now we need to change the sound card settings 
output=$(aplay -l)

# Use grep to find the line containing the desired sound card
line=$(echo "$output" | grep "USB Audio")

# Extract the card number from the line
card_number=$(echo "$line" | awk '{print $2}' | tr -d ':')
whiptail --title "Sound Card" --msgbox "The USB soundcard is located at card $card_number." 8 78

# Use sed to replace the line with the new one even if there is no change

sed -i 's/AUDIO_DEV=alsa:plughw:0/AUDIO_DEV=alsa:plughw:$card_number/g' /etc/svxlink/svxlink.conf
# so even if it is '0' it is still '0'
# now we need to change the settings for COS and Squelch.
# We need to check if the Squelch is set to '1' or '0'
    # if it is '1' then we need to change it to '0'
    # if it is '0' then we need to change it to '1'
# we need to do this for both the Simplex and Repeater
# We need to check if the COS is set to '0' or '1'
    # if it is '0' then we need to change it to '1'
    # if it is '1' then we need to change it to '0'
    # WE have three options
        # 1. GPIOD on Transmit and Receive determined by $HID=false $GPIOD=true $card=false
        # 2. HID on Transmit and GPIOD on Receive determined by $HID=true $GPIOD=true $card=true
        # 3. HID on Transmit and Receive determined by $HID=true $GPIOD=false $card=true
if [$HID == "false"] && [$GPIOD == "true"] && [$card == "false"]
then
#need to change the PTT and COS to GPIOD and all the statements to reflect this Unmodified SOundCard Unit - ask for GPIOD pins
elif [$HID == "true"] && [$GPIOD == "true"] && [$card == "true"]
then
#need to change the PTT to HID and COS to GPIOD and all the statements to reflect this modified SoundCard Unit - ask for GPIOD pins
elif [$HID == "true"] && [$GPIOD == "false"] && [$card == "true"]
#need to change the PTT and COS to HID and all the statements to reflect this modified SoundCard Unit - ask for GPIOD pins




}

# Function to get IP address of an interface
get_ip_address() {
    local interface="$1"
    ip addr show dev "$interface" | awk '$1 == "inet" { print $2 }' | cut -d'/' -f1
}

# Get current IP addresses
eth_ip=$(get_ip_address "eth0")
wifi_ip=$(get_ip_address "wlan0")

# Check if IP addresses are empty
if [ -z "$eth_ip" ] || [ -z "$wifi_ip" ]; then
    echo "Error: Unable to determine IP addresses for Ethernet or Wi-Fi."
    exit 1
fi

# Update /etc/dhcpcd.conf with fixed IP addresses
sudo sed -i "/interface eth0/,+2 s/^static .*$/static ip_address=$eth_ip\/24/" /etc/dhcpcd.conf
sudo sed -i "/interface wlan0/,+2 s/^static .*$/static ip_address=$wifi_ip\/24/" /etc/dhcpcd.conf

echo "Fixed IP addresses updated in /etc/dhcpcd.conf:"
echo "Ethernet IP: $eth_ip"
echo "Wi-Fi IP: $wifi_ip"
'