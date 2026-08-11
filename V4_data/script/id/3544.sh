#!/bin/bash
#!/usr/bin/env playonlinux-bash
# Date : (2019-06-11 21-57)
# Last revision : (2019-06-11 21-57)
# Wine version used : see below
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
# Playonlinux v4.2.12
#
# Tested : version unknown, latest files date on DVD : 2014 ?
#
# Game based on: Steam.
#
# CHANGELOG
# [Dadu042] (2019-06-11)
#   First script.
# [Dadu042] (2019-12-30)
#   POL_RequiredVersion 4.0.0

 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Goat Simulator"
PREFIX="goat-simulator"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Coffee Stain Studios"
GAME_URL="https://en.wikipedia.org/wiki/Goat_Simulator"
  
POL_SetupWindow_Init
POL_Debug_Init
   
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

POL_RequiredVersion "4.0.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
Set_OS "win7"

POL_SetupWindow_InstallMethod "LOCAL,STEAM,DVD"
   
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        POL_Call POL_Install_steam
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
          
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/265930
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "sku.sys"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi
   
   
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/26593"
else
        POL_Shortcut "goat.exe" "$TITLE" "" "" "Game;"
        POL_Shortcut_Document "$TITLE" "*.pdf"
fi
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgqVjgAKCRDlMfrJqhPK
R618AJ4jIeEM0JLgSGaz46f0PXsaVMOz6gCfeqZRTwgwVYvnv9Y3aDGTBNxf8dE=
=E9vB
-----END PGP SIGNATURE-----
