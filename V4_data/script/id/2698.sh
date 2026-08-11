#!/usr/bin/env playonlinux-bash
[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

WORKING_WINE_VERSION="1.7.14-NapoleonTotalWAR"
TITLE="Napoleon Total War (steam)"
PREFIX="Napoleon_Total_War"
SHORTCUT_NAME="Napoleon Total War"
STEAM_URL="http://store.steampowered.com/app/34030"


POL_SetupWindow_Init
POL_SetupWindow_SetID 2698
POL_Debug_Init
POL_SetupWindow_presentation "$TITLE" "The Creative Assembly" $STEAM_URL "Robin Karlsson" $PREFIX

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate "$WORKING_WINE_VERSION"

POL_Call POL_Install_steam



cd "$WINEPREFIX/drive_c/$PROGRAMFILES/Steam"
POL_Wine "steam.exe" steam://install/34030
POL_Wine_WaitExit "$TITLE"

POL_Shortcut "Napoleon.exe" "$SHORTCUT_NAME"

POL_SetupWindow_Close
exit
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEABECAAYFAlaJF5QACgkQ5TH6yaoTykfRQwCdFGgEQhgI5FLR/Uac6q9m3UL1
TLAAn0mt/7JMbfUU8+Kt4SmHVx2i0wKz
=Z1Ym
-----END PGP SIGNATURE-----
