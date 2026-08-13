#!/bin/bash
# Date : (2012-12-09 11-21)
# Last revision :
# Wine version used : 1.4.1, 1.5.15, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-12-09 11-21)
#   Initial script.
# [Pierre Etchemaite] (2014-02-16 10-44)
#   Script updated for GOG's installer v2 ?.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.6.2 (outdated) -> system
#   POL_Install_d3dx9_36 -> POL_Install_d3dx9_43

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="sam_max_save_the_world"
PREFIX="SamAndMaxS1_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Sam and Max Save the World"
SHORTCUT_NAME1="Sam and Max S1E1: Culture Shock"
SHORTCUT_NAME2="Sam and Max S1E2: Situation Comedy"
SHORTCUT_NAME3="Sam and Max S1E3: The Mole, The Mob, and the Meatball"
SHORTCUT_NAME4="Sam and Max S1E4: Abe Lincoln Must Die!"
SHORTCUT_NAME5="Sam and Max S1E5: Reality 2.0"
SHORTCUT_NAME6="Sam and Max S1E6: Bright Side of the Moon"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1509
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Telltale Games" "http://www.gog.com/en/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "9f58778be275c54e29bfe9d0e31c3191"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_d3dx9_43

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "SamMax101.exe" "$SHORTCUT_NAME1" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME1.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME1"
POL_Shortcut "SamMax102.exe" "$SHORTCUT_NAME2" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME2.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME2"
POL_Shortcut "SamMax103.exe" "$SHORTCUT_NAME3" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME3.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME3"
POL_Shortcut "SamMax104.exe" "$SHORTCUT_NAME4" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME4.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME4"
POL_Shortcut "SamMax105.exe" "$SHORTCUT_NAME5" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME5.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME5"
POL_Shortcut "SamMax106.exe" "$SHORTCUT_NAME6" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME6.png"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME6"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCc8wAKCRDlMfrJqhPK
R3ZjAJsFTBKIWLrRNKyA3DfvUrks1krnZwCfaJLcbHy6vdVLhNcYRnHW1TA5tPU=
=w5Iu
-----END PGP SIGNATURE-----
