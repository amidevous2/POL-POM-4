#!/usr/bin/env playonlinux-bash
#
# CHANGELOG
# [robka] (2015-11-18)
#   Initial script.
# [Dadu042] (2020-03-20 19:30).
#   Wine 1.6.2 -> 3.0.3

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="men_of_war_assault_squad_goty_edition"
WORKING_WINE_VERSION="3.0.3"
TITLE="GOG.com - Men of War: Assault Squad"
PREFIX="MoW_AS"
SHORTCUT_NAME="Men of War: Assault Squad"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "Digitalmindsoft" "http://www.gog.com/game/$GOGID" "Robin Karlsson" "Men of War - Assault Squad"

POL_Call POL_GoG_setup "$GOGID" "4d94cc1d1ead4f7af60216a1b8be8dca"
POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_GoG_install "/nogui"
Set_OS winxp
POL_Call POL_Install_d3dx9_36

POL_Shortcut "mow_assault_squad.exe" "$SHORTCUT_NAME" "" "" "Game;"
POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXnYcJAAKCRDlMfrJqhPK
R/BSAJwLQ7/ucCclfRcP9PmL3zsdo14CnwCfcMkSgVoTwx8asQ/i+t+388Yz9R4=
=nT+k
-----END PGP SIGNATURE-----
