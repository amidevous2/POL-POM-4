#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Codacod"
WINEVERSION="1.4"
EDITOR="Codacod"
EDITOR_URL="http://www.cfdt-crte-idf.org/02_jurid_code.htm"
PREFIX="Codacod"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"
POL_Call POL_Install_LunaTheme
cd "$WINEPREFIX/drive_c"
POL_Download "http://www.cfdt-crte-idf.org/tele/Installation_CODACOD_V2_05I-2.zip" "813a04caee2c6607c258c8c752dcf4a4"
unzip "Installation_CODACOD_V2_05I-2.zip" 
POL_Wine_WaitBefore "$TITLE"
POL_Wine --ignore-errors "Installation CODACOD V2_05I.exe"
POL_Shortcut "CODACOD V2_05I.exe"  "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlASzaUACgkQ5TH6yaoTykfTMACcDtfMupJpkn9XVy0aGAu4l60t
EUAAn0UTGANWtj17IZuiSvdfV1kuHNct
=IOte
-----END PGP SIGNATURE-----
