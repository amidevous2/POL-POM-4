#!/bin/bash
# Auto-generated script : /home/lui/.PlayOnLinux//scripts/Surfer8_17
# Les trucs entre { } doivent etre remplaces par POL Online

# CHANGELOG
# [SuperPlumus] (2013-06-09 16-01)
#   Partial clean + gettext
# [Dadu042] (2019-06-30)
#   Fix Wineprefix (for POL website).


[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Surfer 8"
PREFIX="Surfer8"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Golden Software" "" "luiscuadrado123" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_SetupWindow_browse "$(eval_gettext 'Please select the setup file to run')" "$TITLE"
SETUP_PATH="$APP_ANSWER"

POL_Wine_WaitBefore "$TITLE"
POL_Wine "$SETUP_PATH"
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "surfer.exe" "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXRhO8gAKCRDlMfrJqhPK
R6eGAJ9i/YJ4FSENb4TWhE3txoW37fZTrQCePMtdfXhntZHrmkTHFBYJpzLjzr4=
=l+kM
-----END PGP SIGNATURE-----
