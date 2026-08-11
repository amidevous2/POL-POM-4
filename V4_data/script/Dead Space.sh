#!/bin/bash
# Date : (2010-12-04)
# Last revision : see changelog
# Wine version used : 1.3.8, 1.3.15, 1.3.27
# Distribution used to test : Debian Unstable
# Author : Berillions
# Updated by : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [Berillions] (2010-12-04)
#   Initial script.
# [GNU_Raziel] (2011-08-19 21:00)
#   ?
# [Dadu042] (2020-02-23 23:41)
#   Wine 1.3.27 -> 3.0.3.
#   Standardize.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dead Space"
PREFIX="DeadSpace"
WORKING_WINE_VERSION="3.0.3"
GAME_VMS="256"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/DS1/top.jpg" "http://files.playonlinux.com/resources/setups/DS1/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Electronic Arts" "http://www.deadspacegame.com/" "Berillions & GNU_Raziel" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,STEAM,LOCAL"


#Installing mandatory dependencies
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Call POL_Install_steam
fi

# Mandatory pre-install fix for steam
POL_Call POL_Install_steam_flags "17470"

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "AutoRun.exe"
	POL_Wine start /unix "$CDROM/AutoRun.exe"
	POL_Wine_WaitExit "$TITLE"
elif [ "$INSTALL_METHOD" == "STEAM" ]; then
	cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
	POL_Wine start /unix "steam.exe" steam://install/17470
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
# Set Graphic Card information keys for wine
POL_Wine_SetVideoDriver

# Sound problem fix - pulseaudio related
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

## Begin Common PlayOnMac Section ##
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section ##

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi

# Making shortcut
if [ "$INSTALL_METHOD" == "STEAM" ]; then
	POL_Shortcut "steam.exe" "$TITLE" "$TITLE.png" "steam://rungameid/17470"
else
	POL_Shortcut "Dead Space.exe" "$TITLE" "$TITLE.png" ""
fi

# Game protection warning
if [ "$INSTALL_METHOD" == "DVD" ]; then
	POL_Call POL_Function_NoCDWarning
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlI52AAKCRDlMfrJqhPK
R+g1AKCHzIGxmx8jao5tCsDQbh1pS/PcKQCfbl4vq0BMoQ/gyphUDfQSQjNklsA=
=qU4P
-----END PGP SIGNATURE-----
