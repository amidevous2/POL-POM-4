#!/bin/bash
# Date : (2016-01-20 21-00)
# Wine version used : 1.7.52
# Distribution used to test : Xubuntu 15.10 x64
# Author : August Lindberg
# Program licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - Pathologic Classic HD"
SHORTCUT_NAME="Pathologic Classic HD"
PREFIX="PathologicClassicHd_gog"
WORKING_WINE_VERSION="1.7.52"
GOGID="pathologic_classic_hd"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/pathologic_classic_hd/top.jpg" "http://files.playonlinux.com/resources/setups/pathologic_classic_hd/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2720
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Ice-pick Lodge" "http://www.ice-pick.com/" "August Lindberg" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Forcing x86 to make wmp9 work
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing mandatory dependencies
POL_Call POL_Install_d3dx9_35
POL_Call POL_Install_d3dx9_36
POL_Call POL_Install_devenum
POL_Call POL_Install_quartz
POL_Call POL_Install_wmp9

# Choose setup file
POL_Call POL_GoG_setup "$GOGID" "d7a4ffe9afcf8aec87df436927b55b0e"

# Warn for installer errors
POL_SetupWindow_message "$(eval_gettext "The installer will probably throw a few errors during installation. This is nothing to worry about. Just press 'OK' when the errors appear and everything should work fine.")" "$TITLE"

# Install game
POL_Call POL_GoG_install "/nogui"

## Fix for this game
# Ask if the user want to play with a gamepad
POL_SetupWindow_question "$(eval_gettext 'Do you want to play the game with a gamepad? If not, the gamepad bindings will be removed to solve an issue with phantom key presses.')" "$TITLE"

# If not, remove gamepad's bindings because of phantom key presses
if [ "$APP_ANSWER" = "FALSE" ]; then
    GAME_PATH=$(cd "$(dirname "$(find "$WINEPREFIX" -name "Game.exe")")/../.."; pwd -P)
    sed -i "/bind gp_/d" "$GAME_PATH/data/init.cfg"
fi
## End Fix

# Create game shortcut
POL_Shortcut "Game.exe" "$SHORTCUT_NAME"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlahIGgACgkQ5TH6yaoTykfVwwCgq39W9qvt9JDXGtiNWDVy/jPW
OusAn3G6tE8Hk4Yqhr6YNN/fsitEJCR7
=ohT4
-----END PGP SIGNATURE-----
