#!/bin/bash
# Date : (2016-09-07 14-00)
# Last revision : see changelog
# Wine version used : system
# Distribution used to test : Arch Linux x64
# Author : Pavello
# Script licence :
# Program licence : retail
# Depend :
#
# CHANGELOG
# [Dadu042] (2016-09-07 14-00)
#   First script.
# [Dadu042] (2019-12-31)
#   Wine 1.8.4 -> system


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Torchlight"
PREFIX="Torchlight"
EDITOR="Runic Games"
GAME_URL="Runic Games" "http://www.torchlightgame.com/"
AUTHOR="Pavello"
# WORKING_WINE_VERSION="1.8.4"
GAME_VMS="64"
  
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init
  
# Starting debugging API
POL_Debug_Init
  
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
  
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
  
# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"

POL_Wine_PrefixCreate
# POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
  
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
  
# Choose between Digital Download version
POL_SetupWindow_InstallMethod "STEAM,LOCAL"
  
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_vcrun2008
    POL_Call POL_Install_steam
    STEAM_ID="41500"
fi

## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##
  
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        # Mandatory pre-install fix for Steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Making shortcut
        POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/$STEAM_ID"
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
else
 	# Asking then installing local copy of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"
        # Making shortcuts
        POL_Shortcut "Torchlight.exe" "$TITLE" "$TITLE.png" "" "Game;"
	POL_Shortcut_Document "$TITLE" "TorchlightManual.pdf"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgtPgwAKCRDlMfrJqhPK
R/g3AJ4/47JH5z1YlkeWBSHIGh3IcTaXagCgilKlk0SrYkmqq69jeXcW6nMFCuQ=
=g79R
-----END PGP SIGNATURE-----
