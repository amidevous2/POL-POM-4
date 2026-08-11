#!/bin/bash
# Date : (2014-01-20)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Mac OS X 10.9.2
# Author : Marking
# Tested using Mac OS X 10.9.2

# CHANGELOG
# [Marking] (2014-01-20)
#   First script.
# [Dadu042] (2019-12-08)
#   Wine 1.7.15 -> 2.22
# [Dadu042] (2020-03-17)
#   Wine 1.7.15 -> 2.22 (fix)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

# Setup some needed variables
TITLE="Steins;Gate"
PREFIX="steinsgate"
WINEVERSION="2.22"
EDITOR="Nitroplus"
GAME_URL="http://steins-gate.us"
AUTHOR="Marking"
SHORTCUT_NAME="Steins;Gate"

# Download images for installation script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

# Initialize the script and debugging
POL_SetupWindow_Init
POL_SetupWindow_SetID 1988
POL_Debug_Init
 
# Setup presentation window
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Begin setting up the Wine Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Installs components needed to install game and play movies
POL_Call POL_Install_msxml3
POL_Call POL_Install_vcrun2010
POL_Call POL_Install_d3dx9
POL_Call POL_Install_quartz
POL_Call POL_Install_wmp10

# Ask user for either DVD or Local installation
POL_SetupWindow_InstallMethod "LOCAL,DVD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
	# Ask user to find "Setup.exe"
    cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please locate installation program (Setup.exe)')" "$TITLE"
	POL_Wine_WaitBefore "$TITLE"
	POL_Wine "$APP_ANSWER" /silent

elif [ "$INSTALL_METHOD" = "DVD" ]
then
	# Launches the installation program from CD/DVD
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "data.bin"
	POL_Wine_WaitBefore "$TITLE"
	POL_Wine "$CDROM/Setup.exe" /silent
fi
    
# Create a shortcut for easy access
POL_Shortcut "STEINSGATE.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnClwgAKCRDlMfrJqhPK
R4hjAJ0RnARZGAs4CyUn3c4YuVtPwbQCvQCfXn3PE+xlvMSYJhKJckBmvdhPrI0=
=/W5V
-----END PGP SIGNATURE-----
