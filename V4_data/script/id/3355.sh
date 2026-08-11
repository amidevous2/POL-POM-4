#!/bin/bash
# Date : (2018-05-18 00:39)
# Last revision : (2018-10-31 12:40)
# Wine version used : 3.16
# Distribution used to test : Ubuntu 18.10 64bit
# Author : LinuxScripter
# Script licence : GPLv3
# Program licence : Proprietary
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="PC Building Simulator"
PREFIX="PCBuildingSimulator"
EDITOR="The Irregular Corporation"
AUTHOR="LinuxScripter"
GAME_URL="https://www.pcbuildingsim.com/"
WORKING_WINE_VERSION="3.16"
 
# Starting the script
POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

#Creating wineprefix
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x64"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Installing mandatory dependencies
POL_Call POL_Function_SetResolution #needed otherwise the game window becomes unable to interract with if you alt-tab
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_corefonts

# Begin game installation
POL_Call POL_Install_steam
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/621060
POL_Wine_WaitBefore "$TITLE"
 
# Making shortcut
POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/621060" "-no-ces-sandbox"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXTaRkwAKCRDlMfrJqhPK
R73SAJsEfTcnnvEYXTSVEeXSqnY9jsNIPgCffjhEF7el6dz720VLKHoQ9qA4wSc=
=1cDo
-----END PGP SIGNATURE-----
