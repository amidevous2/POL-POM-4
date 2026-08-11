#!/bin/bash
# Date : (2009-12-14 18-30)
# Last revision : (2010-02-7 10-05)
# Wine version used : 1.1.37
# Distribution used to test : Ubuntu 9.10
# Author : thib25
# Licence : Retail
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
NAME="Richard Burns Rally"
PREFIX="RichardBurnsRally"
 
if [ "$POL_LANG" == "fr" ]; then
INSTALLATION="Installation en cours..."
POLEND="$NAME a été installé avec succès"
else
INSTALLATION="Installation in progress..."
POLEND="$NAME has been installed succesfully"
fi
 
wget http://upload.wikimedia.org/wikipedia/en/thumb/b/b9/RichardBurnsRallyBox.jpg/256px-RichardBurnsRallyBox.jpg --output-document="$REPERTOIRE/tmp/leftnotscaled.jpeg"
convert "$REPERTOIRE/tmp/leftnotscaled.jpeg" -scale 150x356\! "$REPERTOIRE/tmp/left.jpeg"
POL_SetupWindow_Init "" "$REPERTOIRE/tmp/left.jpeg"
 
POL_SetupWindow_presentation "$NAME" "SCi Games" "http://www.richardburnsrally.com/" "thib25" "$PREFIX"
 
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"
 
select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate
 
PROGRAMFILES=`wine cmd /c echo "%ProgramFiles%" |tr -d '\015' | tr -d '\010'`
PROGRAMFILES=${PROGRAMFILES:3}
 
POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
wine "$CDROM/setup.exe"
POL_SetupWindow_detect_exit
 
#Création Icone
convert "$CDROM/autorun.ico" -geometry 32x32 "$REPERTOIRE/icones/32/$NAME"
 
POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/SCi Games/Richard Burns Rally" "RichardBurnsRally.exe" "$NAME" "$NAME" 
 
POL_SetupWindow_install_wine "1.1.37"
Set_WineVersion_Assign "1.1.37" "$NAME"
 
POL_SetupWindow_message "$POLEND" "$NAME"
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJEoACgkQ5TH6yaoTykcnCwCfSgOutPwfU20U/PBJ1qPib9zX
47cAn0WZ+4/JuaBbdNhDq1UuJpQVxdWi
=gXTS
-----END PGP SIGNATURE-----
