#!/bin/bash
# Date : (2010-01-27  16-10)
# Last revision : (2019-05-26)
# Wine version used : 1.9.24
# Distribution used to test : Ubuntu 9.10
# Author : thib25
# Licence : Retail 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
NAME="Colin Mcrae Rally 04"
PREFIX="CMR4"
 
if [ "$POL_LANG" == "fr" ]; then
INSTALLATION="Installation en cours..."
POLEND="$NAME a été installé avec succès"
ATTENTION="Veuillez noter que ce jeu a une protection anti-copie\net que malheuresement, cela empêche wine de lancer le jeu.\n\nPlayOnLinux ne fournira aucune aide concernant tout travail\nillégal."
ATTENTIONT="Note à propos de la protection anti-copie"
else
INSTALLATION="Installation in progress..."
POLEND="$NAME has been installed succesfully"
ATTENTION="Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff."
ATTENTIONT="Note about copy protection"
fi
POL_SetupWindow_Init
 
POL_SetupWindow_presentation "$NAME" "Codemasters" "http://www.codemasters.com/" "thib25" "$PREFIX"
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate
 
POL_SetupWindow_install_wine "1.9.24"
Use_WineVersion "1.9.24"
 
#Création Icone
convert "$CDROM/CMR4.ico" -geometry 32x32 "$REPERTOIRE/icones/32/$NAME"
 
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
 
POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
wine start /unix "$CDROM/setup.exe"
POL_SetupWindow_detect_exit
 
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Codemasters/Colin McRae Rally 04/" "cmr4.exe" "$NAME" "$NAME"
 
Set_WineVersion_Assign "1.9.24" "$NAME"
 
POL_SetupWindow_message "$ATTENTION" "$ATTENTIONT" "$PLAYONLINUX/themes/tango/warning.png"
POL_SetupWindow_message "$POLEND" "$NAME"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXOsDlgAKCRDlMfrJqhPK
R8eCAJwP7hxqA6w7fzYCTAHajFJjkvDQpACgq/I6yCXOYkJ2mvxsMuZSo2yOMv0=
=vp2k
-----END PGP SIGNATURE-----
