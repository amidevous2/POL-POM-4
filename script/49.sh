#!/bin/bash
# Date : (2010-09-06 14:00)
# Last revision : (2012-04-21 21:00)
# Distribution used to test : Debian Testing x64 - Linux Mint Debian Edition x64
# Author : GNU_Raziel
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="The Elder Scrolls 4 - Oblivion - Shivering Isle"
PREFIX="TheElderScrolls4_Oblivion"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/oblivion/top.jpg" "http://files.playonlinux.com/resources/setups/oblivion/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "2K Games" "http://www.elderscrolls.com/games/oblivion_overview.htm" "GNU_Raziel" "$PREFIX"

POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Game is not installed.')" "$TITLE"
		POL_SetupWindow_Close
		exit 0
	fi
}

POL_SetupWindow_checkexist "$PREFIX"

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
	POL_SetupWindow_Close
	exit 0
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Choose between DVD and Digital Download version
POL_SetupWindow_InstallMethod "DVD,LOCAL"

# Begin game installation
if [ "$INSTALL_METHOD" == "DVD" ]; then
	# Asking for CDROM and checking if it's correct one
	POL_SetupWindow_message "$(eval_gettext 'Please insert game media into your disk drive\nif not already done.')" "$TITLE"
	POL_SetupWindow_cdrom
	if [ -e "$CDROM/French/setup.exe" ]; then # Multi5 version
		POL_SetupWindow_check_cdrom "French/setup.exe"
		if [ "$POL_LANG" == "fr" ]; then
			POL_Wine start /unix "$CDROM/French/setup.exe"
			POL_Wine_WaitExit "$TITLE"
		elif [ "$POL_LANG" == "es" ]; then
			POL_Wine start /unix "$CDROM/Spanish/setup.exe"
			POL_Wine_WaitExit "$TITLE"
		else
			POL_Wine start /unix "$CDROM/English/setup.exe"
			POL_Wine_WaitExit "$TITLE"
		fi
	else # US only version
		POL_SetupWindow_check_cdrom "Oblivion.ico"
		POL_Wine start /unix "$CDROM/setup.exe"
		POL_Wine_WaitExit "$TITLE"
	fi
else
	# Asking then installing DDV of the game
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run:')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
	POL_Wine start /unix "$SETUP_EXE"
	POL_Wine_WaitExit "$TITLE"
fi

# Warning about update
POL_SetupWindow_message "$(eval_gettext 'This addon automatically patch the game to 1.2.0416.')" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlF0SUMACgkQ5TH6yaoTykfLpQCeOKk5kgPJWdzbrEHYmiX9nECU
0L8AnRFCMuyO2FLaMMDTh3wlXNIR6Lls
=Hauj
-----END PGP SIGNATURE-----
