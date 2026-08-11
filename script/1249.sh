#!/bin/bash
# Date : (2012-06-09 14-38)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-09 14-38)
#   First script.
# [Dadu042] (2019-12-30)
#   Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="jagged_alliance_2"
PREFIX="JaggedAlliance2_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Jagged Alliance 2"
SHORTCUT_NAME="Jagged Alliance 2"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1249
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Sir-Tech Software / Strategy First" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "0504839fc0ca7831c6be2ed25feefc2c"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "1"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "ja2.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Jagged Alliance 2/manual.pdf"
# C:\GOG Games\Jagged Alliance 2\readme.txt

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXgsiQQAKCRDlMfrJqhPK
R5hRAJ48NBFJ6PnK/mRU5scVUWU6MS9McgCfRH2sEHlX8N0cb6CZw/lqouQ8cBI=
=sBax
-----END PGP SIGNATURE-----
