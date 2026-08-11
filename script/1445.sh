#!/bin/bash
# Date : (2012-10-23 12-18)
# Last revision : 
# Wine version used : 1.4.1, 1.5.10
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-10-23 12-18)
#   Initial script.
# [Pierre Etchemaite] (2013-06-22 09-24)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 12:30).
#   Wine 1.4.1 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="thief_gold"
PREFIX="Thief_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Thief Gold"
SHORTCUT_NAME="Thief: The Dark Project + Gold"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1445
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Looking Glass Studios / Square Enix" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "bde1c2a2ffdda552c63c7ca6e3d87310"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install /nogui


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "THIEF_ND.EXE" "$SHORTCUT_NAME" "" "" "Game;ActionGame;" # "$SHORTCUT_NAME.png"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Thief GOLD/manual.pdf"
# C:\GOG Games\Thief GOLD\DROMED.EXE
# C:\GOG.Games\Thief GOLD\reference card.pdf

POL_SetupWindow_Close

exit 0

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpxKGwAKCRDlMfrJqhPK
R5uOAJ9w15vmCsnEFQst4fOMRxKKucGHOQCeNQ/y1olbxw+I8lRH0KKBjcCyMLE=
=MFUJ
-----END PGP SIGNATURE-----
