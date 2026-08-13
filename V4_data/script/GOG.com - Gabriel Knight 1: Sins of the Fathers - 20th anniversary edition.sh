#!/bin/bash
# Date : (2014-10-25 15-30)
# Last revision : (2014-10-25 15-30)
# Wine version used : 1.7.28
# Distribution used to test : openSUSE 13.2 RC1
# Author : Frédéric Santos frederic.santos@aol.fr
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="GOG.com - Gabriel Knight 1 - 20th anniversary"
PREFIX="GK1_20th_gog"
SHORTCUT_NAME="Gabriel Knight 1: Sins of the Fathers - 20th anniversary edition"
WORKING_WINE_VERSION="1.7.28"
GOGID="gabriel_knight_sins_of_the_fathers_20th_anniversary_edition"
  
POL_SetupWindow_Init
POL_SetupWindow_SetID 2321
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "Phoenix Online Studios" "Retailer: www.gog.com" "Frédéric Santos" "$PREFIX"
  
POL_Call POL_GoG_setup "$GOGID" "15dbbb7846db05599bba0c810a2f6c38"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_Call POL_GoG_install
  
# OS and memory settings
Set_OS win7
  
POL_SetupWindow_VMS "512"
  
# End
POL_Wine_reboot
  
POL_Shortcut "GK1.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"
  
POL_SetupWindow_Close
  
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlRL0NIACgkQ5TH6yaoTykePYgCdFjsX5V8GVrN2aQq+K7uGetsr
dE8AmwYTVtd03SgvjyyqWS1VAM3aOnQ9
=At2g
-----END PGP SIGNATURE-----
