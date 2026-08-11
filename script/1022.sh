#!/bin/bash
# Date : (2011-12-17 15-39)
# Last revision : see changelog
# Wine version used : x
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2011-12-17 15-39)
#   Initial script. Wine 1.3.36
#   Works with Wine 1.1.34, but much slower!
# [Pierre Etchemaite] (2013-05-19 20-05)
#   Wine 1.3.36 -> 1.4.1 ?
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.4.1 -> 2.22

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="nox"
PREFIX="Nox_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Nox"
SHORTCUT_NAME="Nox"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top2.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left2.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1022
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Westwood Studios / Electronic Arts" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "c1cc844fb0f17bd8e7406354eef1616e"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "4"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "NOX.EXE" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;RolePlaying;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$WINEPREFIX/drive_c/GOG Games/Nox/manual.pdf"
# C:/GOG Games/Nox/Readme.txt

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYeNgAKCRDlMfrJqhPK
R2QlAKCH7MPWGHKOYKj6ISFae25CrieQiwCdHhnr9CFzo16bFg6oLzIWukxncM0=
=drHG
-----END PGP SIGNATURE-----
