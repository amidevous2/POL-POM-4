#!/bin/bash
# Date : (2011-16-07 21-00)
# Last revision : see changelog
# Wine version used : 
# Distribution used to test : Linux Mint 11 x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
#
# CHANGELOG
# [GNU_Raziel] (2011-16-07 21-00)
#   Initial script.
# [Dadu042] (2020-02-23 23:41)
#   Wine 1.3.23 -> system's wine.
#   Standardize.

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Cars 2"
PREFIX="cars2"
GAME_VMS="256"

# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Avalanche Software" "http://www.avalanchesoftware.com/" "GNU_Raziel" "$PREFIX" 

# Game protection warning
POL_Call POL_Function_NoCDWarning

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "x86"
POL_Wine_PrefixCreate

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,LOCAL"

# Installing mandatory dependencies
POL_Call POL_Install_vcrun2008

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "icons/cars2.ico"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "$TITLE"
else
	#Asking then installing DDV of the game
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
POL_Wine_OverrideDLL "" "mmdevapi" # Only if wine < 1.3.25
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix

## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
fi

# Making shortcut
POL_Shortcut "Game-Cars.exe" "$TITLE" "$TITLE.png" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlIw9wAKCRDlMfrJqhPK
R/PfAJ4nUMpHSIQxUeuHTBZKyyf2GbDT2QCfbJOrwhS/yzkZM58CL3p1PiqpZMU=
=PETk
-----END PGP SIGNATURE-----
