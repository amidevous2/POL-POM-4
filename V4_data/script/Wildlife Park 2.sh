#!/bin/bash
# Date : (2018-03-23 22:41)
# Last revision : (2018-03-24 09:51)
# Wine version used : 3.0
# Distribution used to test : Ubuntu 18.04 64bit
# Author : LinuxScripter
# Script licence : GPLv3
# Program licence : Proprietary

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Wildlife Park 2"
PREFIX="WildlifePark2"
EDITOR="B-Alive"
AUTHOR="LinuxScripter"
GAME_URL="www.wildlifepark2.com"
WORKING_WINE_VERSION="3.0"

POL_SetupWindow_Init
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Function_SetResolution

POL_Call POL_Install_quartz
POL_Wine_OverrideDLL "" "winegstreamer"

POL_SetupWindow_InstallMethod "CD,STEAM"

if [ "$INSTALL_METHOD" == "CD" ]; then
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "wlp2.ico"
POL_Wine start /unix "$CDROM/setup.exe"
POL_Wine_WaitExit "$TITLE"
else
POL_Call POL_Install_steam
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/304350
POL_Wine_WaitBefore "$TITLE"
fi

if ["$INSTALL_METHOD" == "STEAM"]; then
POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/304350"
else
POL_Shortcut "WLP2.exe" "$TITLE" "wlp2.ico"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXNUxRAAKCRDlMfrJqhPK
R84JAJ4qNlDkDbIEUvWFCMEtAnhqSHPWCQCdEzvYBjJYgrVafX5C4Cr5eF0svbQ=
=agQw
-----END PGP SIGNATURE-----
