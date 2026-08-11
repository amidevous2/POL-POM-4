#!/bin/bash
# Date : (2012-06-24 16-52)
# Last revision : see changelog
# Wine version used : see below
# Distribution used to test : Debian Sid (Unstable)
# Author : Pierre Etchemaite pe-pol@concept-micro.com
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [Pierre Etchemaite] (2012-06-24 16-52)
#   Initial script.
# [Pierre Etchemaite] (2013-11-20 21-37)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.5.5 (outdated) -> 3.0.3 (not tested)
#   POL_Install_d3dx9_36 -> 43

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="star_wolves"
PREFIX="StarWolves_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - Star Wolves"
SHORTCUT_NAME="Star Wolves"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/top.jpg" "http://files.playonlinux.com/resources/setups/$PREFIX/left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1278
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "X-bow Software / 1C Publishing" "http://www.gog.com/gamecard/$GOGID" "Pierre Etchemaite" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "2363cf6ef0591fdba43b3a3fb8ec324f"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "32"

# 2013: Only d3dx9_36 matters since Wine 1.5.5
POL_Call POL_Install_d3dx9_43

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "StarWolves.exe" "$SHORTCUT_NAME" "$SHORTCUT_NAME.png" "" "Game;StrategyGame;"
POL_Shortcut_Document "$SHORTCUT_NAME" "$GOGROOT/Star Wolves/manual.pdf"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpyATAAKCRDlMfrJqhPK
R+qZAKCZ9XFVvx26vEvQj6cbu0n5zL8yiwCePOHSVi0ZS9Df36VTNVtDhwfd7CQ=
=Nhsc
-----END PGP SIGNATURE-----
