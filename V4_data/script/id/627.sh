#!/bin/bash
# Date : (2010-05-15 08-00)
# Last revision : (2011-08-20 16:48)
# Distribution used to test : Fedora 12
# Author : NSLW & GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Fallout 3"
PREFIX="Fallout3"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the DLC Installer for $TITLE')"

POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Game is not installed.')" "$TITLE"
		POL_SetupWindow_Close
		exit
	fi
}

POL_SetupWindow_checkexist "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Using specific Wine
POL_SetupWindow_browse "$(eval_gettext 'Select a DLC to install')" "$TITLE" ""
SETUP_EXE="$APP_ANSWER"
POL_Wine start /unix "$SETUP_EXE"
POL_Wine_WaitExit

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk4xdJMACgkQ5TH6yaoTykfeBACdEIhxv+Dhjb24ZQCbUbwb67kZ
lx4AoLMleGgmybP0nVOeSCUtChGexXxd
=I/4P
-----END PGP SIGNATURE-----
