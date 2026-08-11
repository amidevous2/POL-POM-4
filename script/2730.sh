#!/bin/bash
# Date : (2015-02-15)
# Distribution used to test : Ubuntu 15.10 64-bit
# Author : Daniel Moore
# Licence : GPLv3
# PlayOnLinux: 4.2.6
#
# CHANGELOG
# [Daniel Moore] (2015-02-15)
#   Initial script.
# [Dadu042] (2020-01-16 22:00)
#   Wine 1.7.39 -> 2.22

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

PREFIX="SouthParkTheStickofTruth"
WINEVERSION="2.22"
TITLE="South Park™: The Stick of Truth™"
EDITOR="Sublime Text 2"
GAME_URL="http://southpark.ubi.com/stickoftruth/"
STEAM_ID="213670"

AUTHOR="DanielMoore"

#Initialization
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

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiDUUAAKCRDlMfrJqhPK
R4tTAJ92a52K5kCz0vaKHsfpYKsJ9aVssACgi/Ellaekh4gDKnyFEU773oX8hSw=
=ZYK4
-----END PGP SIGNATURE-----
