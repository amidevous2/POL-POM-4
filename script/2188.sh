#!/bin/bash
# Date : (2014-07-21)
# Distribution used to test : Kubuntu 14.04 LTS 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.4
#
# CHANGELOG:
# [RoninDusette] (2014-07-21)
#   First script
# [Dadu042] (2019-12-23)
#   Wine 1.6.1 -> System  version.
#   Add game category.
     
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
     
PREFIX="TheWolfAmongUs"
WINEVERSION=""
TITLE="The Wolf Among Us"
EDITOR="Telltale Games"
GAME_URL="http://www.telltalegames.com"
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
     
# Configuration
Set_OS "winxp"
     
# Installation
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"
     
# Create Shortcuts
POL_Shortcut "TheWolfAmongUs.exe" "$TITLE" "" "" "Game;"
    
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgHdFAAKCRDlMfrJqhPK
R7gRAJ9pxckVZjFWvjBRllUaLtLrxZN//gCfUZVTictlJLn0FYsiXsL87IcglWI=
=gqaE
-----END PGP SIGNATURE-----
