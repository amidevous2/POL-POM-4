#!/bin/bash
# Date : (2009-03-28 12:00)
# Last revision : see changelog
# Wine version used : 1.2.2-Mousepatch, 1.3.23, 1.3.28, 1.3.29
# Distribution used to test : Debian Testing x64 - Linux Mint Debian Edition x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Dadu042] (2009-03-28 12:00)
#   Initial script.
# [?] (2013-04-27 21:00)
#   ?
# [Dadu042] (2020-01-30 13:30)
#   Wine 1.3.29 -> 3.0.3


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Mass Effect 2"
SHORTCUT_NAME="Mass Effect 2"
PREFIX="MassEffect2"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="128"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ME2/top.jpg" "http://files.playonlinux.com/resources/setups/ME2/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 609

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "BioWare" "http://masseffect.bioware.com/me2" "GNU_Raziel" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Installing mandatory dependencies
POL_Call POL_Install_steam
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_physx

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Fix for this game
POL_Wine_X11Drv "GrabFullscreen" "Y"

# Set Graphic Card informations keys for wine
POL_Wine_SetVideoDriver

# Begin game installation
POL_SetupWindow_menu "$(eval_gettext 'Which edition do you have?')" "$TITLE" "$(eval_gettext 'Normal version')~$(eval_gettext 'Digital Deluxe version')" "~"
if [ "$APP_ANSWER" == "$(eval_gettext 'Normal version')" ]; then
	STEAM_ID="24980"
else
	STEAM_ID="901242"
fi
# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "$STEAM_ID"

# Shortcut done before install for steam version
POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "steam://rungameid/$STEAM_ID" "Game;RolePlaying;"
POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" "" "Game;"

cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNW9wAKCRDlMfrJqhPK
RwjdAKCyPRWqH0aCnLPe4LsrJ2hpoiXu5QCgiFNb/JP3Y2Hbu9x0jRYL0B+voZQ=
=zfl6
-----END PGP SIGNATURE-----
