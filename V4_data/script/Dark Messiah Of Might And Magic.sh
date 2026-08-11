#!/bin/bash
# Date : (2010-31-08 13-00)
# Last revision : See changelog below
# Wine version used : 1.2, 1.2.1, 1.2.3, 1.5.28, 2.22
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
# CHANGELOG
# [SuperPlumus] (2013-07-24 14-22)
#   Update gettext messages
# [SuperPlumus] (2013-07-27)
#   Wine 1.5.28 -> 2.22
#   Minimum VRAM required by the game is 256 MB, not 128.
#   Can select between 2 GPU cards.
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="Dark Messiah of Might and Magic"
PREFIX="DarkMessiah"
WORKING_WINE_VERSION="2.22"
GAME_VMS="256"
 
# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/top.jpg" "http://files.playonlinux.com/resources/setups/darkmessiah/left.jpg" "$TITLE"
POL_SetupWindow_Init
 
# Starting debugging API
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Arkane Studios" "http://www.mightandmagic.com/fr" "GNU_Raziel" "$PREFIX"
 
# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"
 
# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"
 
# Installing mandatory dependencies
if [ "$INSTALL_METHOD" = "STEAM" ]; then
    POL_Call POL_Install_steam
fi
POL_Call POL_Install_d3dx9
 
# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "2100"
 
# Begin game installation
if [ "$INSTALL_METHOD" = "DVD" ]; then
    # Asking for CDROM and checking if it's correct one
    POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
    POL_SetupWindow_cdrom
    POL_SetupWindow_check_cdrom "Disk1/setup.exe"
    POL_Wine start /unix "$CDROM/Disk1/setup.exe"
    POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" = "STEAM" ]; then
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine start /unix "steam.exe" steam://install/2100
    POL_Wine_WaitExit "$TITLE"
else
    # Asking then installing DDV of the game
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    SETUP_EXE="$APP_ANSWER"
    POL_Wine start /unix "$SETUP_EXE"
    POL_Wine_WaitExit "$TITLE"
fi
 
# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Fix for this game
if [ "$INSTALL_METHOD" != "STEAM" ]; then
    POL_Wine_OverrideDLL "" "gameoverlayrenderer"
fi
 
# Making shortcut
if [ "$INSTALL_METHOD" = "STEAM" ]; then
    POL_Shortcut "steam.exe" "$TITLE" "DarkMessiahOfMightAndMagic.xpm" "steam://rungameid/2100"
else
    POL_Shortcut "mm.exe" "$TITLE" "DarkMessiahOfMightAndMagic.xpm" ""
fi
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbW1iwAKCRDlMfrJqhPK
R3sAAJ4kKttguicZVmBOt8cG/ENjsIUk1gCfYNJK0jRtci3UjkYy79WcdvPike8=
=Ke/4
-----END PGP SIGNATURE-----
