#!/bin/bash
# Date : (2014-03-01)
# Distribution used to test : Kubuntu 14.04 LTS 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.5
#
# CHANGELOG
# [RoninDusette] (2014-03-01)
#   Initial script.
# [Dadu042] (2020-01-27 23:00)
#   Wine 1.7.30 -> 2.22
#   Improve POL_Shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
     
PREFIX="FinalFantasyIV"
WINEVERSION="2.22"
TITLE="Final Fantasy IV"
EDITOR="Squre Enix Co."
GAME_URL="http://www.square-enix.com/"
AUTHOR="RoninDusette"
     
#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
     
POL_Debug_Init
     
# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
     
# Create Prefix
POL_SetupWindow_browse "$(eval_gettext 'Please select $TITLE install file.')" "$TITLE"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
     
#Dependencies
POL_Install_xact
     
# Configuration
Set_OS "winxp"
     
# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
     
# Create Shortcuts
POL_Shortcut "FF4_Launcher.exe" "$TITLE" "" "" "Game;"
    
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjIJ2gAKCRDlMfrJqhPK
R9dpAJ9h+PwkH/3dw2nej+6IDCFeHASh8gCfWE7LjDUqclgSREmpFU7NZC9kmGQ=
=6nHr
-----END PGP SIGNATURE-----
