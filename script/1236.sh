#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Microsoft Paint"
WINEVERSION="3.0.4"
EDITOR="Microsoft"
EDITOR_URL="http://www.microsoft.com"
PREFIX="mspaint"

POL_SetupWindow_Init
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

mkdir -p "$WINEPREFIX/drive_c/Paint"
cd "$WINEPREFIX/drive_c/Paint"
POL_Download "https://web.archive.org/web/20130218065827if_/http://download.microsoft.com/download/winntwks40/paint/1/nt4/en-us/paintnt.exe" "422b9c727bb3ce790e08a2f155cfcb84"

POL_Wine_WaitBefore "$TITLE"
unzip "paintnt.exe" || POL_Debug_Error "Unable to extract paintnt.exe"
POL_Call POL_Install_LunaTheme

POL_Shortcut "mspaint.exe"  "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlwZW8gACgkQ5TH6yaoTykfzhACdEkobq/x/QqRQ8mk0Vh1xSF7l
Oa0An0LpQ8n3K2GwpvrYQro+dsdDJR4T
=MrZU
-----END PGP SIGNATURE-----
