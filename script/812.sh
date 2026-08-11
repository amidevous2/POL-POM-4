#!/bin/bash
# Date : (2011-07-03 21-00)
# Last revision : (2011-08-20 16:55)
# Distribution used to test : Debian Testing x64
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Fallout 3"
PREFIX="Fallout3"
PVERSION="1.07"

# Starting the script
rm "$POL_USER_ROOT/tmp/*.jpg"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION installer for $TITLE')"

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
	if [ "$GAME_LNG" == "fr" ]; then
		PATCH_URL="http://download.zenimax.com/fallout/3/patches/1.7/Fallout3_1.7_French.exe"
		PATCH_EXE="Fallout3_1.7_French.exe"
	elif [ "$GAME_LNG" == "de" ]; then
		PATCH_URL="http://download.zenimax.com/fallout/3/patches/1.7/Fallout3_1.7_German.exe"
		PATCH_EXE="Fallout3_1.7_German.exe"
	elif [ "$POL_LANG" == "es" ]; then
		PATCH_URL="http://download.zenimax.com/fallout/3/patches/1.7/Fallout3_1.7_Spanish.exe"
		PATCH_EXE="Fallout3_1.7_Spanish.exe"
	elif [ "$POL_LANG" == "it" ]; then
		PATCH_URL="http://download.zenimax.com/fallout/3/patches/1.7/Fallout3_1.7_Italian.exe"
		PATCH_EXE="Fallout3_1.7_Italian.exe"
	else
		PATCH_URL="http://download.zenimax.com/fallout/3/patches/1.7/Fallout3_1.7_English_US.exe"
		PATCH_EXE="Fallout3_1.7_English_US.exe"
	fi
	POL_SetupWindow_download "$(eval_gettext 'Wait while the patch is downloading...\nThis operation can take time, depending of your connexion.')" "$TITLE" "$PATCH_URL"
	POL_Wine start /unix "$PATCH_EXE"
	POL_Wine_WaitExit
	rm "$PATCH_EXE"
fi
 
POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAk5SaPgACgkQ5TH6yaoTykfymACghVnYMHB0O09WDsdLAHx1TVZV
zq8AoLLnVDDUNF2tSSn1VcZL+DoUda9h
=bb54
-----END PGP SIGNATURE-----
