#!/bin/bash
# Date : (2012-11-23 21-22)
# Last revision : 
# Wine version used : 1.4.1, 1.6.2, 1.9.3
# Distribution used to test : Arch Linux
# Author : Pierre Etchemaite pe-pol@concept-micro.com, Buck Shockley darkwingbuck13@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-11-23 21-22)
#   Initial script.
# [Pierre Etchemaite] (2016-02-18 13-09)
#   Script updated for GOG's installer v2 ?.
# [Dadu042] (2020-04-22 21:00).
#   Wine 1.9.3 (outdated) -> system.
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="rollercoaster_tycoon_2"
PREFIX="RollerCoasterTycoon2_gog"
WORKING_WINE_VERSION=""

TITLE="GOG.com - RollerCoaster Tycoon 2"
SHORTCUT_NAME="RollerCoaster Tycoon 2: Triple Thrill Pack"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1481
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Chris Sawyer Productions / Atari" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "40c7dee00c3451ac0d484df0e384f22e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "64"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "RCT2.EXE" "$SHORTCUT_NAME" "" "" "Game;Simulation;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/RollerCoaster Tycoon 2 Triple Thrill Pack/manual.pdf"
# C:\GOG Games\RollerCoaster Tycoon 2 Triple Thrill Pack\readme.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCjVAAKCRDlMfrJqhPK
R+AoAKCRqwWQnrIm70OxUD8FVhwBax2C/wCfbpiyyfapFzZbyMn40R5bpdBLE6E=
=txh0
-----END PGP SIGNATURE-----
