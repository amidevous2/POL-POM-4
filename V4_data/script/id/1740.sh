#!/bin/bash
# Date : (2013-06-15 ??-??)
# Last revision : (2013-12-10 10-06)
# Distribution used to test : Kubuntu 12.04.2 LTS x64
# Author : DJYoshaBYD
# Licence : GPLv3
# PlayOnLinux: 4.2.1

# CHANGELOG
# [SuperPlumus] (2013-12-10 10-06)
#   Update gettext messages

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="Civ5"
WINEVERSION="1.7.20"
TITLE="Civilization V"
EDITOR="Take-Two Interactive"
GAME_URL="http://www.civilization.com/"
AUTHOR="DJYoshaBYD"
STEAM_ID="8930"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create Prefix
POL_SetupWindow_InstallMethod "DVD,STEAM"
POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Dependencies & overrides
POL_Wine_OverrideDLL "native" "msxml3"
POL_Call POL_Install_vcrun2008
POL_Call POL_Install_d3dx9
POL_Call POL_Install_msxml3
POL_Call POL_Install_vcrun6

# Configuration
Set_OS "winxp"
Set_SoundDriver "alsa"

# Installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
    cd "$HOME"
    POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
    POL_Wine_WaitBefore "$TITLE"
    POL_Wine "$APP_ANSWER"
    POL_Wine_WaitExit "$TITLE"
else
    # Install Steam
    POL_Call POL_Install_steam

    # Start steam, update it, and install the game
    cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
    POL_Wine start /unix "Steam.exe" steam://install/$STEAM_ID
    POL_SetupWindow_message "$(eval_gettext 'Steam is about to perform an update.\nAfter Steam finishes updating and shows you to the login interface, login and then let $TITLE install.\n\nWhen the installation is finished, press next')" "$TITLE"

    # Make sure that Steam is closed
    killall steam.exe
fi

# Create Shortcuts
if [ "$INSTALL_METHOD" == "DVD" ]; then
    POL_Shortcut "CivilizationV.exe" "$TITLE"
else
    POL_Shortcut "Steam.exe" "$TITLE" "" "-applaunch $STEAM_ID" "Game;StrategyGame;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCYEzqEAAKCRDlMfrJqhPK
R8iJAJ9Ds0JKLq1eYLKfwB+Gtcpht++11wCeLD38oy8PECiM+Cubn2jB2Z9ty1c=
=H6xE
-----END PGP SIGNATURE-----
