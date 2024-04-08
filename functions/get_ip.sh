#!/bin/bash

function ipaddress {
## Get current IP addresses


# Get the IPv4 address and device (wlan0 or eth0)
ip_address=$(ip -4 route get 1 | grep -oP 'src \K\S+') >> /var/log/install.log
device=$(ip -4 route get 1 | grep -oP 'dev \K\S+') >> /var/log/install.log


## Update /etc/dhcpcd.conf with fixed IP addresses
#*sudo sed -i "/interface $device/,+2 s/^static .*$/static ip_address=$ip_address\/24/" /etc/dhcpcd.conf

echo -e "$(date)" "${GREEN} Fixed IP address $ip_address with $device updated in /etc/dhcpcd.conf:${NORMAL}" >> /var/log/install.log

}