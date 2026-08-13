#!/bin/bash
# Date : (2012-11-25 17:56)
# Last revision : see changelog
# Wine version used : 1.4.1, 1.5.5, 1.6.2
# Distribution used to test : OpenSuSE 12.2 64-bit
# Author : hmdai (Based on Deponia DC script by Kweepeer)
# Script licence : GPL v.2
# Program licence : Retail
# Depend :
#
# CHANGELOG
# [hmdai (Based on Deponia DC script by Kweepeer)] (2012-11-25 17:56)
#   Initial script.
# [Pierre Etchemaite] (2014-03-02 20-57)
#   Script updated for GOG's installer v2.
# [Dadu042] (2020-04-19 17:30).
#   Wine 1.6.2 (outdated) -> 3.0.3 (not tested)

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="the_book_of_unwritten_tales"
PREFIX="TheBookofUnwrittenTales_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - The Book of Unwritten Tales"
SHORTCUT_NAME="The Book of Unwritten Tales"

POL_GetSetupImages "http://files.playonlinux.com/resources/setups/$PREFIX/bout_64x64.png" "http://files.playonlinux.com/resources/setups/$PREFIX/bout_left.jpg" "$TITLE"

POL_SetupWindow_Init
POL_SetupWindow_SetID 1488
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "King Art/Nordic Games" "http://www.gog.com/gamecard/$GOGID" "hmdai" "$PREFIX"
POL_Call POL_GoG_setup "$GOGID" --alternate "setup_$GOGID" 4 "984e8f16cc04a2a27aea8b0d7ada1c1e" "4ea0eccb7ca2f77c301e79412ff1e214" "95e52d38b6c1548ac311284c539a4c52" "7290d78ecbec866e46401e4c9d3549cf"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install /nogui


# GoG work!
Set_OS winxp

POL_SetupWindow_VMS "128"

# Doesn't hurt ;)
POL_Wine_reboot

POL_Shortcut "bout.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXpx1uwAKCRDlMfrJqhPK
R7beAKCZ4GyCJPNn6JDCjJcgJhxBLf532ACePHKLrFlaJUshSJ2CZQlAFRkQS6s=
=i+MU
-----END PGP SIGNATURE-----
