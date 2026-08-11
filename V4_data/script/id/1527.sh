#!/bin/bash
# Date : (2013-01-03 20-04)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Debian Sid (Unstable), Ubuntu 17.04 x64
# Script licence : GPL v.2
# Program licence : Retail

# CHANGELOG
# [Pierre Etchemaite] (2013-01-03 20-04)
#   First script. Wine 1.5.15
# [LinuxScripter] (2018-01-15 20-19)
#   I've moded this script to allow installing this game via Steam.
# [Dadu042] (2019-12-30)
#   Wine 2.0.3 -> 3.0.3

# KNOWN ISSUES:
# - Wine 1.4.1, 1.5.7: "Something very funny about your videocard"
# - Wine 1.5.9: stopped responding when leaving game
# - Wine 1.5.10, 1.5.11, 1.5.15: ok
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Startopia" 
PREFIX="Startopia"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Pierre Etchemaite (pe-pol@concept-micro.com) and LinuxScripter"
EDITOR="Mucky Foot Productions"
GAME_URL="http://www.gog.com/gamecard/Startopia"
 
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 1527
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "DOWNLOAD,STEAM"
if [ "$INSTALL_METHOD" == "DOWNLOAD" ]; then
	POL_Call POL_GoG_setup "Startopia" "4fe8d194afc1012e136ed3e82f1de171" 
	POL_Call POL_GoG_install
else
	POL_Call POL_Install_steam
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine "steam.exe" steam://install/243040
	POL_Wine_WaitBefore "$TITLE"
fi
 
# POL_SetupWindow_VMS "32"
 
# Screen can be scrolled by moving the mouse to the borders
# POL_Wine_X11Drv "GrabFullScreen" "Y"

if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/243040"
else
        POL_Shortcut "startopia.exe" "$TITLE" "" "Game;StrategyGame;"
fi
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgsmYQAKCRDlMfrJqhPK
R6fbAJ9apG7pfZ9VS6C9jwvLYW1O54Tv6ACgmpXq+BODT1OjZTo7mbUBAJ8QxRs=
=j9cZ
-----END PGP SIGNATURE-----
