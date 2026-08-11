#!/bin/bash
# Date : (2010-09-06 14:00)
# Last revision : see changelog
# Wine version used : 1.3.1, 1.3.28, 1.5.28, 2.18
# Distribution used to test : Debian Testing x64 - Linux Mint Debian Edition x64 - AntergOS KDE x64
# Author : GNU_Raziel
# Licence : Retail

# CHANGELOG
# [GNU_Raziel] (2010-09-06 14:00)
#   Initial script
# [Lazalatin] (2017-10-14 12:00)
#   Wine 1.5.28 -> 2.18
#   Install d3dx9 and directmusic for optimal gaming experience
# [Dadu042] (2020-01-09 10:00)
#   Wine 2.18 -> 2.22 (to avoid multiple versions installed. Perhaps 3.0.3 would work fine too).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Elder Scrolls 4 - Oblivion"
PREFIX="TheElderScrolls4_Oblivion"
WORKING_WINE_VERSION="2.22"
GAME_VMS="128"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/oblivion/top.jpg" "http://files.playonlinux.com/resources/setups/oblivion/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "2K Games" "http://www.elderscrolls.com/games/oblivion_overview.htm" "GNU_Raziel" "$PREFIX"

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
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_SetupWindow_menu "$(eval_gettext 'Which edition do you have?')" "$TITLE" "Game of the Year~Game of the Year Deluxe Edition" "~"
	if [ "$APP_ANSWER" == "Game of the Year" ]; then
		STEAM_ID="22330"
	else
		STEAM_ID="900883"
	fi

	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"

	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/22330" "Game;RolePlaying;"
	POL_Shortcut "steam.exe" "Steam ($TITLE)" "" "" "Game;"
fi

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "OblivionLauncher.exe"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	# Steam install
	POL_SetupWindow_message "$(eval_gettext 'When $TITLE download by Steam is finished, do NOT click on Play.\n\nClose COMPLETELY the Steam interface, \nso that the installation script can continue')" "$TITLE"
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/$STEAM_ID
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd $HOME
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Install d3dx9 and directmusic for optimal gaming experience
POL_Call POL_Install_d3dx9 # Otherwise game will not run
POL_Call POL_Install_directmusic # Otherwise music will not play

# Setting mandatory game modifications
#GAME_PATH=`find $WINEPREFIX -name "OblivionLauncher.exe" | sed s/OblivionLauncher.exe//g`
#cd "$GAME_PATH"
#mv "Oblivion_default.ini" "Oblivion_default.ini.save"
#cat "Oblivion_default.ini.save" | sed s/bForce1XShaders=1/bForce1XShaders=0/g | sed s/bSaveOnInteriorExteriorSwitch=1/bSaveOnInteriorExteriorSwitch=0/g | sed s/bUseWaterShader=1/bUseWaterShader=0/g > "Oblivion_default.ini"

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "OblivionLauncher.exe" "$TITLE" "ElderScroll4_Oblivion.xpm" "" "Game;RolePlaying;"

	# Warning about update
	POL_SetupWindow_message "$(eval_gettext 'If you do not have "Shivering Isle" addon\n you must update this game before using it.')" "$TITLE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXhbuVQAKCRDlMfrJqhPK
R10VAJ0dcVPn9tKbYNFjcbvcEWWyHMa/TgCfVG2NBqQfnRRlimf2LMvW9oFmRFg=
=3SLQ
-----END PGP SIGNATURE-----
