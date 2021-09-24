# svxlink_raspberry
<h2>Script build for Raspberry Pi - Repeater or Hotspot.</h2>

<b>First Steps</b>
<p>Requirements: Raspberry Pi of any mark. USB Soundcard, and an interface card. One or two transceivers (3 or 4 if you are making a double repeater, for which you will need a second USB soundcard.)</p>

There are few raspberry images that work succesfully for this type of build, where there is a potential for using the eventual application in several directions.

Whilst this in itself is not an image, it will take the hard work out of the physical compilation, although leaves a little work for the user to place the finishing touches to the final assembly.

There are a number of available interface boards that have a variety of uses, either as a hotspot or a repeater, or even a fill-in receiver/transceiver for an existing SVXLink repeater. The settings in this build are for a homebrew interface board using GPIO 23 for the Receive COS and GPIO 24 for the PTT controller.
When using the GPIO Pins, an earth pin is also require, so using this combination, pins 14,16 and 18 are all adjacent and ideally placed for these functions.
Pin 14 is the Earth, Pin 16 is GPIO 23 and Pin 18 is GPIO 24.

For a second set of transceivers, you can consider GPIO 17 and 18 as COS & PTT for those. 

A copy of the design can be found on g4nab.co.uk.

<h3>The programming of the SDCard</h3>

Start with a download of <b>Raspberry OS Lite</b> from RaspberryPi.org. Then use a 16 GB MicroSD Card and transfer the image to the card by one of the proprietary image writers. Prior to removing the card from the writing PC, add a blank file to the boot sector called 'ssh' without a file type. Also add a wpa_supplicant.conf file with the necessary WiFi details if the device is not to be connected on an ethernet network. For a good wpa_supplicant builder go to this link https://www.pistar.uk/wifi_builder.php courtesy of the author MW0MWW.

Once complete, eject the card and install it in the raspberry pi and power it up. Enter the user as 'pi' and password 'raspberry' in lower case. 
<h3>The compilation</h3>
The first step will be the following command: <b>sudo apt install -y git</b>  

Now the following command: <b>sudo git clone https://github.com/f5vmr/svxlink_raspberry.git</b> .

Once this is installed type the following command: <b>sudo chmod +x svxlink_raspberry/*.sh</b>

Now type <b>sudo bash svxlink_raspberry/audio_update.sh</b> and return followed by: <b>sudo bash svxlink_raspberry/install.sh</b> and return.

The script will now update the software. You will be required to add the callsign of the node prior to the compilation of the software so watch for the prompt.

At the end of the script the running configuration will be compiled with the given callsign. Then the fun begins. Go and have a coffee or even lunch as the compilation will take about an hour possibly longer. A Raspberry Pi 3 or 4 will take less time, and a Raspberry Pi zero possibly longer than 90 minutes. Hopefully there should be no reported error.

At the end of the compilation type <b>sudo reboot</b> to restart the unit. IF all is well the unit wil be immediately functional.

You will need to understand the svxlink.conf file and how to make adjustments for Simplex or Repeater operation. In any case you may need to refer to the svxlink.org main page, or svxlink amateur radio users page on facebook, or contact me. For further information also consult the svxlink pages on g4nab.co.uk.

To stop svxlink running type in the terminal <b>sudo systemctl stop svxlink.service</b> and to restart it type <b>sudo systemctl restart svxlink.service</b>
The next stage will be to modify the three files <b>node_info.json</b>, <b>svxlink.conf</b>, and <b>ModuleEchoLink.conf</b>.
To obtain information for the node_info.json go to a PC Browser and enter <b>http://svxportal-uk.ddns.net</b> where you will find a dashboard.
Click <b>Register</b> at the top, completing the information. This information is held only to enable you to complete the next stage. Log in with the information you have just supplied, and click on <b font=color blue>Generate node_info.json</f></b>. Once complete, save the resulting file in your computer.
Open the terminal of the Raspberry Pi, and type <b>cd /etc/svxlink.conf</b> followed by return. Then type <b>sudo nano node_info.json</b> and edit the information with the content of the file you have just saved on your PC. You can open the file with a text editor or notepad.
When the editing is complete type <b>cntrl-o</b> and return at the keyboard for the terminal followed by <b>cntrl-x</b>.
The next stage is to check and edit where necessary the <b>svxlink.conf</b> file. type <b>sudo nano svxlink.conf</b> followed by return.
Check the content and complete your location information near the bottom of the file. type <b>cntrl-o</b> and return then <b>cntrl-x</b> when finished to save your changes.
To modify the Echolink information type <b>sudo nano svxlink.d/ModuleEchoLink.conf</b> and return. Make your changes to your EchoLink access here. then save the file as you did above with <b>svxlink.conf</b>. If you have not yet enabled svxlink in the <b>svxlink.conf</b> to may need to do this now, and remove the <b>#</b> comment header from the relevant lines.
To incorporated the changes you will need to type <b>sudo systemctl restart svxlink.service</b> and return.
If you need to make changes to the <b>gpio.conf</b> file you will also need to restart the gpio service too.
<p>Everything introduced here is from the original presentation by Tobias SM0SVX, modified slightly with some additional modules from DL1HRC.</p>

