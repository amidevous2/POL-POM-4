#!/bin/bash
# Date : (2008-09-07 19-00)
# Last revision : (2013-06-20 21:00)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Command And Conquer : Red Alert 3"
SHORTCUT_NAME="Command And Conquer : Red Alert 3"
PREFIX="RA3"
PVERSION="1.12"

if [ "$POL_LANG" == "fr" ]; then
	TITLE="Command And Conquer : Alerte Rouge 3"
	SHORTCUT_NAME="Command And Conquer : Red Alert 3"
fi

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/ra3/top.jpg" "http://files.playonlinux.com/resources/setups/ra3/left.jpg" "$TITLE"
POL_SetupWindow_Init
POL_SetupWindow_SetID 820

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION Installer for $TITLE')"

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

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
	POL_SetupWindow_Close
	exit
fi

# Asking about patch local or not
cd "$HOME"
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
	POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
	POL_Wine start /unix "$APP_ANSWER"
	POL_Wine_WaitExit
else
	cd "$POL_USER_ROOT/tmp"
	if [ "$POL_LANG" == "fr" ]; then
		PATCH_URL="http://na.llnet.cnc3tv.ea.com/u/f/eagames/cnc3/cnc3tv/RedAlert/RedAlert3Patch_112/RedAlert3_french_patch1.012.exe"
		PATCH_EXE="RedAlert3_french_patch1.012.exe"
	elif [ "$POL_LANG" == "de" ]; then
		PATCH_URL="http://na.llnet.cnc3tv.ea.com/u/f/eagames/cnc3/cnc3tv/RedAlert/RedAlert3Patch_112/RedAlert3_german_patch1.012.exe"
		PATCH_EXE="RedAlert3_german_patch1.012.exe"
	else
		PATCH_URL="http://na.llnet.cnc3tv.ea.com/u/f/eagames/cnc3/cnc3tv/RedAlert/RedAlert3Patch_112/RedAlert3_english_patch1.012.exe"
		PATCH_EXE="RedAlert3_english_patch1.012.exe"
	fi
	POL_SetupWindow_download "$(eval_gettext 'Wait while the patch is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "$PATCH_URL"
	POL_SetupWindow_wait_next_signal "$(eval_gettext 'Installation in progress...')" "$TITLE"
	POL_Wine start /unix "$PATCH_EXE"
	POL_Wine_WaitExit
	rm "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHDirkACgkQ5TH6yaoTykevaACeMZA5aCHpMbd6KwKHj1sq91MS
7OEAoKo5+0jnDjNHTYhEPbbBFt7AGqZM
=jL3E
-----END PGP SIGNATURE-----
