#!/bin/bash
# Date : (2015-01-09 20-06)
# Wine version used : 1.6.2
# Distribution used to test : OpenSuse 13.2
# Author : Benjamin Hardy

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - Broken Sword 5 - the Serpent's Curse"
PREFIX="BrokenSword5"
WORKING_WINE_VERSION="1.6.2"
SHORTCUT_NAME="Broken Sword 5 - the Serpent's Curse"
GOGID="broken_sword_5_the_serpents_curse"

POL_SetupWindow_Init
POL_SetupWindow_SetID 2392
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Revolution Software" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_Call POL_GoG_setup "$GOGID" "917a5ec66486e87b1a8c84cfc74e2475"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

Set_OS win7

POL_Wine_reboot

POL_Shortcut "BS5.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlSwRBYACgkQ5TH6yaoTykevxACfWoSKldkG8/noPfFMJiX1ZPE6
yG4AoKQSNL3k0wMFxujiZkoFjzQbB/ur
=abgi
-----END PGP SIGNATURE-----
