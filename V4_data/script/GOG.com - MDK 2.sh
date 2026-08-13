#!/bin/bash
# Date : (2012-06-02 20-43)
# Last revision : (2013-05-19 18-19)
# Wine version used : 1.4.1
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="mdk_2"
PREFIX="MDK2_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - MDK 2"
SHORTCUT_NAME="MDK 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1240
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bioware / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c2c19dd66914a539950c1df8f8b7902d"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "8"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "MDK2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;ActionGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/MDK 2/MANUAL.PDF"
# C:\GOG Games\MDK 2\ReadMe.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGZACkACgkQ5TH6yaoTykddSQCfb3XzP7SdKSM26/RXVnF+SHqv
bUIAnRvHluMz1oECdJ1ExtlahtopWU5L
=0lM8
-----END PGP SIGNATURE-----
