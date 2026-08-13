#!/bin/bash
# Date : (2012-05-22 22-47)
# Last revision : (2014-06-15 00-13)
# Wine version used : 1.4-scummvm_support, 1.6.2-scummvm_support
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="simon_the_sorcerer_2"
PREFIX="SimonTheSorcerer2_gog"
WORKING_WINE_VERSION="1.6.2-scummvm_support"

TITLE="GOG.com - Simon the Sorcerer 2"
SHORTCUT_NAME="Simon the Sorcerer 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1225
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Adventure Soft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "bb5948a86a9325d07ad7052026b09546"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_SetupWindow_VMS "2"

cat <<_EOFCFG_ > "$GOGROOT/Simon the Sorcerer 2/simon2.polcfg"
[simon2]
description=Simon the Sorcerer 2
mute=false
subtitles=false
gameid=simon2
language=en
guioptions=launchNoLoad
_EOFCFG_

POL_Shortcut "simon2.polcfg" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Simon the Sorcerer 2/manual.pdf"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOczZEACgkQ5TH6yaoTykeAHACfezae+5aNyQbB2P6JiFT6Cd73
61QAn1rjfgMeqm/bHXIYBk6xWQJ/cI4n
=alAt
-----END PGP SIGNATURE-----
