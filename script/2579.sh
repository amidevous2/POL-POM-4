#!/bin/bash
# Date: (2009-10-04 20-45)
# Distribution used to test: Frugalware Current
# Wine version used: 1.1.32
# Author: Berillions
# Graphic Card : GeForce GTX275
# Drivers : 190.42
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources"
 
Title="Jurassic Park : Operation Genesis"
Prefix="JurassicParkOG"
 
if [ "$POL_LANG" == "fr" ]; then
LNG_MEM="La taille de votre mémoire graphique? (Ex : 512)"
LNG_WAIT_END="Appuyez sur \\"Suivant\\" UNIQUEMENT quand l'installation du jeu sera\\nterminée sous peine de devoir recommencer l'installation."
else
LNG_MEM="How much memory do your graphic card have got? (Ex : 512)"
LNG_WAIT_END="Click on \\"Next\\" ONLY when the game installation
is finished or you will have to redo the installation."
fi
 
cd "$REPERTOIRE/tmp"
rm *.jpg
wget http://sd-1.archive-host.com/membres/images/51568577817080088/JPARK.jpg --output-document="$REPERTOIRE/tmp/$Prefix.jpg"
convert "$REPERTOIRE/tmp/$Prefix.jpg" -scale 150x356\\! "$REPERTOIRE/tmp/left.jpg"
 
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpg"
 
#Presentation
POL_SetupWindow_presentation "$Title" "Blue Tongue Entertainment" "http://www.jpthegame.com/" "Berillions" "$Prefix"
 
#Installation de Wine
POL_SetupWindow_install_wine "1.1.32"
 
#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "SETUP.EXE"
 
select_prefix "$REPERTOIRE/wineprefix/$Prefix"
POL_SetupWindow_prefixcreate
 
#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}
 
#Taille de la mémoire graphique
POL_SetupWindow_menu_list "$LNG_MEM" "$Title" "32-64-128-256-384-512-768-896-1024-2048" "-" "128"
VMS="$APP_ANSWER"
 
if [ "$VMS" -lt "128" ]; then
    POL_SetupWindow_message "$LNG_VMS_ERROR" "$Title" "$PLAYONLINUX/themes/tango/warning.png"
fi
 
#Réglage DirectDrawRenderer
cd "$WINEPREFIX/drive_c/windows/temp"
echo "[HKEY_CURRENT_USER\\\\Software\\\\Wine\\\\Direct3D]" > OGL.reg
echo "\\"VideoMemorySize\\"=\\"$VMS\\"" >> OGL.reg
regedit OGL.reg
 
#Configuration de Wine
Set_OS winxp
 
wine "$CDROM/SETUP.EXE"
 
POL_SetupWindow_message "$LNG_WAIT_END" "$Title"
 
#Création Icone
convert "$CDROM/JPOG.ico" "$REPERTOIRE/icones/32/$Title"
 
POL_SetupWindow_make_shortcut "$Prefix" "$PROGRAMFILES/Universal Interactive/Blue Tongue Software/Jurassic Park Operation Genesis/JPOG" "SimJP.exe" "" "$Title"
 
Set_WineVersion_Assign "1.1.32" "$Title"
 
POL_SetupWindow_message "Please note that this game has a copy protection system\\nand sadly, it prevents Wine from running the game.\\n\\nPlayOnLinux will not provide any help concerning any illegal\\nstuff." "Note about copy protection" "$PLAYONLINUX/themes/tango/warning.png"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg55EQAKCRDlMfrJqhPK
R3iNAJ0RXyzJ9YM5zPTH0cDmJs5VahWWUwCfVqOcHnjGPM952tupEOiZ5yaDySI=
=HoYE
-----END PGP SIGNATURE-----
