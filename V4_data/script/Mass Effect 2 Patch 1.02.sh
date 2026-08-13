=#!/bin/bash
# Date : (2009-03-28 12:00)
# Last revision : (2012-04-22 21:00)
# Distribution used to test : Debian Testing x64 - Linux Mint Debian Edition x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Mass Effect 2"
PREFIX="MassEffect2"
PVERSION="1.02"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ME2/top.jpg" "http://files.playonlinux.com/resources/setups/ME2/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION installer for $TITLE')"

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

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
	POL_SetupWindow_Close
	exit 0
fi

# Asking about patch local or not
cd "$HOME"
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
	POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
	POL_Wine start /unix "$APP_ANSWER"
	POL_Wine_WaitExit "$TITLE"
else
	cd "$POL_USER_ROOT/tmp"
	PATCH_URL="http://static.cdn.ea.com/bioware/u/f/eagames/bioware/masseffect2/patch/1.02/MassEffect2-1.02.exe"
	PATCH_EXE="MassEffect2-1.02.exe"
	POL_SetupWindow_download "$(eval_gettext 'Wait while the patch is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "$PATCH_URL"
	POL_Wine start /unix "$PATCH_EXE"
	POL_Wine_WaitExit "$TITLE"
	rm "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlF1wkMACgkQ5TH6yaoTykfHGgCfVOM0Jz/UTTrR+oI2yDQlJY/X
NSMAn2w3aI4l1m5m1OLNk2YbiOjNVty5
=Wb4n
-----END PGP SIGNATURE-----
