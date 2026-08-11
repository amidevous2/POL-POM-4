#!/bin/bash
#
# App: Resident Evil 3
# Category: Games
# Wine rating: Silver (old test), but works like Gold/Platinum
# Date : (2014-07-12 23-16)
# Last revision : (2014-07-12 23-16)
# Wine version used : 1.7.22
# Distribution used to test : Linux Mint 17 "Qiana" x64
# Author : OdzioM
# Licence : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
  
TITLE="Resident Evil 3"
PREFIX="RE_3"
WORKING_WINE_VERSION="1.7.22"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Capcom" "http://www.capcom.com/" "OdzioM" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

# Choose installation mode:
POL_SetupWindow_menu_num "$(eval_gettext 'Select a version of installation disc:')" "$TITLE" "$(eval_gettext 'Retail CD')~$(eval_gettext 'Other destination or other CD/DVD')" "~"

if [ "$APP_ANSWER" == "0" ]; then
	# Version from retail CD
	POL_SetupWindow_message "$(eval_gettext 'Please insert the game media into your disc drive.')" "$TITLE"
	POL_SetupWindow_cdrom
	POL_SetupWindow_check_cdrom "setup.exe"
	SETUP_EXE="$CDROM/setup.exe"
elif [ "$APP_ANSWER" == "1" ]; then
	# Other file localization
	cd "$HOME"
        POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
	SETUP_EXE="$APP_ANSWER"
fi

POL_Wine "$SETUP_EXE"
POL_Wine_WaitExit "$TITLE"
POL_Shortcut "ResidentEvil3.exe" "$TITLE"

# Complete message
POL_SetupWindow_message "$(eval_gettext 'Installation complete!\nTo run $TITLE please select $TITLE icon from your desktop.\n\nThank you for using this installation script.')" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPBs4EACgkQ5TH6yaoTykc7cwCfVi+LH5xi0d0FPzwIwcSUcDjl
IIEAnj5qeoZvfWewtaBFOFhoG4Hk2Kdf
=PkSc
-----END PGP SIGNATURE-----
