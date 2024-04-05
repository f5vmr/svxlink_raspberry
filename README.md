# svxlink install 
<h2>Menu build for Raspberry Pi - Repeater or Hotspot. Pour l'instruction en Français, voir en bas.</h2>

<b>Your First Steps</b>
<p>Requirements: Raspberry Pi of any mark. USB Soundcard, and an interface card (or a modified USB Soundcard and no interface). One or two transceivers</p>
<p>If your are suitably experienced, you will be able to modify the installation once it is complete. But this system will provide you with a working system, and you can then modify it to your own needs.</p>

<p>There are very few raspberry images that work succesfully for this type of build, where there is a potential for using the eventual application in several directions.</p>

<p>Whilst this in itself is not an image, it will take the hard work out of the physical compilation, although it may leave you a little work to do, if you need to change your immediate specification.</p>

<h2><p>Always use Raspberry OS Bookworm Lite (Debian 12) 32 Bit then you won't go wrong.</p></h2>

<p>There are a number of available interface boards that have a variety of uses, either as a hotspot or a repeater, or even a fill-in receiver/transceiver for an existing SVXLink repeater. The settings in this build are for a homebrew interface board using GPIOD 23/18/8 for the Receive COS and GPIOD 24/17/7 for the PTT controller, or alternative a fully modified CM-108 that can use 'udev' and drive the PTT and COS from the modification components. There is an also intermediate version for the CM-108 where only the transmit modification has been done that will you use 'udev' for the transmit, and give you options for the receive GPIOD 23/18/8.</p>

<p>When using the GPIO and GPIOD Pins, an earth pin is also require, so using this combination, pins 14,16 and 18 are all adjacent and ideally placed for these functions. Pin 14 is the Earth, Pin 16 is GPIO 23 and Pin 18 is GPIO 24.</p>

<p>For a second set of transceivers, you can consider GPIO 17 and 18 as COS & PTT for those.</p> 

A copy of the design can be found on g4nab.co.uk. There is also a page showing the modification instructions for a CM-108 USB Sound Card.

<h2>The programming of the SDCard</h2>

<p>As discussed start with a download of <b>Raspberry OS Bookworm Lite</b> from RaspberryPi.org. Then use a 8 or 16 GB MicroSD Card and transfer the image to the card using the <b>Raspberry Pi Image builder</b> from the same source. <b> You MUST make the user 'pi' - please do not deviate from my advice above, as you will get issues. </b> You can however use your own password. There are versions of Raspberry Pi Imager for all operating systems. It allows for full WiFi usage. <b>Always check the SSH box on the second tab.</b> </p> 

<p>Once complete, eject the card and install it in the raspberry pi and power it up. Enter the user <b>pi</b> and your password.</p> 
<h2>The compilation</h2>
<p>This script will also install a dummy sound card for the use of Darkice and Icecast2.</p> 
<p><The first step will be the following command: <b>sudo apt install -y git</b> as without this you cannot download from the GitHub.</p>  

<p>Now the following command: <b>sudo git clone https://github.com/f5vmr/svxlink_install.git</b> .</p>

<p>Once this is installed type the following command: <b>./svxlink_install/install.sh</b></p>

<p>The following menus will guide you through the installation, all the way to run-time. You will need to know before you begin, the status of your transceiver, whether the PTT and COS are Active High or Active Low, the status and type of your USB soundcard, modified or unmodified. With a fully modified usb soundcard, there is no reason that would prevent this installation on another Linux based computer running Debian 12. It has to be Debian 12, or some of the features will fail.</p>

<p>You will need to have decided the callsign of your node ahead of the installation. Do not use additional symbols or numbers at this stage. The callsign should be of standard notation. If you have decided to install EchoLink, then have ready your registration information. If you wish to use ModuleMetarInfo, the Airport Weather application, then read about the ICAO codes, and discoverd the major airports around you. It will not work for airports that do not provide a weather service in real time. If you wish to explore the ModulePropagationMonitor, then this can be installed later. </p>

<p>Everything else will have been constructed for you</p>

<p>The script will compile the running configuration as you proceed. It can only be run once, due to the nature of the program. Allow yourself an uninterupted period of 1 hour, to answer the questions put to you, and the accompanying install. A Raspberry Pi 3 or 4 will take less time, and a Raspberry Pi zero possibly longer than 90 minutes. However the Raspberry Pi Zero will present a challenge due to the lack of an external USB socket. Hopefully there should be no reported error. I have just completed a build on a raspberry pi 3A from card format to working node in 50 minutes, with no errors.</p>

<p>During the compilation, you will be notified of the Active IP Address of your node. Make a note of it. You will need it to proceed.</p>

