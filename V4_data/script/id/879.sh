#!/bin/bash
# Date : (2011-07-16 21:00)
# Last revision : see changelog
# Wine version used : 1.3.23, 1.3.26, 1.3.33, 1.3.37, 1.4, 1.5.20, 1.7.24
# Distribution used to test : Linux Mint 11 x64, Arch Linux
# Author : GNU_Raziel, m1kc
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2011-07-16 21:00)
#   Initial script.
# [m1kc] (2014-08-26 12:28)
#   ?
# [Dadu042] (2020-01-27 23:30)
#   Wine 1.7.24 (outdated) -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Magicka"
TITLE_DEMO="Magicka (Demo)"
PREFIX="magicka"
EDITOR="Arrowhead Game Studios"
GAME_URL="http://www.magickagame.com/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="2.22"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/magicka/top.jpg" "http://files.playonlinux.com/resources/setups/magicka/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet35
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between Steam and other Digital Download versions
POL_SetupWindow_InstallMethod "STEAM_DEMO,STEAM,LOCAL"

# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_xna31
POL_Call POL_Install_dotnet35

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# The game refuses to run without GLSL, so we keep it.
# POL_Wine_Direct3D "UseGLSL" "disabled"

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Mandatory pre-install fix for steam
[ "$INSTALL_METHOD" == "STEAM_DEMO" ] && { STEAM_ID="73050"; SHORTCUT_NAME="$TITLE_DEMO"; }
[ "$INSTALL_METHOD" == "STEAM" ] && { STEAM_ID="42910"; SHORTCUT_NAME="$TITLE"; }

# Begin game installation
if [ "$INSTALL_METHOD" == "STEAM" ] || [ "$INSTALL_METHOD" == "STEAM_DEMO" ]; then
        # Mandatory pre-install fix for steam
        POL_Call POL_Install_steam_flags "$STEAM_ID"
        # Shortcut done before install for steam version
        POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$TITLE.png" "steam://rungameid/$STEAM_ID"
        POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" ""
        # Steam install
        POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished,\nDo NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
        cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
        POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
        POL_Wine_WaitExit "$TITLE"
else
        # Asking then installing DDV of the game
        cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
        SETUP_EXE="$APP_ANSWER"
        POL_Wine start /unix "$SETUP_EXE"
        POL_Wine_WaitExit "$TITLE"

        # Making shortcut
        POL_Shortcut "Magicka.exe" "$TITLE" "$TITLE.png" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjCEKAAKCRDlMfrJqhPK
R0ymAKChJAbQARlkORvUoZNlozDXUeRBQgCggaV2rKz+QdmUwXZ/Q+1qxoJYldQ=
=nNoi
-----END PGP SIGNATURE-----
