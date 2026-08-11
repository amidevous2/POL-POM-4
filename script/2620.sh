#!/bin/bash
# Date : (2015-09-16 15-04)
# Wine version used : 1.6.2
# Distribution used to test : OpenSUSE 13.2
# Author : Benjamin Hardy
#
# CHANGELOG
# [Benjamin Hardy] (2015-09-16 15-04)
#   Initial script.
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.6.2 (outdated) -> system

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - Technobabylon"
GOGID="technobabylon_deluxe_edition"
PREFIX="technobabylon"
SHORTCUT_NAME="Technobabylon"


POL_SetupWindow_Init 
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Technocrat Games and Wadjet Eye Games" "http://www.gog.com/gamecard/$GOGID" "Benjamin Hardy" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c14eba1d243fc42a3554a7e3917f1a63"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_Call POL_GoG_install

POL_Wine_reboot

POL_Shortcut "Technobabylon.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"
POL_Shortcut "winsetup.exe" "$SHORTCUT_NAME Configuration Tool" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx4ygAKCRDlMfrJqhPK
R6xOAKCCVK4B9C7rd56Apr0TnkH3abKMBQCeNzalovd0fYxDR9UPvaecEz++1dI=
=5Zda
-----END PGP SIGNATURE-----
