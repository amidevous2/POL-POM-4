#!/bin/bash
# Date : (2013-12-08 14-47)
# Wine version used : 1.4.1
# Distribution used to test : Ubuntu 12.04.2
# Author : markus_s
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="praetorians"
PREFIX="praetorians_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Praetorians"
SHORTCUT_NAME="Praetorians"

#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1907
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" " Pyro Studios / Merge Games" "http://www.gog.com/gamecard/$GOGID" "markus_s" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "424388936d26a04dd109a2cc3ef0035a"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"


POL_Call POL_GoG_install

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "praetorians.exe" "$SHORTCUT_NAME" "" "" "Game;StrategyGame;"

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Praetorians/Manual.pdf"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKwpxIACgkQ5TH6yaoTykeBgACdGwm160J0HstLCkEeqtAs/7RH
5BEAnA+8f2uWr2jDKACZ7Y8q4C++/L4v
=GWzI
-----END PGP SIGNATURE-----
