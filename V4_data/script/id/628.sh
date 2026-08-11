#!/bin/bash
# Date : (2010-05-16)
# Last revision : see changelog
# Wine version used : 1.1.43
# Distribution used to test : Ubuntu 9.10
# Author : Marco Gerards
# Licence : GPLv3
# Depend : d3dx9, msxml3
#
# CHANGELOG
# [Marco Gerards] (2010-05-16))
#   First script.
# [Dadu042] (2020-01-02)
#   Make system wine version explicit.
#   Add GPU choice.
#   Update POL_Shortcut function

# This script was tested using the DVD version of `Civilization IV'
# version 1.61, bought in the Netherlands in 2010.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Civilization IV"
AUTHOR="Marco Gerards"
PREFIX="Civilization4"
PREFIXDIR="$REPERTOIRE/wineprefix/$PREFIX"

POL_SetupWindow_Init

POL_SetupWindow_presentation "$TITLE" "Firaxis Games" "http://www.firaxis.com/" "$AUTHOR" "$PREFIX"
POL_Wine_SelectPrefix "$PREFIXDIR"

# Let the user select a CDROM
POL_SetupWindow_cdrom

# Check if this CDROM is the Civilization IV CDROM
POL_SetupWindow_check_cdrom "Autorun/Civ4Installer.ico"

# Make sure the right wine version is used, otherwise
# the user will run into a problem regarding copyright protection.
POL_SetupWindow_install_wine "$WORKINGWINEVERSION"


# Create the prefix for Civilization IV, a directory called `Civilization4'
POL_SetupWindow_prefixcreate

PROGRAMFILES="Program Files" 
POL_LoadVar_PROGRAMFILES

# Install DirectX9
POL_Call POL_Install_d3dx9


################
#      GPU     #
################
    
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver
 
# Asking about memory size of graphic card
# POL_SetupWindow_VMS $GAME_VMS

# Useful for Nvidia GPUs
# POL_Call POL_Install_physx


# Run the installer
POL_SetupWindow_menu "Which installation medium do you want to use?" "Medium" "DVD~CDROM" "~"
wine start /unix "$CDROM/setup.exe"
if [ "$APP_ANSWER" == "CDROM" ]; then
POL_SetupWindow_message "When the installer asks you for the second CDROM, click Forward." "$TITLE"
wine eject
fi

POL_SetupWindow_message "Click Forward when the installation is finished" "$TITLE"
wine eject

# Setup an icon for the game
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Firaxis Games/Sid Meier's Civilization 4/Assets/res"
convert Civ4Game.ico Civ4Game.png
cp Civ4Game-1.png "$HOME/.PlayOnLinux/icones/32/$TITLE"

# Install MS XML 3, this should be done after the game is installed, otherwise it will not work.
POL_Call POL_Install_msxml3

# Make a short cut
POL_Shortcut "Civilization4.exeE" "$TITLE" "" "" "Game;"

# Done!
POL_SetupWindow_message "$TITLE installed"

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg5yVQAKCRDlMfrJqhPK
R28fAJ0VskiSHixesXTEHHqtxHsOSdu39wCfbEnbwbV4zUTiFsHyTJM2JfeWuTw=
=bN7R
-----END PGP SIGNATURE-----
