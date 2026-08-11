#!/bin/bash
# Date : (2012-06-10 11-37)
# Last revision : (2014-03-05 23-05)
# Wine version used : 1.4, 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="in_cold_blood"
PREFIX="InColdBlood_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - In Cold Blood"
SHORTCUT_NAME="In Cold Blood"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1251
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Revolution Software" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "2b2dd622b243c5772c1571defee68698"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "engine.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/In Cold Blood/manual.pdf"
# C:\GOG Games\In Cold Blood\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMXqvQACgkQ5TH6yaoTykcqGgCfR3uJwV3p1PxSD9tCV3PtWlHm
wTIAn1OiSk8eagJBUo2tLNksZMM6lh+X
=fzrT
-----END PGP SIGNATURE-----
