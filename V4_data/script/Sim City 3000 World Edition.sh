#!/bin/bash
# Date : (2016-10-06 10-47)
# Last revision : (2016-10-06 10-47)
# Wine version used : 1.9.15
# Distribution used to test : Ubuntu 16.04
# Author : facus26
# Licence : yo
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
NAME="SimCity 3000 World Edition"
PREFIX="SimCity3000WorldEdition"
  
if [ "$POL_LANG" == "en" ]; then
INSTALLATION="Installation en cours.."
ATTENTION="Veuillez noter que ce jeu a une protection anti-copie\net que malheuresement, cela empêche wine de lancer le jeu.\n\nPlayOnLinux ne fournira aucune aide concernant tout travail\nillégal."
ATTENTIONT="Note à propos de la protection anti-copie"
POLEND="$NAME a été installé avec succès"
else
INSTALLATION="Installation in progress..."
ATTENTION="Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff."
ATTENTIONT="Note about copy protection"
POLEND="$NAME has been installed succesfully"
fi
  
POL_SetupWindow_Init
  
POL_SetupWindow_presentation "$NAME" "EA Games - Maxis" "http://www.simcity.ea.com/" "thib25" "$PREFIX"
  
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "LAUNCHER/Launcher.exe"
  
POL_SetupWindow_install_wine "1.9.15"
Use_WineVersion "1.9.15"
  
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate
  
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
  
POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
wine "$CDROM/LAUNCHER/Launcher.exe"
POL_SetupWindow_detect_exit
 
POL_SetupWindow_auto_shortcut "$PREFIX" "SC3U.exe" "$NAME" "$NAME.png"
Set_WineVersion_Assign "1.9.15" "$NAME"
  
POL_SetupWindow_message "$ATTENTION" "$ATTENTIONT" "$PLAYONLINUX/themes/tango/warning.png"
POL_SetupWindow_message "$POLEND" "$NAME"
  
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNXS9AAKCRDlMfrJqhPK
R3QhAJ4iqH/2gQUmRDzeMbYPcYWYB5jGzACghrT0zpvfIyIxLVFoNeF8wmwbiDM=
=3pMo
-----END PGP SIGNATURE-----