<p>At the end of the compilation, the system will automatically reboot, about which you will be notified.</p>

<p>The next step will be to open an internet browser such as 'Chrome' and type in the IP Address and enter. The dashboard will be displayed.If your USB soundcard is flashing then the node should be fully operational.</p>

<h2> Troubleshooting </h2>

<p>You will need to understand the svxlink.conf file and how to make adjustments for Simplex or Repeater operation. In any case you may need to refer to the svxlink.org main page, or svxlink amateur radio users page on facebook, or contact me. For further information also consult the svxlink pages on g4nab.co.uk. In the terminal type man svxlink.conf and the on-board documentation will be displayed.</p>

<p>To stop svxlink running type in the terminal <b>sudo systemctl stop svxlink.service</b> and to restart it type <b>sudo systemctl restart svxlink.service</b></p>

<p>The next stage will be to modify the three files <b>node_info.json</b>, <b>svxlink.conf</b>, and <b>ModuleEchoLink.conf</b>.</p>
<p>To obtain information for the node_info.json go to a PC Browser and enter <b>http://svxportal-uk.ddns.net:81</b> where you will find a dashboard.</p>
<p>Click <b>Register</b> at the top, completing the information. This information is held only to enable you to complete the next stage. Log in with the information you have just supplied, click on <b>My Stations</b>, and click on <b font=color blue>Generate node_info.json</f></b>. Once complete, save the resulting file in your computer.</p>
<p>Open the terminal of the Raspberry Pi, and type <b>cd /etc/svxlink</b> followed by return. Then type <b>sudo nano node_info.json</b> and edit the information with the content of the file you have just saved on your PC. You can open the file with a text editor or notepad.</p>
<p>When the editing is complete type <b>cntrl-o</b> and return at the keyboard for the terminal followed by <b>cntrl-x</b>.</p>
<p>The next stage is to check and edit where necessary the <b>svxlink.conf</b> file. Type <b>sudo nano svxlink.conf</b> followed by return.</p>
<p>Check the content and complete your location information near the bottom of the file. type <b>cntrl-o</b> and return then <b>cntrl-x</b> when finished to save your changes.</p>
<p>To modify the Echolink information type <b>sudo nano svxlink.d/ModuleEchoLink.conf</b> and return. Make your changes to your EchoLink access here. then save the file as you did above with <b>svxlink.conf</b>. If you have not yet enabled svxlink in the <b>svxlink.conf</b> to may need to do this now, and remove the <b>#</b> comment header from the relevant lines.</p>
<p>To incorporated the changes you will need to type <b>sudo systemctl restart svxlink.service</b> and return.</p>
<p>If you need to make changes to the <b>gpio.conf</b> file you will also need to restart the gpio service too. The old methods of adding the gpio configuration and setting a daemon start in /etc/rc.local are deprecated (no longer required), and in the case of using gpiod, then the modifying of gpio.conf is also no longer required.</p> 
<p>Everything introduced here is from the original presentation by Tobias SM0SVX.</p>


