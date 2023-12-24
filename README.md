# svxlink_raspberry
<h2>Script build for Raspberry Pi - Repeater or Hotspot. Pour l'instruction en Français, voir en bas.</h2>

<b>First Steps</b>
<p>Requirements: Raspberry Pi of any mark. USB Soundcard, and an interface card (or a modified USB Soundcard and no interface). One or two transceivers (3 or 4 if you are making a double repeater, for which you will probably need a second USB soundcard.)</p>

<p>There are few raspberry images that work succesfully for this type of build, where there is a potential for using the eventual application in several directions.</p>

<p>Whilst this in itself is not an image, it will take the hard work out of the physical compilation, although it leaves a little work for the user to place the finishing touches to the final assembly.</p>

<p>There are a number of pitfalls that you must avoid and that includes using Raspberry OS Bookworm Lite 64 bit (Debian 12). My strong recommendation is NOT to use this.</p>

<p>Always use Raspberry OS Bullseye Lite (Debian 11) 32 Bit also known as legacy 32 bit, then you won't go wrong.</p>

<p>There are a number of available interface boards that have a variety of uses, either as a hotspot or a repeater, or even a fill-in receiver/transceiver for an existing SVXLink repeater. The settings in this build are for a homebrew interface board using GPIO 23 for the Receive COS and GPIO 24 for the PTT controller, or alternative a modified CM-108 that can use udev and drive the PTT from the modification components.</p>

<p>When using the GPIO Pins, an earth pin is also require, so using this combination, pins 14,16 and 18 are all adjacent and ideally placed for these functions.</p>
<p>Pin 14 is the Earth, Pin 16 is GPIO 23 and Pin 18 is GPIO 24.</p>

<p>For a second set of transceivers, you can consider GPIO 17 and 18 as COS & PTT for those.</p> 

A copy of the design can be found on g4nab.co.uk. There is also a page showing the modification instructions for a CM-108 USB Sound Card.

<h3>The programming of the SDCard</h3>

<p>As discussed start with a download of <b>Raspberry OS Bullseye Lite</b> from RaspberryPi.org. Then use a 8 or 16 GB MicroSD Card and transfer the image to the card using the Raspberry Pi Image builder from the same source. please do not ignore my advice above, as you can get issues. There are versions for all operating systems.</p> 


Once complete, eject the card and install it in the raspberry pi and power it up. Enter the user as 'pi' and password 'raspberry' in lower case. 
<h3>The compilation</h3>
<p>This script will also install a dummy sound card for the use of Darkice and Icecast2.</p> 
<p><The first step will be the following command: <b>sudo apt install -y git</b> as without this you cannot download from the GitHub.</p>  

Now the following command: <b>sudo git clone https://github.com/f5vmr/svxlink_raspberry.git</b> .

Once this is installed type the following command: <b>sudo chmod +x svxlink_raspberry/*.sh</b>

<p>The next commands refer to Raspberry OS Bullseye 32 bit lite (Debian 11). If you wish to use Raspberry OS Buster (Debian 10) such as for the F8ASB Hotspot then you need to edit the svxlink_raspberry/install.sh script by changing php8.0 to php7.3 in the list of software the script will download. Failure to do this will crash the script. If you choose to ignored my advice and used Raspberry Bookworm Debian 12, then this will need to be changed to php8.2. There will be consequences if you use bookworm, just saying. Don't. </p>

Now type <b>sudo ./svxlink_raspberry/install.sh</b> and return.

The script will now update the software. You will be required to add the callsign of the node prior to the compilation of the software so watch for the prompt.

At the end of the script the running configuration will be compiled with the given callsign. Then the fun begins. Go and have a coffee or even lunch as the compilation will take about an hour possibly longer. A Raspberry Pi 3 or 4 will take less time, and a Raspberry Pi zero possibly longer than 90 minutes. Hopefully there should be no reported error. I have just completed a build on a raspberry pi 3A from card format to working node in 50 minutes, with no errors.

At the end of the compilation type <b>sudo reboot</b> to restart the unit, if it hasn't been automatically. It should do so. If all is well the unit wil be only partly functional. 

You will need to understand the svxlink.conf file and how to make adjustments for Simplex or Repeater operation. In any case you may need to refer to the svxlink.org main page, or svxlink amateur radio users page on facebook, or contact me. For further information also consult the svxlink pages on g4nab.co.uk. In the terminal type man svxlink.conf and the on-board documentation will be displayed.

<p>To stop svxlink running type in the terminal <b>sudo systemctl stop svxlink.service</b> and to restart it type <b>sudo systemctl restart svxlink.service</b></p>
The next stage will be to modify the three files <b>node_info.json</b>, <b>svxlink.conf</b>, and <b>ModuleEchoLink.conf</b>.
<p>To obtain information for the node_info.json go to a PC Browser and enter <b>http://svxportal-uk.ddns.net:81</b> where you will find a dashboard.</p>
Click <b>Register</b> at the top, completing the information. This information is held only to enable you to complete the next stage. Log in with the information you have just supplied, and click on <b font=color blue>Generate node_info.json</f></b>. Once complete, save the resulting file in your computer.</b>
Open the terminal of the Raspberry Pi, and type <b>cd /etc/svxlink</b> followed by return. Then type <b>sudo nano node_info.json</b> and edit the information with the content of the file you have just saved on your PC. You can open the file with a text editor or notepad.
When the editing is complete type <b>cntrl-o</b> and return at the keyboard for the terminal followed by <b>cntrl-x</b>.
The next stage is to check and edit where necessary the <b>svxlink.conf</b> file. Type <b>sudo nano svxlink.conf</b> followed by return.
Check the content and complete your location information near the bottom of the file. type <b>cntrl-o</b> and return then <b>cntrl-x</b> when finished to save your changes.
To modify the Echolink information type <b>sudo nano svxlink.d/ModuleEchoLink.conf</b> and return. Make your changes to your EchoLink access here. then save the file as you did above with <b>svxlink.conf</b>. If you have not yet enabled svxlink in the <b>svxlink.conf</b> to may need to do this now, and remove the <b>#</b> comment header from the relevant lines.
To incorporated the changes you will need to type <b>sudo systemctl restart svxlink.service</b> and return.
<p>If you need to make changes to the <b>gpio.conf</b> file you will also need to restart the gpio service too. The old methods of adding the gpio configuration and setting a daemon start in /etc/rc.local are deprecated (no longer required), and in the case of using gpiod, then the modifying of gpio.conf is also no longer required.</p>
<p>Everything introduced here is from the original presentation by Tobias SM0SVX.</p>


<b><h2>Français</h2></b>
<p>Cette Installation est pour un Raspberry Pi Tous marques. Les paramètres du RRF sont inclues.</p>
<p>IMPORTANT - Toute activité au terminal doit être en USER <b>PI</b>  - Ne Jamais utiliser ROOT</p> 
<p>1.  Téléchargement du Raspberry OS Lite Bullseye - L'equivalence de Debian 11.</p>
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
