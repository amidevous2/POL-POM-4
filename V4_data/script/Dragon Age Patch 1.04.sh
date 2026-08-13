#!/bin/bash
# Date : (2010-29-09 22-00)
# Last revision : (2011-09-02 17:37)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dragon Age : Origins"
PREFIX="daorigins"
PVERSION="1.04"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/daorigins/top.jpg" "http://files.playonlinux.com/resources/setups/daorigins/left.jpg" "$TITLE"
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
	PATCH_URL="http://files.bioware.com/dragonage/patch/1.04/DragonAge1.04.exe"
	PATCH_EXE="DragonAge1.04.exe"
	POL_SetupWindow_download "$(eval_gettext 'Wait while the patch is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "$PATCH_URL"
	POL_Wine start /unix "$PATCH_EXE"
	POL_Wine_WaitExit "$TITLE"
	rm "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk5hAwcACgkQ5TH6yaoTykcBQACfVy8AHWdlNDejq/DTcBUSgw8x
Kt8AoJW0uxBisOQh0WAGyuqNLXK5UoKJ
=JKLB
-----END PGP SIGNATURE-----
