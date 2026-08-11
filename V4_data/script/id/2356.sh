#!/bin/bash
# Date : (2015-03-12 19-06)
# Wine version used : 1.7.28
# Distribution used to test : OpenSUSE 13.2
# Author : Benjamin Hardy
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - Memoria"
GOGID="memoria"
PREFIX="Memoria"
#using 1.7.28 solved problems with missing backgrounds later in the game
WINEVERSION="1.7.28"
SHORTCUT_NAME="Memoria"


POL_SetupWindow_Init 
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Daedalic Entertainment" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX"

POL_SetupWindow_message "$(eval_gettext 'This installer requires the patch provided by gog.com. Please ensure it has been downloaded to a local drive before continuing.')" "$TITLE"

POL_Call POL_GoG_setup "$GOGID" "847c7b5e27a287d6e0e17e63bfb14fff"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

#nogui to avoid installer crash
POL_Call POL_GoG_install /nogui

POL_SetupWindow_browse "$(eval_gettext 'Please select the patch file.')" "$TITLE"
POL_Wine_WaitBefore "$(eval_gettext 'Please wait, patch installation in progress.')" "$TITLE"
POL_Wine "$APP_ANSWER"

POL_Wine_reboot

POL_Shortcut "memoria.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlU4sSQACgkQ5TH6yaoTykfB2wCeLkpdqxSGvZSno3Hmhpsx3Bz5
0FsAn3oWdAviG0W46Rg0XXfbgIwDOpBt
=8haG
-----END PGP SIGNATURE-----
