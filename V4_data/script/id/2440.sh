#!/bin/bash
# Date : (2015-02-22 16-40)
# Wine version used : see below
# Distribution used to test : OpenSuse 13.2
# Author : Benjamin Hardy
#
# CHANGELOG
# [Benjamin Hardy] (2015-02-22 16-40)
#   Initial script.
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested)

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - The Black Mirror II"
PREFIX="TheBlackMirrorII"
WINEVERSION="3.0.3"
SHORTCUT_NAME="The Black Mirror II"
GOGID="black_mirror_ii"

POL_SetupWindow_Init
POL_SetupWindow_SetID 
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Cranberry Production" "Retailer: www.gog.com" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "89e2a1d007e7722ea223cd16233d67d2"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#/nogui to avoid installer crashing
POL_Call POL_GoG_install /nogui

Set_OS win7

POL_Wine_reboot

POL_Shortcut "BlackMirror2.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx3LwAKCRDlMfrJqhPK
R0zQAKCn8sgNyKmwt2B6nToX93yCIk+4ugCgqu7l1CW4LW19o/Xl7bOLNTU8BRg=
=fF6g
-----END PGP SIGNATURE-----
