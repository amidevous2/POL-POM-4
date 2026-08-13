#!/bin/bash
# Date : (2013-12-08)
# Last revision : (2013-12-08)
# Wine version used : 1.4.1
# Distribution used to test : Archlinux
# Author : Romain Hennuyer romain.hennuyer@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
GOGID="papers_please"
PREFIX="Papers_please_gog"
WORKING_WINE_VERSION="1.4.1"
 
TITLE="GOG.com - Papers, please"
SHORTCUT_NAME="Papers, please"
 
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1899
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Lucas Pope / 3909 LLC" "http://www.gog.com/gamecard/$GOGID" "Romain Hennuyer" "$PREFIX"
 
POL_Call POL_GoG_setup "$GOGID" "83457f2de8d33eef8c875addbd471a8e" # 2.1.0.7
 
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_GoG_install
 
Set_OS winxp
 
#POL_SetupWindow_VMS "8"
#POL_Wine_reboot
 
POL_Shortcut "PapersPlease.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;Simulation;"
 
POL_SetupWindow_Close
 
exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKlaRMACgkQ5TH6yaoTykf+wwCeJfclexrGseFhEXo1ZXZ7z8Zn
53QAniheBB1qvMrRI+L1QeEfZESuBi3z
=Mn2n
-----END PGP SIGNATURE-----
