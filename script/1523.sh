#!/bin/bash
# Date : (2012-12-29 22-49)
# Last revision : 
# Wine version used : 1.4.1, 1.5.15, 1.6.2
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-12-29 22-49)
#   Initial script.
# [Pierre Etchemaite] (2014-06-28 16-52)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.6.2 (outdated) -> system
#   POL_Install_d3dx9_36 -> 43

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="sam_max_beyond_time_and_space"
PREFIX="SamAndMaxS2_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - Sam and Max: Beyond Time and Space"
SHORTCUT_NAME1="Sam and Max S2E1: Ice Station Santa"
SHORTCUT_NAME2="Sam and Max S2E2: Moai Better Blues"
SHORTCUT_NAME3="Sam and Max S2E3: Night of the Raving Dead"
SHORTCUT_NAME4="Sam and Max S2E4: Chariots of the Dogs"
SHORTCUT_NAME5="Sam and Max S2E5: What's New, Beelzebub"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1523
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Telltale Games" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e8bb5a888b83c6467a7b8b7390c21e43"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_d3dx9_43

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "SamMax201.exe" "$SHORTCUT_NAME1" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME1.png"
#POL_Shortcut_QuietDebug "$SHORTCUT_NAME1"
POL_Shortcut "SamMax202.exe" "$SHORTCUT_NAME2" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME2.png"
#POL_Shortcut_QuietDebug "$SHORTCUT_NAME2"
POL_Shortcut "SamMax203.exe" "$SHORTCUT_NAME3" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME3.png"
#POL_Shortcut_QuietDebug "$SHORTCUT_NAME3"
POL_Shortcut "SamMax204.exe" "$SHORTCUT_NAME4" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME4.png"
#POL_Shortcut_QuietDebug "$SHORTCUT_NAME4"
POL_Shortcut "SamMax205.exe" "$SHORTCUT_NAME5" "" "" "Game;AdventureGame;" # "$SHORTCUT_NAME5.png"
#POL_Shortcut_QuietDebug "$SHORTCUT_NAME5"

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCdwgAKCRDlMfrJqhPK
R5FbAKCloJeHspgm3QBllPtFzu5k652YmwCgqTAFk97C4RnmfWAHAd4mkRRDMQw=
=aFKV
-----END PGP SIGNATURE-----
