#!/bin/bash
# Date : (2017-01-20 08:01)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Ubuntu Mate 16.04 LTS, 32-bit
# Author : bastien09, NSLW, lahtis <lahtis@gmail.com>
# Script licence : GPLv2
# Program version : Retail original 2 CD box
# Bug reports ->
# Latest install script -> https://github.com/lahtis/playonlinux/blob/master/working/TotalAnnihilation
#
# CHANGELOG
# [bastien09, NSLW] (2017-01-20 08:01)
#   First script.
# [lahtis] (2017-01-20 ?)
#   Fixes.
# [Dadu042] (2019-12-30)
#   Wine POL 2.0-rc5 -> 2.22
# [Dadu042] (2020-03-29)
#   Wine 3.0.3 (for OSX and Linux)
#

[ -z "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"
 
PREFIX="TotalAnnihilation"

TITLE="Total Annihilation"
EDITOR="Cavedog Entertainment / GT Interactive"          
GAME_URL="http://files.tauniverse.com/"
AUTHOR="lahtis"
GAME_VMS="32"
WORKING_WINE_VERSION="3.0.3"
 
# Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_Debug_Init
  
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Fix pulseaudio issue
which pulseaudio && Set_OS "win95"
 
# Asking for CDROM and checking if it's correct one
POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive')" "$TITLE"
POL_SetupWindow_check_cdrom "SETUP.EXE"
POL_SetupWindow_cdrom
 
POL_Wine start /unix "$CDROM/SETUP.EXE" || POL_Debug_Fatal "$(eval_gettext 'Error while installing game.')"
POL_Wine_WaitExit "$TITLE"
 
POL_Shortcut "totala.exe" "$TITLE" "$TITLE.png" "" "Game;"
  
POL_SetupWindow_message "$(eval_gettext '$TITLE has been successfully installed.')"
  
POL_SetupWindow_Close
  
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXn/ZXgAKCRDlMfrJqhPK
R+xGAJ9c7BsHJRaF7yYNjTdY1AhgKXwUhQCfTNTCAqHub9pccYBLGpmzW0pmBRA=
=hUjV
-----END PGP SIGNATURE-----
