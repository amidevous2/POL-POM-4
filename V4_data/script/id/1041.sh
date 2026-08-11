#!/bin/bash
# Date : (2012-01-15 00-06)
# Last revision : 
# Wine version used : 1.4.1, 1.5.5, 1.6.2, 3.0.3
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-01-15 00-06)
#   Initial script.
# [Pierre Etchemaite] (2014-06-15 20-18)
#   Script updated for GOG's installer v2 ?.
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested. It's the latest stable allowed by POL v4.2)


[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="septerra_core_legacy_of_the_creator"
PREFIX="SepterraCore_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Septerra Core: Legacy of the Creator"
SHORTCUT_NAME="Septerra Core"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1041
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Valkyrie Studios / Topware Interactive" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "d4b7e9501f16e47fe00df94a0dd82ea0"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "16"

# http://www.playonlinux.com/en/issue-1029.html
POL_Wine_Direct3D "DirectDrawRenderer" "gdi"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "septerra.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
# sometimes exits with an exitcode of 1 for what it seems no good reason
POL_Shortcut_QuietDebug "$SHORTCUT_NAME"

POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Septerra Core/Manual.pdf"
# C:\GOG Games\Septerra Core\README.TXT

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXqCU3gAKCRDlMfrJqhPK
R9pBAJ4pa41/P0+012qDb0s449PtNqd+KQCgspjqlDfixiR42qmfRtzrIJHUaPQ=
=4VOW
-----END PGP SIGNATURE-----
