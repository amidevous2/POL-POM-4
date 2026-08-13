#!/bin/bash

# CHANGELOG
# [SuperPlumus] (2013-06-27 11-32)
#   Clean code

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="PDU Spy"
WORKING_WINE_VERSION="1.4"
EDITOR="noobi.com"
EDITOR_URL="http://www.noobi.com"
PREFIX="PDUSpy"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "Tinou" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_LunaTheme

cd "$WINEPREFIX/drive_c"
POL_Download "http://www.nobbi.com/download/pduspy.zip" "36d8a5ab2e51bfbed5b4aa19b0087fe4"
unzip "pduspy.zip"

POL_Shortcut "PDUspy.exe"  "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlHMB7gACgkQ5TH6yaoTykfKLwCfUsF1AjO0pCpWPpOlj2VJi9a1
7LkAnRhTGjXr36KJ7rjISRg1RKfDUzYs
=jlPV
-----END PGP SIGNATURE-----
