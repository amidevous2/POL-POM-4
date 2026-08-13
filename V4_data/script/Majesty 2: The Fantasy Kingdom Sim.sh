#!/bin/bash
# Date : (2016-01-21)
# Last revision : (2017-05-08)
# Wine version used : 2.0.1
# Distribution used to test : Ubuntu 17.04 x64
# Author : LinuxScripter
# Licence : GPLv3
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Majesty 2"
AUTHOR="LinuxScripter"
PREFIX="Majesty2"
EDITOR="Paradox Interactive"
GAME_URL="http://www.majesty2.com/"
WORKINGWINEVERSION="2.22"

POL_SetupWindow_SetID 3519

POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
POL_Call POL_Install_vcrun2005
POL_Call POL_Install_d3dx9
  
POL_SetupWindow_InstallMethod "DVD,STEAM"
  
if [ "$INSTALL_METHOD" == "DVD" ]; then
# Asking for CDROM and checking if it's correct one
POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "0x0409.ini"
POL_Wine start /unix "$CDROM/setup.exe"
POL_Wine_WaitExit "$TITLE"
else
POL_Call POL_Install_steam
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/25980
POL_Wine_WaitBefore "$TITLE"
fi
  
# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/25980"
else
        POL_Shortcut "Majesty2.exe" "$TITLE" "" "" "Game;StrategyGame;"
fi
  
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjiNkQAKCRDlMfrJqhPK
R//NAJ9Uqdy6CjZwZJc1yjgTxlrIZ2rGOQCfQJt0cFcdbVBEfxgLUcO8+bHlPMg=
=E79v
-----END PGP SIGNATURE-----
