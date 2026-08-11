#!/bin/bash
# Date : (2012-05-14 21-36)
# Last revision : (2014-07-20 23-30)
# Wine version used : 1.4.1, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="legend_of_grimrock"
PREFIX="LegendOfGrimrock_gog"
WORKING_WINE_VERSION="1.6.2"

TITLE="GOG.com - Legend of Grimrock"
SHORTCUT_NAME="Legend of Grimrock"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1193
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Almost Human" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "41cafc6356606b1c62f8305d7110aaa4"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


POL_Call POL_Install_d3dx9
POL_Call POL_Install_xact
POL_Wine_OverrideDLL builtin d3dx9_43

# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "256"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "grimrock.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Legend of Grimrock/legend_of_grimrock_manual.pdf"
# C:\GOG Games\Legend of Grimrock/legend_of_grimrock_map.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlPMQ14ACgkQ5TH6yaoTykfvXQCfae7aQO08ze44V83vYrKfcduX
SAEAmgOfAGwad0HKVWCGq46iSdUWAYHV
=Ub+o
-----END PGP SIGNATURE-----
