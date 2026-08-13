#!/bin/bash
# Date : (2015-10-27 15-26)
# Last revision : (2015-11-27 19-12)
# Wine version used : 1.7.52
# Distribution used to test : Ubuntu 15.04 x64
# Author : Aleksandr Tishin (aka Mystic-Mirage)
# Program licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Pathologic Classic HD"
PREFIX="pathologic_classic_hd"
STEAM_ID="384110"
WORKING_WINE_VERSION="1.7.52"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2642
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Ice-pick Lodge" "http://www.ice-pick.com/" "Mystic-Mirage" "$PREFIX"

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

POL_SetupWindow_message "$(eval_gettext 'NOTICE: $TITLE will be installed via Steam. After Steam is installed, uncheck Run Steam, click Finish, and Steam will restart. Sign in and install $TITLE.')" "$TITLE"
POL_Call POL_Install_steam

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Install the game
POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine --ignore-errors "steam.exe" "steam://install/$STEAM_ID"
POL_Wine_WaitExit "$TITLE"

## Fix for this game
# Ask if the user want to play with a gamepad
POL_SetupWindow_question "$(eval_gettext 'Do you want to play the game with a gamepad? If not, the gamepad bindings will be removed to solve an issue with phantom key presses.')" "$TITLE"

# If not, remove gamepad bindings because of phantom key presses
if [ "$APP_ANSWER" = "FALSE" ]; then
    GAME_PATH=$(cd "$(dirname "$(find "$WINEPREFIX" -name "Game.exe")")/../.."; pwd -P)
    sed -i "/bind gp_/d" "$GAME_PATH/data/init.cfg"
fi
## End Fix

# Make shorcut to game executable because of running it via Steam is not working
POL_Shortcut "Game.exe" "$TITLE" "" "" "Game;"
POL_Shortcut "Steam.exe" "Steam ($TITLE)" "" "" "Game;"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlaiYisACgkQ5TH6yaoTykfB5QCgl01AcbcbP22Yt84H5O0ErdZj
jJkAnifhyTuwGiX2qY7g2AFi/X5IfWf/
=op2a
-----END PGP SIGNATURE-----
