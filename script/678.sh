#!/bin/bash
# Date : (2010-19-08 19-30)
# Last revision : (2012-05-18 21:00)
# Distribution used to test : Debian Squeeze (Testing)
# Author : GNU_Raziel
# Licence : Retail
# Only For : http://www.playonlinux.com
 
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Wolfenstein"
PREFIX="wolfenstein_2k9"
PVERSION="1.2"

#starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/wolf_2k9/top.jpg" "http://files.playonlinux.com/resources/setups/wolf_2k9/left.jpg" "Wolfenstein"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_free_presentation "$TITLE" "$(eval_gettext 'Welcome in the patch $PVERSION installer for $TITLE')"

POL_SetupWindow_checkexist()
{	
	if [ ! -e "$POL_USER_ROOT/wineprefix/$1" ]; then
		POL_SetupWindow_message "$(eval_gettext 'Game is not installed')" "$TITLE"
		POL_SetupWindow_Close
		exit 0
	fi
}

POL_SetupWindow_checkexist "$PREFIX"

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Asking about patch local or not
cd "$HOME"
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"
if [ "$INSTALL_METHOD" == "LOCAL" ]; then
	POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
	POL_Wine start /unix "$APP_ANSWER"
	POL_Wine_WaitExit "$TITLE"
else
	cd "$POL_USER_ROOT/tmp"
	if [ "$POL_LANG" == "de" ]; then
		PATCH_URL="http://dlh.net/cgi-bin/dlp.cgi?lang=&sys=pc&file=wolfenstein_1_2_deu_patch.zip&ref=ps"
	else
		PATCH_URL="http://dlh.net/cgi-bin/dlp.cgi?lang=&sys=pc&file=wolfenstein_1_2_patch.zip&ref=ps"
	fi
	POL_SetupWindow_message "$(eval_gettext 'Your browser will pop, download patch from it and uncompress it please')" "$TITLE"
	browser $PATCH_URL
	POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
	POL_Wine start /unix "$APP_ANSWER"
	POL_Wine_WaitExit "$TITLE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk+2jVgACgkQ5TH6yaoTykd4gwCfbF8eRjVp+Tz1Xr9ta/2GXVlb
72sAnjL6PiyJZtDNh47562pLqyaIA7ei
=2Lu1
-----END PGP SIGNATURE-----
