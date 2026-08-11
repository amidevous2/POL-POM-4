#!/bin/bash
# Date : (2011-06-04 21-00)
# Last revision : (2011-08-18 19:58)
# Wine version used : 1.3.17, 1.3.23, 1.3.26
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

# CHANGELOG
# [GNU_Raziel] (2011-06-04)
#   First script.
# [Dadu042] (2019-08-12)
#   Wine 1.3.26 -> 2.22


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="CreaVures"
PREFIX="creavures"
WORKING_WINE_VERSION="2.22"
GAME_VMS="256"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/creavures/top.jpg" "http://files.playonlinux.com/resources/setups/creavures/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Muse Games" "http://musegames.com/" "GNU_Raziel" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between Steam and other Digital Download version
POL_SetupWindow_InstallMethod "STEAM,LOCAL"

# Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
fi

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "49810"

if [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/49810
	POL_Wine_WaitExit "$TITLE"
else 
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi

# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/49810"
else
	POL_Shortcut "Creavures.exe" "$TITLE" "$TITLE.png" ""
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXbmcYwAKCRDlMfrJqhPK
R0wEAKCLC99KbI3/UYRseIJMTaDF1eLLKACeOaidRWnXl11+muMvPXCbFCz5mMQ=
=+Ip3
-----END PGP SIGNATURE-----
