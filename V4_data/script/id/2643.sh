#!/bin/bash
# Wine version used : 1.7.52

# CHANGELOG
# [Cork] (2015-10-24)
#   First script.
# [Dadu042] (2020-01-02)
#   Wine 1.7.52 -> 3.0.3

[ -z "$PLAYONLINUX" ] && exit 0
source "$PLAYONLINUX/lib/sources"

GOGID="gex"
PREFIX="gex_gog"
WORKING_WINE_VERSION="3.0.3"

TITLE="GOG.com - GEX"
SHORTCUT_NAME="GEX"

POL_SetupWindow_Init

POL_SetupWindow_presentation "${TITLE}" "Crystal Dynamics / Square Enix" "https://www.gog.com/game/${GOGID}" "Cork" "${PREFIX}"

POL_Call POL_GoG_setup "${GOGID}" "7d4c95a0b711a5671da905aade947627"

POL_Wine_SelectPrefix "${PREFIX}"
POL_Wine_PrefixCreate

POL_Call POL_GoG_install

Set_OS winxp
POL_SetupWindow_VMS "2"

POL_Shortcut "Loader.exe" "${SHORTCUT_NAME}" "" "" "Game;Platform;"

POL_SetupWindow_Close

exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXg5syQAKCRDlMfrJqhPK
Rz+vAJ4nSbBox/XM/54Pm7hZxFa7BvNSwQCbBjUuohmSGfvnpQEPmCszrfAnX7M=
=1ykU
-----END PGP SIGNATURE-----
