#!/usr/bin/env playonlinux-bash
# Date : (2015-06-15 10-21)
# Last revision : (2016-01-09 08-55)
# Wine version used : 1.6.2 (amd64)
# Distribution used to test : Linux Mint 17.2 KDE 64-bit
# Author : Justinian
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE_REQUIRED="Chessmaster: Grandmaster Edition"
TITLE="Chessmaster: Grandmaster Edition - Patch 1.02"
PREFIX="ChessmasterGrandmasterEdition"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Ubisoft" "http://www.ubi.com/" "Justinian" "$PREFIX"

if [ "$(POL_Wine_PrefixExists "$PREFIX")" = "True" ]
then
	POL_System_TmpCreate "$PREFIX"
	
	POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"
	
	if [ "$INSTALL_METHOD" = "LOCAL" ]
	then
		POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run.')" "$TITLE"
		INSTALLER="$APP_ANSWER"
	elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
	then
		cd "$POL_System_TmpDir"
		POL_Download "http://patches.ubi.com/chessmaster_xi/chessmaster_xi_1.02.exe" "1e66273ad3b5f4eabb90055b8e7a3cd4"
		INSTALLER="$POL_System_TmpDir/chessmaster_xi_1.02.exe"
	fi
	
	POL_Wine_SelectPrefix "$PREFIX"
	
	POL_Wine_WaitBefore "$TITLE"
	POL_Wine "$INSTALLER"
	
	POL_System_TmpDelete
else
	POL_Debug_Fatal "$(eval_gettext 'This is an installer for an update or an addon;\nPlease install $TITLE_REQUIRED first')"
fi

POL_SetupWindow_Close
exit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAladRkEACgkQ5TH6yaoTyke3rgCgsIaNGldsa41w3KRkb2loq4DS
AHcAn0nD1VH8VTWaK/LnTm7AN8rlPtJx
=31td
-----END PGP SIGNATURE-----
