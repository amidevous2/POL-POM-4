#!/bin/bash
# Date : (2013-03-16 21:00)
# Last revision : see changelog
# Wine version used : see changelog
# Distribution used to test : Linux Mint 12 x64
# Author : rcmn
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [lahtis] (2013-02-18)
#   First script.
# [Dadu042] (2020-03-28)
#   Wine 1.5.24 (outdated) -> 3.0.3 (not tested)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Torchlight2 Steam"
PREFIX="Torchlight2Steam"
EDITOR="Runic Games"
GAME_URL="Runic Games" "http://www.torchlight2game.com/"
AUTHOR="rcmn"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="512"
 
# Starting the script
#POL_GetSetupImages "http://files.playonlinux.com/resources/setups/torchlight2/top.jpg" "http://files.playonlinux.com/resources/setups/torchlight2/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between Digital Download version
POL_SetupWindow_InstallMethod "STEAM"
 
# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_dxfullsetup
 
# Mandatory pre-install fix for steam
STEAM_ID="200710"
POL_Call POL_Install_steam_flags "$STEAM_ID"
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS
 
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##
 
# Making shortcut
POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
 
# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ]; then
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
fi
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXn/Z3gAKCRDlMfrJqhPK
RweJAJ0aD2gOvFWU74SeV1dX55S9aPcwZQCfeKERCjvROFmyn9MwPoo2McWciWY=
=prwZ
-----END PGP SIGNATURE-----
