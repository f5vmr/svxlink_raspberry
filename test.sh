#!/bin/bash

# Get the IP address and device (wlan0 or eth0)
ip_address=$(ip route get 1 | awk '{print $NF;exit}')
device=$(ip route get 1 | awk '{print $5;exit}')

# Print the IP address and device
echo "Current IP Address: $ip_address"
echo "Device: $device"

 


