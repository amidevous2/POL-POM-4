#!/bin/bash
# Date : (2015-05-08 18-54)
# Wine version used : 1.6.2
# Distribution used to test : OpenSUSE 13.2
# Author : Benjamin Hardy
#
# CHANGELOG
# [Benjamin Hardy] (2015-05-08 18-54)
#   Initial script, for the GOG release.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.6.2 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - Black Mirror 3"
PREFIX="BlackMirror3"
WINEVERSION="3.0.3"
SHORTCUT_NAME="Black Mirror 3"
GOGID="black_mirror_3"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Cranberry Production" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "9bbedd192bbaf4a69056e9b74a5e43cd"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_SetupWindow_message "$(eval_gettext 'When the GOG installer asks you to install Microsoft Visual C++ Redistributable, please select Cancel.')" "$TITLE"

POL_Call POL_GoG_install

POL_SetupWindow_VMS "128"

POL_Wine_reboot

POL_Shortcut "BlackMirrorIII.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Black Mirror 3/Docs/Manual.pdf"

POL_SetupWindow_Close
 
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwhTQAKCRDlMfrJqhPK
R7PpAJ9KNQIzq3eOztq8clzRjyhsONsSSQCeM/NeqJzFUUkDVPqo3dqv/oBwbN4=
=dO0E
-----END PGP SIGNATURE-----
