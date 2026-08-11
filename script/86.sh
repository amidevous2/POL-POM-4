#!/bin/bash
# Date : (2009-06-14 20-00)
# Last revision : (2009-06-14 20-00)
# Wine version used : N/A 
# Distribution used to test : N/A
# Author : NSLW
# Licence : Retail

#Translated from V2 to V3
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

#fetching PROGRAMFILES environmental variable
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%"`
PROGRAMFILES=${PROGRAMFILES:3}

TITLE="Full Tilt Poker"
PREFIX="FullTiltPoker" 
 
#Presentation
#presentation "FullTiltPoker" "FullTiltPoker" "http://www.fulltiltpoker.net/" "Tr4sK" "FullTiltPoker" 1 3

POL_SetupWindow_Init
POL_SetupWindow_presentation "$TITLE" "Blizzard" "http://www.fulltiltpoker.net/" "Tr4sK and NSLW" "$PREFIX" 
#Cette partie contiendra le code du jeu.

#mkdir -p $REPERTOIRE/wineprefix/FullTiltPoker
#cd $REPERTOIRE/wineprefix/FullTiltPoker
 
#telecharger "Veuillez patienter pendant le téléchargement du client" "http://download.fulltiltpoker.com/download/FullTiltSetup.exe" "Téléchargement de l'executable" 2 3 1
 
#message "Téléchargement terminé. Appuyez sur entrer, puis patientez le temps de préparer l'installation" "Preparation de l'installation" 3 3
 
#select_prefixe "$HOME/.PlayOnLinux/wineprefix/FullTiltPoker/"
#creer_prefixe

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

cd "$WINEPREFIX/drive_c/windows/temp"
POL_SetupWindow_download "Veuillez patienter pendant le téléchargement du client" "$TITLE" "http://download.fulltiltpoker.com/download/FullTiltSetup.exe"

POL_SetupWindow_wait_next_signal "Installation in progress..." "$TITLE"
wine ./FullTiltSetup.exe
POL_SetupWindow_detect_exit
#Fin du code du jeu
#suppression du client
#cd $WINEPREFIX
#rm FullTiltSetup.exe
#Création du lanceur
 
#creer_lanceur "FullTiltPoker" "Program Files/Full Tilt Poker/" "FullTiltPoker.exe" "FullTiltPoker.xpm" "Full Tilt Poker"

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Full Tilt Poker" "FullTiltPoker.exe" "FullTiltPoker.xpm" "$TITLE" "" ""

rm -f "FullTiltSetup.exe"
POL_SetupWindow_message "$TITLE has been installed successfully" "$TITLE"
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJD8ACgkQ5TH6yaoTykc8cgCfQL7TcTBjsgxUa9DUZak1QB+p
xMAAnjZFDZOEMN+WpUaufW5Y/YlbQH8E
=9ZOL
-----END PGP SIGNATURE-----
