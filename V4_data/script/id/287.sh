#!/bin/bash

# CHANGELOG
# [SuperPlumus] (2013-07-07 21-21)
#   Update POLv3 -> POLv4

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Dreamweaver 8"
PREFIX="Dreamweaver8"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Adobe Macromedia" "http://www.macromedia.com/software/dreamweaver/" "dl.bonsai" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

#Shortcut
POL_Shortcut "Dreamweaver.exe" "$TITLE"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHZw7gACgkQ5TH6yaoTykeotwCgkDpiGCivWoYI9vw1yjyOHTHr
8LgAnicO8zP1QcmK8mhby/yd1AwEvn3A
=BwvJ
-----END PGP SIGNATURE-----
