#!/bin/bash
# Date : (2012-01-02 23-22)
# Last revision : see changelog
# Wine version used : 1.3.36, 1.4.1, 1.6.2 1.9.3
# Distribution used to test : Arch Linux
# Author : Pierre Etchemaite pe-pol@concept-micro.com, Buck Shockley darkwingbuck13@gmail.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2013-03-31)
#   Initial script, for the GOG release.
# [Buck Shockley] (2015-04-29 11-08)
#   Wine 1.6.2 -> 1.9.8
# [Dadu042] (2020-01-25 11:10)
#   Wine 1.9.8 (outdated) -> 2.22
#

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="fallout"
PREFIX="Fallout_gog"
WORKING_WINE_VERSION="2.22"
[ "$POL_OS" = "Mac" ] && WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Fallout"
SHORTCUT_NAME="Fallout"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1032
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Black Isle Studios / Interplay" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "0fc0cd177c2084fc4b09bb82ed481478"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install /nogui


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "2"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "falloutw.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
# sometimes exits with an exitcode of 1 for what it seems no good reason
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"

POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Fallout/MANUAL.PDF"
# C:\GOG Games\Fallout\ReadMe.txt

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiwn9AAKCRDlMfrJqhPK
R6YvAJ41XCda+jHj5Xmp05W9voh5DUDskwCgrJ5EcsInOUYb6YZNPbuK1PbjwxI=
=foqy
-----END PGP SIGNATURE-----
