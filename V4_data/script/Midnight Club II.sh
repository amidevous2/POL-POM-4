#!/bin/bash
# Date : (2009-11-26 18-40)
# Last revision : (2009-11-26 18-40)
# Wine version used : 1.1.33
# Distribution used to test : Ubuntu 9.10
# Author : thib25
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

NAME="Midnight Club 2"
PREFIX="MC2"

if [ "$POL_LANG" == "fr" ]; then
INSTALLATION="Installation en cours..."
ATTENTION="Veuillez noter que ce jeu a une protection anti-copie\net que malheuresement, cela empêche wine de lancer le jeu.\n\nPlayOnLinux ne fournira aucune aide concernant tout travail\nillégal."
ATTENTIONT="Note à propos de la protection anti-copie"
else 
INSTALLATION="Installation in progress..."
ATTENTION="Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff."
ATTENTIONT="Note about copy protection" 
fi

wget http://upload.wikimedia.org/wikipedia/en/0/0b/Midnight_Club_II_Coverart.png --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$NAME" "Rockstar Games" "http://www.rockstargames.com/midnightclub2/" "thib25" "$PREFIX"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

#PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
#PROGRAMFILES=${PROGRAMFILES:3}

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
wine "$CDROM/setup.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Rockstar Games/Midnight Club II" "mc2.exe" "" "$NAME"

POL_SetupWindow_install_wine "1.1.33"
Set_WineVersion_Assign "1.1.33" "$NAME"

POL_SetupWindow_message "$ATTENTION" "$ATTENTIONT" "$PLAYONLINUX/themes/tango/warning.png"
 

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFMACgkQ5TH6yaoTykeF6wCgoQd7kq2ucaLYcPwE8iyvsB9U
zYsAn2AniJngEHnN2CyMSilO/O7Nr83W
=0pGA
-----END PGP SIGNATURE-----
