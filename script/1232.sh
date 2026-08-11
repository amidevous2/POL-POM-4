#!/bin/bash
# Date : (2012-05-27 21-44)
# Last revision : see changelog
# Wine version used : 1.5.15, 1.6.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-05-27 21-44)
#   Initial script.
# [Pierre Etchemaite] (2014-03-30 19-54)
#   Script updated for GOG's installer v2.
#   Sound mixing fixed in 1.5.7
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="syberia_2"
PREFIX="Syberia2_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Syberia 2"
SHORTCUT_NAME="Syberia 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1232
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Microids / Anuman Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 1 "f4f77d656501be595cc8d65be4973c80"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

POL_Call POL_Install_vcrun6

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Syberia2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Syberia 2/Manual.pdf"
# C:\GOG Games\Syberia 2\ReadMe.txt
# C:\GOG Games\Syberia 2\Walkthrough.pdf

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx7OgAKCRDlMfrJqhPK
R+HTAJ4sTmoZFoj/yRWiiDPEm/tY1VKKnwCeOHxZB1oN4SouE9JmIim38xHEJeo=
=P12m
-----END PGP SIGNATURE-----
