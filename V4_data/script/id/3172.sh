#!/usr/bin/env playonlinux-bash

#
# CHANGELOG
# [pplcanfly] (2017-05-010)
#   Initial script.
# [Dadu042] (2020-04-09 19:30)
#   Wine 2.7 (outdated) -> 3.0.3 (not tested).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"
 
[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="GOG.com - Stasis"
GOGID="stasis"
PREFIX="stasis"
WINEVERSION="3.0.3"
SHORTCUT_NAME="Stasis"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindowipresentation "$TITLE" "The Brotherhood" "http://www.gog.com/gamecard/$GOGID" "Tomasz Lipinski" "$PREFIX"

POL_Call POL_GoG_setup "$GOGID" "5aecc8b82dee5e1538efd8c981d05dac" "c06fe50ac6cc692e9b82a7175ad2da30"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_GoG_install

POL_Wine_reboot

POL_Shortcut "Stasis.exe" "$SHORTCUT_NAME" "" "" "Game;AdventureGame;"
POL_Shortcut "stasis_config_tool.exe" "$SHORTCUT_NAME Configuration Tool" "" "" "Game;AdventureGame;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXo96+QAKCRDlMfrJqhPK
R6uWAKCQBCpGkUOBh78ACEmKXpeXtmkPQACffnwmUI9DzU4UHPDBTApiKUeIyDI=
=36Wg
-----END PGP SIGNATURE-----
