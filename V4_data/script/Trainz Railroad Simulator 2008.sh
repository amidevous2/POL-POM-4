#!/bin/bash
# Date : (2010-01-14 12-30)
# Last revision : (2010-03-03 17-25)
# Wine version used : 1.0
# Distribution used to test : Ubuntu 9.10
# Author : thib25
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

NAME="Trainz Railroad Simulator 2008"
PREFIX="TRS2008"

if [ "$POL_LANG" == "fr" ]; then
INSTALLATION="Installation en cours..."
POLEND="$NAME a été installé avec succès"
else
INSTALLATION="Installation in progress..."
POLEND="$NAME has been installed succesfully"
fi

wget http://image.jeuxvideo.com/images/pc/t/r/trs8pc0f.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"

POL_SetupWindow_presentation "$NAME" "Anuman Interactive" "www.trainz-lejeu.com" "thib25" "$PREFIX"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Install/setup.exe"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX/"
POL_SetupWindow_prefixcreate

POL_SetupWindow_install_wine "1.0"
Use_WineVersion "1.0"

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
cd "$CDROM"
wine "install/setup.exe"
POL_SetupWindow_detect_exit
#Création Icone
convert "$CDROM/Trainz.ico" -geometry 32x32 "$REPERTOIRE/icones/32/$NAME"

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/Auran/TRS2008/" "TRS2008.exe" "$NAME" "$NAME" "" ""

Set_WineVersion_Assign "1.0" "$NAME"

POL_SetupWindow_message "$POLEND" "$NAME"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJFoACgkQ5TH6yaoTykeOEQCcD5spDGCP5PRnmxXzFa5sIThJ
y58An3U2C9DTyYa3n+fe4Ui6GYHuOuiU
=2vWG
-----END PGP SIGNATURE-----
