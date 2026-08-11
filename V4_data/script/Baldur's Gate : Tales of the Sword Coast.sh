#!/bin/bash
# Date : (2010-03-12 21-00)
# Last revision : (2012-04-22 21:00)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit
source "$PLAYONLINUX/lib/sources"

TITLE="Baldur's Gate : Tales of the Sword Coast"
PREFIX="BaldursGate1"
EDITOR="BioWare"
GAME_URL="http://www.bioware.com/games/tales_sword_coast/"
AUTHOR="GNU_Raziel"
GAME_VMS="128"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/BG1/top.jpg" "http://files.playonlinux.com/resources/setups/BG1/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$GAME_URL" "$AUTHOR" "$PREFIX"

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

# Choose between CD and Digital Download version
POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" == "CD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive')"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "BGMain2.exe"
	POL_Wine start /unix "$CDROM/Setup.exe"
	POL_Wine_WaitExit "$TITLE"
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Cleaning temp
if [ -e "$WINEPREFIX/drive_c/windows/temp/" ]; then
	rm -rf "$WINEPREFIX/drive_c/windows/temp/"*
	chmod -R 777 "$POL_USER_ROOT/tmp/"
	rm -rf "$POL_USER_ROOT/tmp/"*
fi

POL_SetupWindow_message "$(eval_gettext 'This addon automatically install patch 1.3.5511')" "$TITLE" 
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+ULBMACgkQ5TH6yaoTykfw6gCdGHjdJBj4cI0KJPeRlCPmxVxH
qXUAoLBXuFBYdPZRoo5VyqFjI0uS7rw9
=qeZ8
-----END PGP SIGNATURE-----
