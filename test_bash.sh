#!/bin/bash

## List of packages to install
PACKAGES=("app1" "app2" "app3" "app4" "app5")

## Total number of packages
TOTAL=${#PACKAGES[@]}

## Counter for progress
PROGRESS=0

## Function to update progress
#!/bin/bash

# Unload sound modules
sudo modprobe -r snd_bcm2835
sudo modprobe -r snd_usb_audio
sudo modprobe -r vc4
sudo modprobe -r snd-aloop

# Load sound modules in desired order
sudo modprobe snd_usb_audio
sudo modprobe snd_aloop
sudo modprobe snd_bcm2835
sudo modprobe vc4

# Reload ALSA configuration
sudo alsactl restore
