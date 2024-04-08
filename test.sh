#!/bin/bash

# Get the IPv4 address and device (wlan0 or eth0)
ip_address=$(ip -4 route get 1 | grep -oP 'src \K\S+')
device=$(ip -4 route get 1 | grep -oP 'dev \K\S+')

# Print the IPv4 address and device
echo "Current IPv4 Address: $ip_address"
echo "Device: $device"


 


