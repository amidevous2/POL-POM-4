#!/bin/bash
# Date : (2010-09-06 14:00)
# Last revision : (2013-08-11 21:32)
# Distribution used to test : Debian Testing x64 - Linux Mint Debian Edition x64
# Author : GNU_Raziel
#   updates: petch
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE_REQUIRED="The Elder Scrolls 4 - Oblivion"
TITLE="The Elder Scrolls IV - Oblivion Patch 1.2.0416"
PREFIX="TheElderScrolls4_Oblivion"

# Starting the script
POL_GetSetupImages "http://files.playonlinux.com/resources/setups/oblivion/top.jpg" "http://files.playonlinux.com/resources/setups/oblivion/left.jpg" "$TITLE"
POL_SetupWindow_Init

# Starting debugging API
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Bethsoft" "http://support.bethsoft.com/patches.php" "GNU_Raziel" "$PREFIX"

if [ "$(POL_Wine_PrefixExists $PREFIX)" != "True" ]; then
	POL_SetupWindow_message "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')" "$TITLE"
	POL_SetupWindow_Close
	exit 1
fi

# Check if it's Steam version
STEAM=`find $WINEPREFIX -name "Steam.exe"`
if [ "$STEAM" != "" ]; then
	POL_SetupWindow_message "$(eval_gettext 'Steam have is own automatic update system.')" "$TITLE"
	POL_SetupWindow_Close
	exit 1
fi

# Setting prefix path
POL_Wine_SelectPrefix "$PREFIX"

# Asking about patch local or not
POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" == "LOCAL" ]; then
	cd "$HOME"
	POL_SetupWindow_browse "$(eval_gettext 'Select patch to execute')" "$TITLE" ""
	POL_Wine "$APP_ANSWER"
	POL_Wine_WaitExit "$TITLE"
else
	cd "$POL_USER_ROOT/tmp/"
	BASEURL="http://download.zenimax.com/elderscrolls/oblivion/patches/1.2/"
	if [ "$POL_LANG" == "fr" ]; then
		PATCH_EXE="Oblivion_v1.2.0416French.exe"
		PATCH_URL="${BASEURL}${PATCH_EXE}"
		PATCH_MD5="3d8eba842a02a94d5e1d21b200a4c0e6"
	elif [ "$POL_LANG" == "de" ]; then
		PATCH_EXE="Oblivion_v1.2.0416German.exe"
		PATCH_URL="${BASEURL}${PATCH_EXE}"
		PATCH_MD5="deb9023290151f20123a0b21793b9042"
	elif [ "$POL_LANG" == "es" ]; then
		PATCH_EXE="Oblivion_v1.2.0416Spanish.exe"
		PATCH_URL="${BASEURL}${PATCH_EXE}"
		PATCH_MD5="80d207296b8d7872f4e3ddd6adcc2558"
	elif [ "$POL_LANG" == "it" ]; then
		PATCH_EXE="Oblivion_v1.2.0416Italian.exe"
		PATCH_URL="${BASEURL}${PATCH_EXE}"
		PATCH_MD5="1c09263c47b3c531dbb64911f621c3c9"
	else
		PATCH_EXE="Oblivion_v1.2.0416English.exe"
		PATCH_URL="${BASEURL}${PATCH_EXE}"
		PATCH_MD5="f2a058835e18144212a37a1615897268"
	fi
	POL_Download "$PATCH_URL" "$PATCH_MD5"
	POL_Wine "$PATCH_EXE"
	POL_Wine_WaitExit "$TITLE"
	rm "$PATCH_EXE"
fi

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJa09AACgkQ5TH6yaoTykcqpgCglnQIdo1ayIINX4uL/RxHNWPY
06kAn2kBcWkn/CGAYUDAZC0BmIqUbGuZ
=PQIN
-----END PGP SIGNATURE-----
