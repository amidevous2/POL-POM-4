#!/bin/bash
# Date : (2012-03-20 20-55)
# Last revision : (2014-02-16 16-55)
# Wine version used : 1.4-scummvm_support
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="simon_the_sorcerer"
PREFIX="SimonTheSorcerer_gog"
WORKING_WINE_VERSION="1.4-scummvm_support"

TITLE="GOG.com - Simon the Sorcerer"
SHORTCUT_NAME="Simon the Sorcerer"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1105
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Adventure Soft" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "cf6a001535597291a86409446be133bd"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_SetupWindow_VMS "2" # 640x480x256

cat <<_EOFCFG_ > "$GOGROOT/Simon the Sorcerer/simon1.polcfg"
[simon1]
description=Simon the Sorcerer 1 (CD/Windows/English)
platform=windows
gameid=simon1
language=en
_EOFCFG_

POL_Shortcut "simon1.polcfg" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Simon the Sorcerer/manual.pdf"
# C:\GOG Games\Simon the Sorcerer\walkthrough.doc

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMA4WQACgkQ5TH6yaoTykespwCgsT0LB3Oby+Yq4cvJPkMphnpH
S0AAoI2rc4KGy0OecfOpQ+zENQ1fSSL1
=4M4b
-----END PGP SIGNATURE-----
