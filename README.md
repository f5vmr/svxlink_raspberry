# svxlink_raspberry
Script build for Raspberry Pi - Repeater or Hotspot.

Requirements: Raspberry Pi of any mark. USB Soundcard, and an interface card. One or two transceivers (3 or 4 if you are making a double repeater, for which you will need a second USB soundcard.)

There are few raspberry images that work succesfully for this type of build, where there is a potential for using the eventual application in several directions.

Whilst this in itself is not an image, it will take the hard work out of the physical compilation, although leaves a little work for the user to place the finishing touches to the final assembly.

There are a number of available interface boards that have a variety of uses, either as a hotspot or a repeater, or even a fill-in receiver/transceiver for an existing SVXLink repeater. The settings in this build are for a homebrew interface board using GPIO 23 for the Receive COS and GPIO 24 for the PTT controller.
When using the GPIO Pins, an earth pin is also require, so using this combination, pins 14,16 and 18 are all adjacent and ideally placed for these functions.
Pin 14 is the Earth, Pin 16 is GPIO 23 and Pin 18 is GPIO 24.

For a second set of transceivers, you can consider GPIO 17 and 18 as COS & PTT for those. 

A copy of the design can be found on g4nab.co.uk.

Start with a download of Raspberry OS Lite from RaspberryPi.org. Then use a 16 GB MicroSD Card and transfer the image to the card by one of the proprietary image writers. Prior to removing the card from the writing PC, add a blank file to the boot sector called 'ssh' without a file type. Also add a wpa_supplicant.conf file with the necessary WiFi details if the device is not to be connected on an ethernet network. For a good wpa_supplicant builder go to this link https://www.pistar.uk/wifi_builder.php courtesy of the author MW0MWW.

Once complete, eject the card and install it in the raspberry pi and power it up. Enter the user as 'pi' and password 'raspberry' in lower case. 

The first step will be the following command: sudo apt install -y git  

Now the following command: sudo git clone https://github.com/f5vmr/svxlink_raspberry.git - It is not apparent on this line but there is a _ between svxlink and raspberry.

Once this is installed type the following command: sudo chmod +x svxlink_raspberry/*.sh

Now enter sudo bash svxlink_raspberry/audio_update.sh and enter followed by: sudo bash svxlink_raspberry/install.sh and enter.

The script will now update the software. You will be required to add the callsign of the node prior to the compilation of the software so watch for the prompt.

At the end of the script the running configuration will be compiled with the given callsign. Then the fun begins. Go and have a coffee or even lunch as the compilation will take about an hour possibly longer. A Raspberry Pi 3 or 4 will take less time, and a Raspberry Pi zero possibly longer than 90 minutes.
At the end of the compilation type sudo reboot to restart the unit.

You will need to understand the svxlink.conf file and how to make adjustments for Simplex or Repeater operation. In any case you may need to refer to the svxlink.org main page, or svxlink amateur radio users page on facebook, or contact me. For further information also consult the svxlink pages on g4nab.co.uk.

To stop svxlink running type in the terminal sudo systemctl stop svxlink.service and to restart it type sudo systemctl restart svxlink.service
Everything introduced here is from the original presentation by Tobias SM0SVX, modified slightly with some additional modules from DL1HRC.

