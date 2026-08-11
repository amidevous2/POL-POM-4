#!/bin/bash
# Date : (2009-12-31 ??-??)
# Last revision : (2013-11-07 15-38)
# Distribution used to test : Debian Sid
# Wine version used : 1.1.21
# Author : Berillions

# CHANGELOG
# [SuperPlumus] (2013-11-07 15-38)
#   Convert POLv3 -> POLv4 + Clean code
#   Update Wine version 1.1.43 -> 1.4.1

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Runaway 2 : The Dream of the Turtle"
PREFIX="Runaway2"
WORKING_WINE_VERSION="1.4.1"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Pendulo Studios" "http://www.runaway-lejeu.com/" "Berillions" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_SetupWindow_InstallMethod "CD,LOCAL"

if [ "$INSTALL_METHOD" = "CD" ]; then

POL_SetupWindow_cdrom
POL_SetupWindow_check_cdrom "Setup.exe"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$CDROM/Setup.exe"
POL_Wine_WaitExit "$TITLE"

elif [ "$INSTALL_METHOD" = "LOCAL" ]; then

cd "$HOME"
POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
POL_Wine_WaitBefore "$TITLE"
POL_Wine "$APP_ANSWER"
POL_Wine_WaitExit "$TITLE"

fi

Set_OS "winxp"

POL_Shortcut "Runaway2.exe" "$TITLE"

POL_SetupWindow_Close

exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlJ7qGoACgkQ5TH6yaoTykcSMwCgpHQphAOV/kJ97xaGTtFDUlKv
9CkAoIE9PIRqU/VDPeabKQ502rIfkIKS
=86jw
-----END PGP SIGNATURE-----
