#!/bin/bash
# Date : (2012-04-30 09-59)
# Last revision : (2014-03-09 17-40)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="dark_fall_the_journal"
PREFIX="DarkfallTheJournal_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Dark Fall: The Journal"
SHORTCUT_NAME="Dark Fall: The Journal"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1154
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "XXv Productions / Nordic Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "ba0c22c2dc926bec2aa52eb5a4b0c15b"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

# "SVGA 640x480 32bit color"?
POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "darkfall.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;AdventureGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Dark Fall - The Journal/manual.pdf"
# C:\GOG Games\Dark Fall - The Journal/ReadMe.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlMcoukACgkQ5TH6yaoTykfZKwCgovV5Fvda2TnIgTX5gz6K/HnO
mm8AoKiwehHu1bf/LYTnEH2ZiVO2pR+0
=VGg3
-----END PGP SIGNATURE-----
