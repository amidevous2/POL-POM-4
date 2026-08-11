#!/bin/bash
# Date: (2016-01-31 13-50)
# Last revision: (2016-01-31 13-50)
# Wine version: 1.9.2
# Tested on: Ubuntu 15.10 (amd64)
# Author: Jeddunk
# Original author: Pierre Etchemaite pe-pol@concept-micro.com
# Script licence: GPL v2
# Program licence: Retail
#
# CHANGELOG
# [Jeddunk] (2016-01-31 13-50)
#   First script.
# [Dadu042] (2019-12-19 20:50)
#   Wine 1.9.2 -> 3.0.3
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="darkest_dungeon"
PREFIX="DarkestDungeon"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Darkest Dungeon"
SHORTCUT_NAME="Darkest Dungeon"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_Debug_Init
 
POL_SetupWindow_presentation "$TITLE" "Red Hook Studios" "http://www.gog.com/gamecard/$GOGID" "Jeddunk" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "3ca9742a71e400f38dd88a5f66c77f57"

POL_System_SetArch "x86"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"
 
POL_Call POL_Install_vcrun2013
 
POL_Call POL_GoG_install /nogui

Set_OS winxp
 
POL_Shortcut "Darkest.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;"
 
POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg5l2QAKCRDlMfrJqhPK
R73fAKCHc0VtjqNjyhYZJFvyLvDQtZIQXACfS1rXVU/xYxywHZA6T4Ohfio37sk=
=Cp9z
-----END PGP SIGNATURE-----
