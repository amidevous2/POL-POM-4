#!/bin/bash
# Date : (2008-09-07 23-00)
# Last revision : (2013-06-20 21:00)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Command And Conquer : Red Alert 3 : Uprising"
SHORTCUT_NAME="Command And Conquer : Red Alert 3 : Uprising"
PREFIX="RA3"
STEAM_ID="24800"

if [ "$POL_LANG" == "fr" ]; then
	TITLE="Command And Conquer : Alerte Rouge 3 : La Révolte"
	SHORTCUT_NAME="Command And Conquer : Alerte Rouge 3 : La Révolte"
fi

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ra3_addon/top.jpg" "http://files.playonlinux.com/resources/setups/ra3_addon/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 819

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Electronic Arts" "http://www.redalert3.com/" "GNU_Raziel" "$PREFIX"

# Check if the main game is installed
POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Game is not installed.')" "$TITLE"
		POL_SetupWindow_Close
		exit 0
	fi
}

POL_SetupWindow_checkexist "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"

if [ "$INSTALL_METHOD" == "STEAM" ]; then
	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"

	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "ra3.png" "steam://rungameid/$STEAM_ID" "Game;StrategyGame;"
	POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" "" "Game;"
fi

if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "EASetup.exe"
	POL_Wine start /unix "$CDROM/EASetup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "RA3EP1.exe" "$TITLE" "ra3ep1.png" "" "Game;StrategyGame;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDiikACgkQ5TH6yaoTykfUnACgggNrrZxdpejGel4Hd7+c3prT
j+AAn18R/BcJS2cH+H7CG1jl3GfRzLVJ
=vVP0
-----END PGP SIGNATURE-----
