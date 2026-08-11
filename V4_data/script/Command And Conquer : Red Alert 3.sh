#!/bin/bash
# Date : (2009-03-12 19-00)
# Last revision : X
# Wine version used : 1.2, 1.3.15, 1.3.25, 1.3.26, 1.3.27, 1.4.1
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2009-03-12 19-00)
#   First script.
# [GNU_Raziel] (2013-06-20 21:00)
#   ?
# [Dadu042] (2020-08-13)
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Command And Conquer : Red Alert 3"
SHORTCUT_NAME="Command And Conquer : Red Alert 3"
PREFIX="RA3"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="64"
STEAM_ID="17480"

if [ "$POL_LANG" == "fr" ]; then
	TITLE="Command And Conquer : Alerte Rouge 3"
	SHORTCUT_NAME="Command And Conquer : Red Alert 3"
fi

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ra3/top.jpg" "http://files.playonlinux.com/resources/setups/ra3/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 360

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Electronic Arts" "http://www.redalert3.com/" "GNU_Raziel" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam

	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"

	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "ra3.png" "steam://rungameid/$STEAM_ID" "Game;StrategyGame;"
	POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" "" "Game;"
fi
POL_Call POL_Install_gdiplus
POL_Call POL_Install_d3dx9

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
POL_Wine_OverrideDLL "builtin,native" "winhttp"

if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "AutoRun.exe"
	POL_Wine start /unix "$CDROM/AutoRun.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
else
	#Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "RA3.exe" "$TITLE" "ra3.png" "" "Game;StrategyGame;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXzUcawAKCRDlMfrJqhPK
R0GJAJ4ovhvfqEPz94gZNqpmsIdOGLMHcgCgogjVRg/4d51DPxg5DPHPlvYQSBU=
=GeN6
-----END PGP SIGNATURE-----
