#!/bin/bash
# Date : (2010-10-28 12-30)
# Last revision : (2010-10-28 12-30)
# Wine version used : 1.3.5
# Distribution used to test : Ubuntu 10.10
# Author : thib25
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

NAME="World Racing"
PREFIX="WorldRacing"

if [ "$POL_LANG" == "fr" ]; then
INSTALLATION="Installation en cours..."
POLEND="$NAME a été installé avec succès"
else 
INSTALLATION="Installation in progress..."
POLEND="$NAME has been installed succesfully"
fi

POL_SetupWindow_Init

POL_SetupWindow_presentation "$NAME" "Synetic" "http://www.synetic.de/" "thib25" "$PREFIX"

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "setup.exe"

POL_SetupWindow_install_wine "1.3.5"
Use_WineVersion "1.3.5"

select_prefix "$REPERTOIRE/wineprefix/$PREFIX"
POL_SetupWindow_prefixcreate

PROGRAMFILES="Program Files"
POL_LoadVar_PROGRAMFILES

POL_SetupWindow_wait_next_signal "$INSTALLATION" "$NAME"
wine start /unix "$CDROM/setup.exe"
POL_SetupWindow_detect_exit

POL_SetupWindow_make_shortcut "$PREFIX" "$PROGRAMFILES/TDK/World Racing" "WR_Starter.exe" "" "$NAME"
Set_WineVersion_Assign "1.3.5" "$NAME"

POL_SetupWindow_message "$POLEND" "$NAME"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk1cJF8ACgkQ5TH6yaoTykcXZACgo+9m+nrWttxBXaEYyJ59KxBq
iEUAn3w85JNz5VhrA6sc3unjJYotgJls
=ga4q
-----END PGP SIGNATURE-----
