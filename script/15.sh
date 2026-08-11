#!/bin/bash
# Date : (2008-01-09 21-00)
# Last revision : see changelog
# Wine version used : 0.9.58, 1.1.0, 1.1.2, 1.2.3, 1.4.1
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2008-01-09 21-00)
#   Initial script.
# [GNU_Raziel] (2013-12-22 09:01)
#
# [Dadu042] (2020-01-29 22:00)
#   Wine 1.4.1 -> 3.0.3 (untested)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Fable : The Lost Chapters"
SHORTCUT_NAME="Fable : The Lost Chapters"
PREFIX="FableTheLostChapters"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="64"
STEAM_ID="204030"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/top.jpg" "http://files.playonlinux.com/resources/setups/ftlc/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 15

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microsoft Games" "http://www.microsoft.com/games/fable/default.asp" "GNU_Raziel" "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between CD and Digital Download version
POL_SetupWindow_InstallMethod "CD,STEAM,LOCAL"

# Installing mandatory dependancies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam

	# Mandatory pre-install fix for steam
	POL_Call POL_Install_steam_flags "$STEAM_ID"

	# Shortcut done before install for steam version
	POL_Shortcut "steam.exe" "$SHORTCUT_NAME" "" "steam://rungameid/$STEAM_ID" "Game;RolePlaying;"
	POL_Shortcut "steam.exe" "Steam ($SHORTCUT_NAME)" "" "" "Game;"
fi

POL_Wine_InstallFonts
POL_Call POL_Install_mfc42

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
POL_Wine_OverrideDLL "native,builtin" "quartz"

if [ "$INSTALL_METHOD" == "CD" ]; then
	# Copy content of CDs to HDD
	TEMP="$POL_USER_ROOT/tmp/$PREFIX"
	chmod -R 777 "$TEMP"
	rm -R "$TEMP"
	mkdir -p "$TEMP"
	cd "$WINEPREFIX"/dosdevices
	ln -s "$TEMP" d:
	# Asking for CDROM and checking if it's correct one
	# CD-ROM 1
	POL_SetupWindow_message "$(eval_gettext 'Please insert media 1 into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "install.exe"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
	cp -r "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	mv "$TEMP"/autorun.inf "$TEMP"/autorun-cd1.inf
	# CD-ROM 2
	POL_SetupWindow_message "$(eval_gettext 'Please insert media 2 into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "disk2c~1.cab"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
	cp -r "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	mv "$TEMP"/autorun.inf "$TEMP"/autorun-cd2.inf
	# CD-ROM 3
	POL_SetupWindow_message "$(eval_gettext 'Please insert media 3 into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "disk3c~1.cab"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
	cp -r "$CDROM"/* "$TEMP"
	chmod -R 777 "$TEMP"
	mv "$TEMP"/autorun.inf "$TEMP"/autorun-cd3.inf
	# CD-ROM 4
	POL_SetupWindow_message "$(eval_gettext 'Please insert media 4 into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "disk4c~1.cab"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Wait while the installation is prepared...')" "$TITLE"
	cp -r "$CDROM"/*.cab "$TEMP"
	chmod -R 777 "$TEMP"
	mv "$TEMP"/autorun.inf "$TEMP"/autorun-cd4.inf
	mv "$TEMP"/autorun-cd1.inf "$TEMP"/autorun.inf
	
	POL_Wine "d:\\install.exe"
	POL_Wine_WaitExit "$TITLE"
	
	# Relinking d: to $CDROM
	cd "$WINEPREFIX"/dosdevices
	rm ./d:
	ln -s "$CDROM" d:
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

# Installing other dependancies - need to be post-install for this game
POL_Call POL_Install_dxfullsetup
POL_Call POL_Install_wmp9
POL_Call POL_Install_wmpcodecs

# Making shortcut
if [ "$INSTALL_METHOD" != "STEAM" ]; then
	POL_Shortcut "Fable.exe" "$TITLE" "" "" "Game;RolePlaying;"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjIFUQAKCRDlMfrJqhPK
R4hLAJ48b+uHULBEX/7pS7tqRlCYvoLezACfb4GkYPEL6gjVN9xHt07osgS96To=
=8wa4
-----END PGP SIGNATURE-----
