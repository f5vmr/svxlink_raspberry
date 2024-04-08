#!/bin/bash

## Function to get IP address of an interface
get_ip_address() {
    local interface="$1"
    ip addr show dev "$interface" | awk '$1 == "inet" { print $2 }' | cut -d'/' -f1
}
function ipaddress {
## Get current IP addresses
eth_ip=$(get_ip_address "eth0")
wifi_ip=$(get_ip_address "wlan0")

## Check if IP addresses are empty
if [ -z "$eth_ip" ] || [ -z "$wifi_ip" ]; then
    echo "Error: Unable to determine IP addresses for Ethernet or Wi-Fi."
    exit 1
fi

## Update /etc/dhcpcd.conf with fixed IP addresses
#*sudo sed -i "/interface eth0/,+2 s/^static .*$/static ip_address=$eth_ip\/24/" /etc/dhcpcd.conf
#*sudo sed -i "/interface wlan0/,+2 s/^static .*$/static ip_address=$wifi_ip\/24/" /etc/dhcpcd.conf

echo "Fixed IP addresses updated in /etc/dhcpcd.conf:"
echo "Ethernet IP: $eth_ip"
echo "Wi-Fi IP: $wifi_ip"
}