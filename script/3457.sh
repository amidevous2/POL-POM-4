#!/bin/bash
# Date : (2019-02-21 23-56)
# Last revision : (2019-02-22 16-52)
# Wine version used : 3.0.3
# Distribution used to test : Ubuntu 18.04 x64
# Script licence : GPL3
# Program licence : Retail
 
# The DVD used (game version v1.0.8.3) is French.
# Date of Setup.exe is february 12th 2009.
# Note that on the DVD label the date printed is '2007'.
#
# Not tested: installation of 'GameCenter' (for online multiplay).
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Loki: Heroes of Mythology"
PREFIX="loki_heroes_of_mythology"
WORKING_WINE_VERSION="3.0.3"
AUTHOR="Dadu042"
EDITOR="Cyanide Studio"
GAME_URL="https://en.wikipedia.org/wiki/Loki:_Heroes_of_Mythology"
  
POL_SetupWindow_Init
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
POL_System_TmpCreate "$TITLE"
 
# d3dx9_43
 
POL_SetupWindow_InstallMethod "LOCAL,CD,STEAM"
 
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        cd "$POL_System_TmpDir"
  
elif [ "$INSTALL_METHOD" == "STEAM" ];then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/7260
        POL_Wine_WaitBefore "$TITLE"
else
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Setup-1b.bin"
        POL_Wine start /unix "$CDROM/Setup.exe"
        POL_Wine_WaitExit "Setup.exe"
        cd "$POL_System_TmpDir"
fi
  
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/7260"
else
        POL_Shortcut "Loki.exe" "$TITLE" ""
fi
 
POL_Shortcut_Document "$TITLE" "Manual.pdf"
 
POL_System_TmpDelete
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXUNVfQAKCRDlMfrJqhPK
R1oQAJ969HHe0bH/w7oWtDUaExbmq6251wCfZ6vsfhQPxC8j5dX/t+9k/ZJllmU=
=3e77
-----END PGP SIGNATURE-----
