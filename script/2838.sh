#!/bin/bash
# Date : (2016-07-13)
# Last revision : see changelog
# Wine version used : 2.22
# Distribution used to test : Fedora 23
# Author : Jylhis
# Script licence : MIT
# Program licence : Retail
#
# CHANGELOG
# [Jylhis] (2016-06-13)
#   Initial script.
# [Dadu042] (2020-01-19 22:00)
#  Wine 1.9.12 -> 2.22
#
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="spelunky"
PREFIX="spelunky_gog"
WORKING_WINE_VERSION="2.22"

TITLE="GOG.com - Spelunky"
SHORTCUT_NAME="Spelunky"

POL_SetupWindow_Init

POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "POL_SetupWindow_Init" "" "Jylhis" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "bff7c275053137881c9f2f6df16ee4b3"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install

POL_Wine_reboot

POL_Shortcut "Spelunky.exe" "$TITLE" "" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXiYWsQAKCRDlMfrJqhPK
R70CAJ99AtqtZO0zTifwY6iPBtxmAm10SACgqoNwzwalpPXLuen/1Tf8bggEoJY=
=J1rl
-----END PGP SIGNATURE-----
