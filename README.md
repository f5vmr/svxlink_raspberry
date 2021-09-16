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

Start with a download of Raspberry OS Lite from RaspberryPi.org. Then use a 16 GB MicroSD Card and transfer the image to the card by one of the proprietary image writers. Prior to removing the card from the writing PC, add a blank file to the boot sector called 'ssh' without a file type. Also add a wpa_supplicant.conf file with the necessary WiFi details if the device is not to be connected on an ethernet network.

Once complete, eject the card and install it in the raspberry pi and power it up.

Prior to running the install script accompanying this file, run the audio_update script, to ensure the USB Sound card you are to use is set to be the first device.

Everything introduced here is from the original presentation by Tobias SM0SVX, modified slightly with some additional modules from DL1HRC.

