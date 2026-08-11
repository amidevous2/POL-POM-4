#!/bin/bash
# Changelog
# 
# [Quentin PARIS] (2011-10-29 18:48) Updated translations
#
# Date : (2010-03-03 17-20)
# Last revision : (2011-08-10 13:21)
# Wine version used : 1.2.3
# Distribution used to test : Debian Testing x64
# Author : thib25
# Updated by : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="18 Wheels of Steel : Haulin"
PREFIX="18WOSH"
WORKING_WINE_VERSION="1.2.3"
GAME_VMS="64"

# Starting the script
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "SCS Software" "http://www.scssoft.com/18-wheels-of-steel-haulin.php" "thib25" "$PREFIX" 

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Downloading wine if necessary and creating prefix
POL_System_SetArch "auto"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose between CD and Digital Download version
POL_SetupWindow_InstallMethod "CD,LOCAL"

# Begin installation
if [ "$INSTALL_METHOD" == "CD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	POL_Wine start /unix "$CDROM/setup.exe"
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Asking about memory size of graphic card
POL_SetupWindow_VMS $GAME_VMS

## Fix for this game
# Sound problem fix - pulseaudio related
POL_Wine_OverrideDLL "" "mmdevapi" # Only if wine < 1.2.4
[ "$POL_OS" = "Linux" ] && Set_SoundDriver "alsa"
[ "$POL_OS" = "Linux" ] && Set_SoundEmulDriver "Y"
## End Fix
 
## PlayOnMac Section
[ "$POL_OS" = "Mac" ] && Set_Managed "Off"
## End Section

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/*"
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/*"
fi

# Making shortcut
POL_Shortcut "haulin.exe" "$TITLE" "" ""
 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk6sMBQACgkQ5TH6yaoTykfKXgCdH+QQSa6LHk7fMemST73CrVpU
mlcAoKPy0IxS58r3x4Q7TKbrDYJdRh+z
=DCGv
-----END PGP SIGNATURE-----
