#!/bin/bash
# Date : (2020-05-01)
# Wine version used : 5.0
# Distribution used to test : OpenSUSE 15.1
# Author : Benjamin Hardy

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
TITLE="GOG.com - SECRET FILES: TUNGUSKA"
PREFIX="SECRET_FILES_TUNGUSKA"
WINEVERSION="5.0"
SHORTCUT_NAME="SECRET FILES: TUNGUSKA"
GOGID="secret_files_tunguska"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Animation Arts / Deep Silver" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX" 

POL_RequiredVersion "4.3.0" || POL_Debug_Fatal "$APPLICATION_TITLE $VERSION is required to install $TITLE"

POL_Call POL_GoG_setup "$GOGID" "ea2218916d270f1db0565691f0c42b0b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_GoG_install

Set_OS win7

POL_Wine_reboot

POL_Shortcut "Tunguska.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_message "$(eval_gettext 'Please note: Some test computers displayed a blank screen on launching the game. Enabling an 800x600 virtual desktop in WINE settings resolved this.')" "$TITLE"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqx77gAKCRDlMfrJqhPK
R5CPAJ9iADJMoUeJt/lfr4WUhbaMuZd+pwCfd/DJc9iWvG01KDrzs0aPqDAbsAQ=
=wn2O
-----END PGP SIGNATURE-----
