#!/bin/bash
# Date : (2013-05-31 22-00)
# Last revision : (2013-06-01 16-00)
# Wine version used : 1.4.1
# Distribution used to test : Fedora 17
# Author : TonyFlow
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="caesar_3"
PREFIX="Caesar3_gog"
WORKING_WINE_VERSION="1.4.1"
 
TITLE="GOG.com - Caesar III"
SHORTCUT_NAME="Caesar III"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1726
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Impressions Games / Sierra" "http://www.gog.com/gamecard/$GOGID" "TonyFlow" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "2ee16fab54493e1c2a69122fd2e56635"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install
 
# GoG work!
# Set_OS win98
# Set_Desktop On 1024 768
 
POL_SetupWindow_VMS "4"
 
# Doesn't hurt ;)
POL_Wine_reboot
 
GOGPATH="$GOGROOT/Caesar 3"
POL_Shortcut "c3.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGPATH/Manual.pdf"
#POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGPATH/Reference_Card.pdf"
 
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlO6eOEACgkQ5TH6yaoTyke7lQCeJVWIntMetVTCWR/SSI3hUDGN
1QYAoLAN2lTsOGkcwxOK8AS1YlQo2Ac1
=S2n3
-----END PGP SIGNATURE-----
