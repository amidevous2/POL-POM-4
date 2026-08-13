#!/bin/bash
# Date : (2012-01-29 17-31)
# Last revision : (2014-02-02 21-00)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
#    author of original script Ulukyn
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="broken_sword_directors_cut"
PREFIX="BrokenSword1DC_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Broken Sword 1: Shadow of The Templars"
SHORTCUT_NAME="Broken Sword 1: Shadow of the Templars"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 970
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Revolution Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "419b755a099d70228e60bfcaa68e63c4"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "bs1dc.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Broken Sword - Director's Cut/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlLup2gACgkQ5TH6yaoTykeANgCgg7bROASeqVGaTZs7Z8aih+Xo
9ZoAoJo/ofYo2eWFlsDFPkmn3rXt/lMq
=H4NA
-----END PGP SIGNATURE-----
