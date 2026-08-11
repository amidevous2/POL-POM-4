#!/bin/bash
# Date : (2012-05-20 00-38)
# Last revision : (2014-05-29 17-22)
# Wine version used : 1.4-scummvm_support, 1.6.2-scummvm_support
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="teenagent"
PREFIX="Teenagent_gog"
WORKING_WINE_VERSION="1.6.2-scummvm_support"

TITLE="GOG.com - Teenagent"
SHORTCUT_NAME="Teenagent"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1214
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Metropolis Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e5e3a8cd9bbbcec5a956d1f41281b4af"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_SetupWindow_VMS "1"

cat <<_EOFCFG_ > "$WINEPREFIX/drive_c/GOG Games/Teenagent/teenagent.polcfg"
[teenagent]
platform=pc
gameid=teenagent
description=Teen Agent (DOS/English)
language=en
guioptions=sndNoSpeech lang_English
_EOFCFG_

POL_Shortcut "teenagent.polcfg" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlOHkL8ACgkQ5TH6yaoTykcddgCfaf55AjWpqmwk7YxgMYtP4HKZ
ZIcAn2Pw+tDzHradQc4EI4TjYuT28ULx
=S6cv
-----END PGP SIGNATURE-----
