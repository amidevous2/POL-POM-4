#!/bin/bash
# Date : (2018-02-09 17-33)
# Last revision : see changelog
# Wine version used :
# Distribution used to test : Ubuntu 18.04 x64
# Author : LinuxScripter
# Licence : Retail

#
# CHANGELOG
# [LinuxScripter] (2018-02-09 17-33)
#   Initial script.
# [Dadu042] (2019-05-20 22-58)
#   Fix filenames for DVD edition
# [Dadu042] (2020-03-27)
#   Wine 3.1 (uncommon) -> 3.0.3
#   Add ability to install from a local file.
#   Fix POL_Shortcut
  
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
PREFIX="Spore"
WORKING_WINE_VERSION="3.0.3"
TITLE="Spore"
EDITOR="Maxis"
GAME_URL="https://pcgamingwiki.com/wiki/Spore"
AUTHOR="LinuxScripter and Dadu042"
STEAM_ID="17390"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
 
POL_SetupWindow_Init
POL_SetupWindow_SetID 324
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
POL_Wine_SelectPrefix "$PREFIX"
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

Set_OS "win7"
  
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
if [ "$INSTALL_METHOD" = "DVD" ]; then
        POL_SetupWindow_cdrom
        POL_SetupWindow_check_cdrom "Spore.ico"
        POL_Wine start /unix "$CDROM/SPORESetup.exe"
        POL_Wine_WaitExit "SPORESetup.exe"

        POL_Shortcut "SporeApp.exe" "$TITLE" "" "" "Game;"
        
elif [ "$INSTALL_METHOD" == "LOCAL" ]; then
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "Spore"

        POL_Shortcut "SporeApp.exe" "$TITLE" "" "" "Game;"
        
elif [ "$INSTALL_METHOD" == "CD" ]; then
        POL_Call POL_Install_steam
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitBefore "$TITLE"
fi
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXn5JwQAKCRDlMfrJqhPK
R09BAKCihG1MdmYrXJJMidi1utIk+H2gBgCgmH1VJrZ4YImquqI0TUKgIKFchEE=
=Lw4i
-----END PGP SIGNATURE-----