<b><h2>Français</h2></b>
<p>Cette Installation est pour un Raspberry Pi Tous marques. Les paramètres du RRF sont inclues.</p>
<p>IMPORTANT - Toute activité au terminal doit être en USER <b>PI</b>  - Ne Jamais utiliser ROOT</p> 
<p>1.  Téléchargement du Raspberry OS Lite Bookworm - L'equivalence de Debian 12.</p>
<p>2.  Utilisation de Raspberry Pi SDCard writer est importante, particulairement si le Wi-Fi soit necessaire.</p>
<p>3.  Après Installation de la carteSD dedans le Raspberry, fait marcher le système, la carte-son inclu s'il y en a.</p>
<p>4.  Avec SSH d'un ordinateur au réseau, il faut trouver le terminal - ssh pi@192.168.#.# -p 22 dans votre réseau par un écran de command d'un PC par exemple. le mot-pass normale soit "raspberry".</p>
<p>5.  Taper <b>sudo apt install git -y</b> au terminal et attendre.</p>
<p>6.  Taper <b>sudo git clone https://github.com/f5vmr/svxlink_raspberry</b> et attendre.</p>
<p>7.  Taper <b>sudo chmod +x svxlink_raspberry/*.sh</b></p>
<p>8.  Taper <b>sudo bash ./svxlink_raspberry/install_fr.sh</b></p>
<p>9. Ici le script va demander si vous voulez les mises à jour des logiciels. Taper <b>y</b>.</p>
<p>10. Après plusieurs minutes, pendant lesquelles les mises à jour auront lieu, il y aura une demande pour selectionner la carte-son, suivi par une demande d'indicatif d'appel du nœud proposé vous sera présentée.</p>
<p>11. Si la réponse est déterminée comme étant valide, le processus de configuration commencera. La compilation se poursuivra jusqu'à un point où la framboise redémarrera. Il est peu probable qu'il fonctionne comme vous le souhaitez, car vous devrez encore apporter quelques modifications à la configuration. Si une erreur se présente, vous devrez déterminer où se trouve l'erreur dans le script. Cependant il a été rigoureusement testé et une erreur est susceptible d'avoir été une interruption indépendante de votre volonté. Dans ce cas, vous devrez répéter le script en omettant les mises à jour.</p>
<p>12. Reconnectez-vous au Raspberry. Comme la dernière action du script était de lancer SvxLink, vous devez maintenant l'arrêter, afin de modifier les paramètres. La même chose sera nécessaire pour le GPIO.</p>
<p>13. Alors taper <b>sudo systemctl stop svxlink && sudo systemctl stop svxlink_gpio_setup</b>.
<p>14. La commande pour l'édition d'un fichier est <b>nano</b>, donc ici taper <b>sudo nano /etc/svxlink/gpio.conf</b> pour regarder les ports GPIO. Dans cette configuration ils sont <b>gpio23</b> pour le squelch et <b>gpio24</b> pour le PTT. Il faut explorer dans votre radio si ils sont 'actif-haut' ou 'active-bas' et faire les changements, sauvegarder le fichier, et taper <b>sudo systemctl restart svxlink_gpio_setup</b> pour les ports devenir operationels.</p>
<p>15. Avant l'édition du ficher svxlink.conf taper <b>sudo cp /etc/svxlink/svxlink.conf /etc/svxlink/svxlink.bak</b>.
<p>16. Taper <b>sudo nano /etc/svxlink/svxlink.conf</b>
<p>Ici, il sera nécessaire de configurer correctement de nombreux paramètres, notamment GPIO, Cartes son, Localisation et autres. Avant de modifier ces paramètres, lisez le fichier man sur internet pour vérifier vos connaissances http://www.svxlink.org/doc/man/man5/svxlink.conf.5.html. Cette page est en anglais, pour traduire. A chaque changement, sauvegardez le résultat, en cas de coupure de courant. La langue défaute est modifiée - fr_FR par le script.</p>
<p>17. Faire marcher le logicel en teste avec <b>sudo svxlink</b> en mode direct. Le journal se montre. Pour l'arrête à cette étape, simplement taper <b>cntrl-c</b>. Faire les corrections des erreurs un par un, et faire les tests jusqu'a la satifaction. Donc redémmarer svxlink en service avec <b>sudo systemctl restart svxlink | tail -f /var/log/svxlink.log</b>. Le journal vous montre le service. Encore une fois <b>cntrl-c</b> arrête l'apparition du journal.</p>
<p>18. Vous devrez éditer le fichier node_info.json. Comme précédemment, tapez <b>sudo cp /etc/svxlink/node_info.json /etc/svxlink/node_info.bak</b>. Puis <b>sudo nano /etc/svxlink/node_info.json</b>. Faites attention de laisser tous les '{ }' exactement. Faire Entrez les détails de votre emplacement. Soyez conscient de la convention correcte de longitude et de latitude. Enregistrez le fichier lorsque votre édition est terminée.</b>
<p>Votre connexion au server a besoin de cette information.</p> 
<p>Il y a plusieurs solutions, et une question stupide soit la question n'a jamais posé.</p>
<p>Que puis-je faire avec mon nouveau nœud ?</p>
<p>Dans ce cas, vous constaterez que votre nœud est déjà prêt à accéder au RRF - Réseau des Répéteurs Francophones. À une exception près, tous les groupes de discussion seront à votre disposition, à l'exception du RRF lui-même. Mais ce n'est pas votre erreur, mais une restriction sur le serveur.</p>
<p>Pour accéder à ces groupes de discussion, vous devrez envoyer dtmf avec ptt appuyé - 91 + le numéro du groupe + #. Votre nœud répondra "talk group" et le numéro. Le numéro de groupe de discussion est le suivant.</p>
<p>97 - FON, 98 - Technique, 99 - International, 100 - Bavardage, 101 - Local, 102 - Experimental</p>
<p>Donc accèder au TG 100, transmettre au DTMF - <b>91100#</b> et le noeud repondra "Talk Groupe un zero zero". Parler à volonté. Pour déconnecter transmettre DTMF <b>910#</b> ou un autre TG.... Très simple. Regarder au même temps le tableau de bord <b>http://rrf4.f5nlg.ovh:82/</b>.
Il y a une possibilité de connexion aux autres serveurs, comme le serveur britannique. Poser la question au email <b>g4nab.ne63@gmail.com</b></p>
<b>73 de Chris G4NAB/F5VMR
