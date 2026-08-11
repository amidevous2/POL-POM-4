#!/bin/bash

# Authors : Twinoatl
# Last Revision : 03/12/2009
# Maintener : berillions
 
#Vérifier que PlayOnLinux est bien exécuté avant
[ "$PLAYONLINUX" = "" ] && exit 0 
 
#Charger les librairies
source "$PLAYONLINUX/lib/sources" 
TITLE="Crayon Physics"

#Presentation
POL_SetupWindow_Init
POL_SetupWindow_presentation "Crayon Physics" "Kloonigames" "http://www.kloonigames.com" "Twinoatl" "CrayonPhysics"
 
TEMP="$POL_USER_ROOT/tmp/crayonPhysics"
mkdir "$TEMP"

select_prefix "$REPERTOIRE/wineprefix/CrayonPhysics"
POL_SetupWindow_prefixcreate
Set_SoundDriver esd

cd $TEMP
POL_SetupWindow_download "Téléchargement du jeu..." "Installation" "http://www.kloonigames.com/download/crayon.zip"
POL_SetupWindow_download "Téléchargement de MSVCP60.dll" "Installation" "http://www.dllbank.com/zip/m/msvcp60.dll.zip"
mv download.php crayon.zip # compatibilité avec le script de zoloom
 
cd $WINEPREFIX/drive_c/
unzip $TEMP/crayon.zip
 
cd $WINEPREFIX/drive_c/crayon
unzip $TEMP/msvcp60.dll.zip
 
chmod 777 $TEMP -R
# rm $TEMP -R
 
POL_SetupWindow_auto_shortcut "CrayonPhysics" "crayon.exe" "Crayon Physics" "crayon.png"
POL_SetupWindow_message "Crayon Physics has been installed successfully" "Installation finished"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk/LRw4ACgkQ5TH6yaoTykfv7ACfZsF5q1iA1mUVHxMJ6QwM/1Z0
At8An3rudC2AcWh2VJDHB+74+9o1Ifnu
=wNEp
-----END PGP SIGNATURE-----
