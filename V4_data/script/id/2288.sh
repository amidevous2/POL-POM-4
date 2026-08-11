#!/bin/bash
# Date : (2014-10-4 18-14)
# Wine version used : 1.6.2
# Distribution used to test : OpenSuse 13.1
# Author : Benjamin Hardy

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - The Black Mirror"
PREFIX="TheBlackMirror"
WORKING_WINE_VERSION="1.6.2"
SHORTCUT_NAME="The Black Mirror"
GOGID="the_black_mirror"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2288
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Future Games" "Retailer: www.gog.com" "Benjamin Hardy" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "b8ec8e8c7046eca47762ab52ec37457d"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

Set_OS win7

POL_Wine_reboot

POL_Shortcut "BMirror.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlQwPu4ACgkQ5TH6yaoTykf8TwCgmClFzyychWFkZAoWUNVcA7U/
RzcAoILKmH3G4oxf4oGAQeeSX5mNxUSL
=krTD
-----END PGP SIGNATURE-----
