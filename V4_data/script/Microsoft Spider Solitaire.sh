#!/bin/bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Microsoft Spider Solitaire"
WINEVERSION="1.7.25"
EDITOR="Microsoft"
EDITOR_URL="http://www.microsoft.com"
PREFIX="MicrosoftSpider"

POL_SetupWindow_Init
POL_Debug_Init


POL_SetupWindow_presentation "$TITLE" "$EDITOR" "$EDITOR_URL" "" "$PREFIX"

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WINEVERSION"

POL_Call POL_Install_LunaTheme

cd "$WINEPREFIX/drive_c/" || POL_Debug_Fatal "Unable to change directory"
POL_Call POL_SP2_Extract spider.exe

POL_Shortcut "spider.exe"  "$TITLE"

POL_SetupWindow_Close
exit 0
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEABECAAYFAlP7zlMACgkQ5TH6yaoTykfs3gCfcKlFAod37YTY0zh4fe3b9FM7
ys8An30H5D4zudIUcHwpnDcmTg3LAkHh
=1doW
-----END PGP SIGNATURE-----
