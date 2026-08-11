#!/bin/bash
# Date : (2012-08-31 20-03)
# Last revision : (2013-12-15 20-52)
# Wine version used : 1.4.1, 1.5.11
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="freedom_force_vs_the_3rd_reich"
PREFIX="FFvt3R_gog"
WORKING_WINE_VERSION="1.4.1"

TITLE="GOG.com - Freedom Force vs. the 3rd Reich"
SHORTCUT_NAME="Freedom Force vs. the 3rd Reich"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1384
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Irrational Games / Focus Home Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "b74a8aec52804de44e141a4e942c1dbe"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "ffvt3r.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Freedom Force vs the 3rd Reich/Manual.pdf"
# C:\GOG Games\Freedom Force vs the 3rd Reich\Readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlKuEEAACgkQ5TH6yaoTykfUOACeLC2Jyc2/feo0Zaj02Kmhz0GA
vlAAmweww+M4dDeStKO7KztJJ3BuqbW/
=pgCu
-----END PGP SIGNATURE-----
