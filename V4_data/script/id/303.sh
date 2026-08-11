#!/bin/bash

# CHANGELOG
# [Toumeno] (2009 ?)
#   First script.
# [Dadu042] (2019-12-31)
#  Wine 1.1.0 -> 2.22
#  Updates.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

if [ "$POL_LANG" == "fr" ]
then
LNG_NAME="Empereur : L'Empire du Milieu"
LNG_FOLDER="Sierra/Empereur/"
LNG_WAIT="Installation en cours..."
LNG_SETTINGS="Au cours d'une partie, n'oubliez pas de cliquer sur Options=>Affichage,\net de régler la résolution à 1024x768 (maximum)."
else
LNG_NAME="Emperor : Rise of the Middle Kingdom"
LNG_FOLDER="Sierra/Emperor/"
LNG_WAIT="Installing..."
LNG_SETTINGS="During a game, don't forget to click on Options=>Display,\nand set the resolution on 1024x768 (maximum)."

fi

wget http://upload.wikimedia.org/wikipedia/en/thumb/3/32/EmperorBoxshot.jpg/250px-EmperorBoxshot.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$LNG_NAME" "Sierra" "http://emperor.sierra.com/" "Toumeno" "Emperor"

#Préparation de Wine

mkdir -p $REPERTOIRE/wineprefix/Emperor

# Setting prefix path
POL_Wine_SelectPrefix "Emperor"
          
# Determine Architecture
# POL_System_SetArch "amd64"
POL_System_SetArch "x86"
     
# Downloading wine if necessary and creating prefix
POL_Wine_PrefixCreate


Set_OS "winxp"

#Détection du cd-rom
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"

# Lancement de l'installeur

cd "$CDROM"
POL_SetupWindow_wait_next_signal "$LNG_WAIT" ""
wine Setup.exe
POL_SetupWindow_detect_exit

POL_SetupWindow_make_shortcut "Emperor" "$LNG_FOLDER" "Emperor.exe" "emperor.xpm" "Game;"

# Fin du code du jeu

POL_SetupWindow_reboot

POL_SetupWindow_message "$LNG_SETTINGS"

POL_SetupWindow_Close
exit 
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgsktgAKCRDlMfrJqhPK
Rz40AKCqAxq3RPmu3y1q9+6reCSblnhd0QCfWF38nx095OlYe9gLYKmqMdW9zAI=
=J+CJ
-----END PGP SIGNATURE-----
