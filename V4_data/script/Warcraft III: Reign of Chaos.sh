#!/bin/bash
# Date : (2009-06-07 15-40)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Fedora 13 & Debian Squeeze x86_64
# Author : Quentin PÂRIS
# Licence : Retail
#
# CHANGELOG
# [Quentin PÂRIS] (2009-06-07 15-40)
#   Initial script. Wine 1.3.24 ?
# [?] (2011-07-17 19-45)
#
# [Dadu042] (2020-01-22 13:30)
#   Wine 1.9.4 -> 3.0.3
#   Improve POL_Shortcut

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Warcraft III - Reign Of Chaos"
PREFIX="WarcraftIII"
WINEVERSION="3.0.3"


POL_SetupWindow_Init
POL_Debug_Init
#Presentation
POL_SetupWindow_presentation "$TITLE" "Blizzard Entertainment" "http://www.blizzard.com" "Quentin PÂRIS" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"

if [ "$POL_SELECTED_FILE" ];  then
	SetupIs="$POL_SELECTED_FILE" 
else
	POL_SetupWindow_InstallMethod "LOCAL,CD"
	if [ "$INSTALL_METHOD" = "CD" ]; then
		POL_RequiredVersion "4.0.20" || POL_Debug_Fatal "Sorry, $APPLICATION_TITLE 4.0.20 is required to install $TITLE from CD-ROM"
		POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disk drive.')" "$TITLE"
		POL_SetupWindow_cdrom

		POL_SetupWindow_check_cdrom "install.exe" "installer.exe"
		SetupIs="$CDROM_SETUP" 
		POL_SetupWindow_message "$(eval_gettext 'The CD-ROM version is out to date. Do not forget to update $TITLE if you want it to run correctly with $APPLICATION_TITLE')" "$TITLE"
	fi
	if [ "$INSTALL_METHOD" = "LOCAL" ]; then
		POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
		SetupIs="$APP_ANSWER"
	fi
fi

[ "$SetupIs" = "" ] && exit 0
POL_Wine_PrefixCreate "$WINEVERSION"

[ "$POL_OS" = "Mac" ] && Set_Managed Off
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SetupIs"
POL_Wine_WaitExit "$TITLE"

POL_SetupWindow_VMS

POL_Shortcut "Warcraft III.exe" "$TITLE" "" "" "Game;"
POL_Shortcut_QuietDebug "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXjNUawAKCRDlMfrJqhPK
R1DWAKCQJvfEhOZtqpIghXdk20olM/O1lgCeKOov1hGxFZJT4NvA2xZNtGZkjhs=
=3cou
-----END PGP SIGNATURE-----
