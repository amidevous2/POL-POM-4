#!/bin/bash

# CHANGELOG
# [SuperPlumus] (2013-07-07 21-57)
#   Update POLv3 -> POLv4

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Flash MX"
PREFIX="FlashMX"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Adobe Macromedia" "http://www.macromedia.com/software/flash/" "dl.bonsai" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "Flash.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHZyVwACgkQ5TH6yaoTykdsUQCdGGq1kgdsr7g1uTOVPb25aAuS
UAIAoKykIt0i4BRXcEDAouB2Pnc36T9C
=nEk2
-----END PGP SIGNATURE-----
