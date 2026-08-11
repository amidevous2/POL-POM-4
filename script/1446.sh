#!/bin/bash

#
# CHANGELOG
# [Quentin P] (2011 ?)
#   Initial script.
# [Dadu042] (2020-02-23 23:41)
#   Remove useless info (WINEVERSION).

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Deep Finesse"
EDITOR="Deep Finesse"
EDITOR_URL="http://www.deepfinesse.com"
PREFIX="DeepFinesse"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_LunaTheme
cd "$WINEPREFIX/drive_c"
POL_Download "http://www.deepfinesse.com/releases/Deep%20Finesse%202012%20v3.zip" "cf6491ceebec1ad65e8534e597454736"

POL_Wine_WaitBefore "$TITLE"
unzip "Deep%20Finesse%202012%20v3.zip"

POL_Shortcut "Deep Finesse.exe"  "$TITLE" "" "" "Game;"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRFtWEU2eoWQNaBNczlMfrJqhPKRwUCXlI8PQAKCRDlMfrJqhPK
R1mMAKCZkPafkzgwoWE7fcM2MHmGPXGvYgCgiBReWIlvEq3xIN+vZ8hnH3bFv20=
=HE9J
-----END PGP SIGNATURE-----
