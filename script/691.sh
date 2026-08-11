#!/bin/bash
# Date : (2010-02-04 14-35)
# Last revision : (2010-02-04 14-35)
# Wine version used : 1.3.1
# Distribution used to test : Ubuntu 10.04
# Author : thib25
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
NAME="Sim City 3000"
PREFIX="SimCity3000"
 
if [ "$POL_LANG" == "fr" ]; then
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
 
POL_SetupWindow_install_wine "1.3.1"
Use_WineVersion "1.3.1"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate
 
PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
 
POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
wine "$CDROM/LAUNCHER/Launcher.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_auto_shortcut "$PREFIX" "SC3.exe" "$NAME" "$NAME.png"
Set_WineVersion_Assign "1.3.1" "$NAME"
 
POL_SetupWindow_message "$ATTENTION" "$ATTENTIONT" "$PLAYONLINUX/themes/tango/warning.png"
POL_SetupWindow_message "$POLEND" "$NAME"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFkACgkQ5TH6yaoTykeVuwCgnC9mSNac4Pv3JRYw9P3w8+ES
1O0AniyoJFm2vrOrdMDWHiLBDOvgsN7K
=YLhk
-----END PGP SIGNATURE-----
