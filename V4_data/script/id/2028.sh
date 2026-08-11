#!/bin/bash
# Date : (2014-05-09 21-26)
# Last revision : (2014-05-10 09-25)
# Wine version used : 1.6.2, 1.7.18
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="unreal_tournament_2004_ece"
PREFIX="UnrealT2004ECE_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Unreal Tournament 2004 ECE"
SHORTCUT_NAME="Unreal Tournament 2004"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2028
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Studio / Publisher" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 3 "34943e9a6f0393e1837c605cadb0e2fc" "0fa94560016944eb07639c24b50111e1" "33f10c93f5aff2dca88f251b0c36c118"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install /nogui


# GoG work!
Set_OS winxp

POL_Wine_X11Drv "GrabFullScreen" "Y"

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "UT2004.exe" "$SHORTCUT_NAME" "" "" "Game;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Unreal Tournament 2004/Manual/Manual.pdf"
# C:\GOG Games\Unreal Tournament\Help\ReadMe.int.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlNt2CIACgkQ5TH6yaoTykeAwACgkz7l33t/2PGNqEw0XXXu+1yD
3GgAn0DBX8Sev33cvvOw66MMQ6nUHb3A
=gcmp
-----END PGP SIGNATURE-----
