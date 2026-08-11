#!/bin/bash
# Date : (2012-08-08 01-18)
# Last revision : see changelog
# Wine version used : 3.0.3
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-08-08 01-18)
#   Initial script, for the GOG release.
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.4.1 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="sacrifice"
PREFIX="Sacrifice_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Sacrifice"
SHORTCUT_NAME="Sacrifice"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1353
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Shiny Entertainment / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "e8a1ac074282830fce07b2d3b8f7010f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "Sacrifice.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Sacrifice/MANUAL.PDF"
# C:\GOG Games\Sacrifice\ReadMe.txt
# C:\GOG Games\Sacrifice\RefCard.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiw0SwAKCRDlMfrJqhPK
Ry/4AKCcwEgt+AW+CcK6xPVd1DHUCLGB8ACgia6oG0ZRAOQOvq8t2AsYZFTG2sc=
=kCBU
-----END PGP SIGNATURE-----
