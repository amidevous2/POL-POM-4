#!/bin/bash
# Date : (2015-04-03)
# Distribution used to test : Kubuntu 14.04 LTS 64-bit
# Author : RoninDusette
# Licence : GPLv3
# PlayOnLinux: 4.2.6
#
# CHANGELOG
# [RoninDusette] (2015-04-03)
#   Initial script.
# [Dadu042] (2020-02-23 23:41)
#   Remove something useless.
#   Standardize.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="CitiesXLPlatinum"
TITLE="Cities XL Platinum"
EDITOR="Focus Home Interactive"
GAME_URL="http://www2.citiesxl.com/"
STEAM_ID="231140"
AUTHOR="RoninDusette"

#Initialization
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"
POL_SetupWindow_Init

POL_Debug_Init

# Presentation
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

# Create Prefix
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

# Configuration
Set_OS "winxp"

POL_SetupWindow_message "$(eval_gettext 'NOTICE: $TITLE will be installed via Steam. After Steam is installed, uncheck Run Steam, click Finish, and Steam will restart. Sign in and install $TITLE.')" "$TITLE"

#Dependencies
POL_Call POL_Install_steam

# Installation	
cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
POL_Wine_WaitExit "$TITLE"

# Create Shortcut
POL_Shortcut "steam.exe" "$TITLE" "" "steam://rungameid/$STEAM_ID"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlI04AAKCRDlMfrJqhPK
R4pKAJ9Gwt9mk7CUJRc1Jr2jSBB8Be4pagCeO5eMiorBIUfYHAXNuQOyrWGbIUQ=
=6xkZ
-----END PGP SIGNATURE-----
