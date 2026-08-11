#!/bin/bash
# Date : (2010-30-10 21-00)
# Last revision : see changelog
# Wine version used : 1.3.6, 1.3.11, 1.3.15, 1.3.23, 1.3.26, 1.3.27, 1.4
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [SuperPlumus] (2013-07-23 21-41)
#   Update gettext messages
#   Fix script syntax error
# [Dadu042] (2020-01-21 10:50) (Ubuntu 19.04 64b)
#   Wine 1.4 (outdated) -> 2.22.
#

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Alien Breed 2 : Assault"
PREFIX="AlienBreed2"
EDITOR="Team17"
GAME_URL="http://www.team17.com/"
AUTHOR="GNU_Raziel"
WORKING_WINE_VERSION="2.22"
GAME_VMS="256"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/AB2/top.jpg" "http://files.playonlinux.com/resources/setups/AB2/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86" # For dotnet/mono
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between Steam and other Digital Download version
POL_SetupWindow_InstallMethod "STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" = "STEAM" ]; then
    POL_Call POL_Install_steam
    STEAM_ID="22650"
fi
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_d3dx9
POL_Call POL_Install_dotnet30

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Begin game installation
if [ "$INSTALL_METHOD" = "STEAM" ]; then
    # Mandatory pre-install fix for steam
    POL_Call POL_Install_steam_flags "$STEAM_ID"
    # Shortcut done before install for steam version
    POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"
    POL_Shortcut "steam.exe" "Steam ($TITLE)" "" ""
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
fi

#Post-install features
POL_SetupWindow_message "$(eval_gettext 'If .NET 3.0 installation fail, dont worry\nthe game will still work')" "$TITLE"
UE3=`find $WINEPREFIX -name "UE3Redist.exe"`
POL_Wine start /unix "$UE3"
POL_Wine_WaitExit "Unreal Engine 3.0 redist"

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
    POL_Shortcut "AlienBreed2Launcher.exe" "$TITLE" "$TITLE.png" "" "Game;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXididAAKCRDlMfrJqhPK
R+wXAJ0fFn+XJq/HMlA2r4z/igyQDmb2YgCcCTa4XN1HLT5W9J+k6KpFpJSa2nk=
=pCAS
-----END PGP SIGNATURE-----
