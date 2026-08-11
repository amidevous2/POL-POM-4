#!/bin/bash
# Date : (2010-01-23  20-30)
# Last revision : (2010-05-30 11-10)
# Wine version used : 1.2-rc1
# Distribution used to test : Ubuntu 10.04
# Author : thib25
# Licence : Retail 
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
NAME="Toca Race Driver 2"
PREFIX="TRD2"
URL="ftp://downloads.codemasters.com/upgrade/rd2_v12_upgrade.zip"
 
if [ "$POL_LANG" == "fr" ]; then
INSTALLATION="Installation en cours..."
DOWNLOAD="Téléchargement de la mise à jour en cours..."
ATTENTION="Veuillez noter que ce jeu a une protection anti-copie\net que malheuresement, cela empêche wine de lancer le jeu.\n\nPlayOnLinux ne fournira aucune aide concernant tout travail\nillégal."
ATTENTIONT="Note à propos de la protection anti-copie"
POLEND="$NAME a été installé avec succès"
else 
INSTALLATION="Installation in progress..."
DOWNLOAD="Download of the update in progress..."
ATTENTION="Please note that this game has a copy protection system\nand sadly, it prevents Wine from running the game.\n\nPlayOnLinux will not provide any help concerning any illegal\nstuff."
ATTENTIONT="Note about copy protection" 
POLEND="$NAME has been installed succesfully"
fi
 
 
wget http://cdn.cnetnetworks.fr/gamekult-com/images/photos/00/00/42/77/ME0000427772_2.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"
 
POL_SetupWindow_presentation "$NAME" "Codemasters" "http://www.codemasters.com/tocaracedriver2/" "thib25" "$PREFIX"
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

POL_SetupWindow_install_wine "1.2-rc1"
Set_WineVersion_Assign "1.2-rc1" "$NAME"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES
 
POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
wine "$CDROM/setup.exe"
POL_SetupWindow_detect_exit

cd "$REPERTOIRE/ressources"

if [ ! -e "rd2_v12_upgrade.zip" ]; then
POL_SetupWindow_download "$DOWNLOAD" "$NAME" "$URL"
fi
unzip rd2_v12_upgrade.zip -d /$REPERTOIRE/tmp/

cd  $REPERTOIRE/tmp/

POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
wine "RD2V12UPGRADE.exe"
POL_SetupWindow_detect_exit

rm -rf $REPERTOIRE/ressources/rd2_v12_upgrade.zip
rm -rf $REPERTOIRE/tmp/RD2V12UPGRADE.exe

 #Création Icone
convert "$HOME/.local/share/*_rd2.0.png" -geometry 32x32 "$REPERTOIRE/icones/32/$NAME"
 
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Codemasters/Race Driver 2" "RD2.exe" "$NAME" "$NAME"
 
#Configuration wine
Set_OS "win2k"
Set_SoundHardwareAcceleration "Emulation"

POL_SetupWindow_message "$ATTENTION" "$ATTENTIONT" "$PLAYONLINUX/themes/tango/warning.png"
POL_SetupWindow_message "$POLEND" "$NAME"
 
POL_SetupWindow_Close
exit 
 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF4ACgkQ5TH6yaoTykdwIwCgsABquiUsOX+tcPIQEISxzOeg
4vkAniz3/ACt4Re+houqCNmlkU/LpSaT
=XNAa
-----END PGP SIGNATURE-----
